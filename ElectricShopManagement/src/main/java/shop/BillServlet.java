package shop;

import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class BillServlet extends HttpServlet {

protected void doPost(HttpServletRequest req,
HttpServletResponse res)
throws ServletException, IOException {

res.setContentType("text/html;charset=UTF-8");
PrintWriter out = res.getWriter();

String customer = req.getParameter("customer");
int pid = Integer.parseInt(req.getParameter("productId"));
double price = Double.parseDouble(req.getParameter("price"));
int qty = Integer.parseInt(req.getParameter("qty"));
double total = Double.parseDouble(req.getParameter("total"));

SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
String today = sdf.format(new Date());

try{

Connection con = DBConnection.getConnection();

/* ===== GET PRODUCT NAME ===== */

PreparedStatement getProduct =
con.prepareStatement("SELECT name FROM products WHERE id=?");

getProduct.setInt(1,pid);
ResultSet rs = getProduct.executeQuery();

String product="";
if(rs.next()){
product = rs.getString("name");
}

/* ===== SAVE BILL (MAIN TABLE) ===== */

PreparedStatement billPs =
con.prepareStatement(
"INSERT INTO bills(customer_name,total) VALUES(?,?)",
Statement.RETURN_GENERATED_KEYS);

billPs.setString(1,customer);
billPs.setDouble(2,total);

billPs.executeUpdate();

/* ===== GET GENERATED BILL ID ===== */

ResultSet billRs = billPs.getGeneratedKeys();
int billId=0;
if(billRs.next()){
billId = billRs.getInt(1);
}

/* ===== SAVE BILL ITEMS ===== */

PreparedStatement itemPs =
con.prepareStatement(
"INSERT INTO bill_items(bill_id,product_name,quantity,price,total) VALUES(?,?,?,?,?)");

itemPs.setInt(1,billId);
itemPs.setString(2,product);
itemPs.setInt(3,qty);
itemPs.setDouble(4,price);
itemPs.setDouble(5,total);

itemPs.executeUpdate();

/* ===== REDUCE STOCK (quantity column) ===== */

PreparedStatement updateStock =
con.prepareStatement(
"UPDATE products SET quantity=quantity-? WHERE id=?");

updateStock.setInt(1,qty);
updateStock.setInt(2,pid);

updateStock.executeUpdate();

/* ===== MODERN BILL UI ===== */

out.println("<html>");
out.println("<head><title>Invoice</title>");
out.println("<style>");
out.println("body{background:#eef2f7;font-family:Segoe UI;padding:20px;}");
out.println(".invoice{width:720px;margin:auto;background:white;padding:30px;border-radius:12px;box-shadow:0 0 25px rgba(0,0,0,0.15);}");
out.println(".header{display:flex;justify-content:space-between;border-bottom:2px solid #eee;padding-bottom:15px;}");
out.println(".shop{font-size:26px;font-weight:bold;color:#1e3c72;}");
out.println("table{width:100%;margin-top:25px;border-collapse:collapse;}");
out.println("th{background:#1e3c72;color:white;padding:12px;}");
out.println("td{padding:12px;text-align:center;border-bottom:1px solid #ddd;}");
out.println(".total{margin-top:25px;text-align:right;font-size:22px;font-weight:bold;color:#198754;}");
out.println("</style></head><body>");

out.println("<div class='invoice'>");

out.println("<div class='header'>");
out.println("<div><div class='shop'>⚡ Electric Shop</div></div>");
out.println("<div><b>Date :</b> "+today+"</div>");
out.println("</div>");

out.println("<p><b>Customer :</b> "+customer+"</p>");

out.println("<table>");
out.println("<tr><th>Product</th><th>Price</th><th>Quantity</th><th>Total</th></tr>");
out.println("<tr>");
out.println("<td>"+product+"</td>");
out.println("<td>₹ "+price+"</td>");
out.println("<td>"+qty+"</td>");
out.println("<td>₹ "+total+"</td>");
out.println("</tr>");
out.println("</table>");

out.println("<div class='total'>Grand Total : ₹ "+total+"</div>");

out.println("<center><br><button onclick='window.print()'>🖨 Print Invoice</button></center>");

out.println("</div>");
out.println("</body></html>");

}catch(Exception e){
e.printStackTrace();
out.println("<h3>Error : "+e.getMessage()+"</h3>");
}
}
}