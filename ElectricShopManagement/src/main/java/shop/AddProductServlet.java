package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws IOException {

String name = request.getParameter("name");
int price = Integer.parseInt(request.getParameter("price"));
int qty = Integer.parseInt(request.getParameter("qty"));

try{

Connection con = DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"insert into products(name,price,quantity) values(?,?,?)");

ps.setString(1,name);
ps.setInt(2,price);
ps.setInt(3,qty);

ps.executeUpdate();

response.sendRedirect("viewProducts.jsp");

}
catch(Exception e){
e.printStackTrace();
}
}
}