package shop;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/PurchaseServlet")
public class PurchaseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,
                          HttpServletResponse res)
            throws ServletException, IOException {

        try {

            // ✅ Get form data
            String product = req.getParameter("product");
            String company = req.getParameter("company");

            int qty = Integer.parseInt(req.getParameter("qty"));
            double price = Double.parseDouble(req.getParameter("price"));
            double gst = Double.parseDouble(req.getParameter("gst"));
            double net = Double.parseDouble(req.getParameter("net"));
            double sell = Double.parseDouble(req.getParameter("sell"));
            double margin = Double.parseDouble(req.getParameter("margin"));

            Connection con = DBConnection.getConnection();

            if(con == null){
                res.getWriter().println("Database Connection Failed");
                return;
            }

            // ✅ Insert Purchase Entry
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO purchase(product_name,company,qty,purchase_price,gst,net_amount,selling_price,margin,purchase_date) VALUES(?,?,?,?,?,?,?,?,?)"
            );

            ps.setString(1, product);
            ps.setString(2, company);
            ps.setInt(3, qty);
            ps.setDouble(4, price);
            ps.setDouble(5, gst);
            ps.setDouble(6, net);
            ps.setDouble(7, sell);
            ps.setDouble(8, margin);
            ps.setDate(9, Date.valueOf(LocalDate.now()));

            ps.executeUpdate();

            // ✅ STOCK UPDATE
            PreparedStatement stock = con.prepareStatement(
                "UPDATE products SET quantity = quantity + ? WHERE name = ?"
            );

            stock.setInt(1, qty);
            stock.setString(2, product);

            stock.executeUpdate();

            // ✅ Close resources
            stock.close();
            ps.close();
            con.close();

            // ✅ SUCCESS REDIRECT
            res.sendRedirect("stock.jsp?success=1");

        } catch (Exception e) {

            e.printStackTrace();

            res.setContentType("text/html");
            res.getWriter().println(
                "<h3 style='color:red'>Purchase Failed : "
                + e.getMessage() +
                "</h3>"
            );
        }
    }
}