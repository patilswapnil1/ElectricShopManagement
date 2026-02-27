<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,shop.DBConnection"%>

<%
int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=
con.prepareStatement("select * from products where id=?");

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();
rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Product</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:linear-gradient(135deg,#1e3c72,#2a5298);
    font-family:'Segoe UI';
}

/* Card Design */
.form-card{
    width:420px;
    margin:60px auto;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0px 0px 20px rgba(0,0,0,0.3);
}

.title{
    text-align:center;
    margin-bottom:25px;
    font-weight:bold;
}

.btn-update{
    width:100%;
}

</style>

</head>

<body>

<div class="form-card">

<h3 class="title">✏ Edit Product</h3>

<form action="UpdateProductServlet" method="post">

<input type="hidden" name="id"
value="<%=rs.getInt("id")%>">

<div class="mb-3">
<label class="form-label">Product Name</label>
<input type="text" name="name"
class="form-control"
value="<%=rs.getString("name")%>" required>
</div>

<div class="mb-3">
<label class="form-label">Price (₹)</label>
<input type="number" name="price"
class="form-control"
value="<%=rs.getDouble("price")%>" required>
</div>

<div class="mb-3">
<label class="form-label">Quantity</label>
<input type="number" name="quantity"
class="form-control"
value="<%=rs.getInt("quantity")%>" required>
</div>

<button type="submit"
class="btn btn-success btn-update">
✅ Update Product
</button>

<br><br>

<a href="viewProducts.jsp"
class="btn btn-secondary w-100">
⬅ Back to Products
</a>

</form>

</div>

</body>
</html>