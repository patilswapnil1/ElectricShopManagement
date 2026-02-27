package shop;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/UpdateProductServlet")   // ⭐ VERY IMPORTANT
public class UpdateProductServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

try{

int id=Integer.parseInt(request.getParameter("id"));
String name=request.getParameter("name");
double price=Double.parseDouble(request.getParameter("price"));
int qty=Integer.parseInt(request.getParameter("quantity"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement(
"update products set name=?,price=?,quantity=? where id=?");

ps.setString(1,name);
ps.setDouble(2,price);
ps.setInt(3,qty);
ps.setInt(4,id);

ps.executeUpdate();

response.sendRedirect("viewProducts.jsp");

}catch(Exception e){
response.getWriter().println(e);
}

}
}