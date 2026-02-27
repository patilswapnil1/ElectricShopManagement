package shop;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class UpdateStockServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

int id = Integer.parseInt(request.getParameter("id"));
int stock = Integer.parseInt(request.getParameter("stock"));

try{
Connection con = DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"update products set stock = stock + ? where id=?");

ps.setInt(1, stock);
ps.setInt(2, id);

ps.executeUpdate();

response.sendRedirect("stock.jsp");

}catch(Exception e){
e.printStackTrace();
}
}
}