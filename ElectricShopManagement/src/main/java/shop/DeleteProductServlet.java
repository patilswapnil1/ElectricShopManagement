package shop;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/DeleteProductServlet")   // ⭐ MUST ADD
public class DeleteProductServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

try{

int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement("delete from products where id=?");

ps.setInt(1,id);

ps.executeUpdate();

response.sendRedirect("viewProducts.jsp");

}catch(Exception e){
response.getWriter().println(e);
}
}
}