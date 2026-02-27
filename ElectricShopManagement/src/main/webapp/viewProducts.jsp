<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*,shop.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
<title>Products | Electric Shop</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
margin:0;
font-family:Segoe UI;
}

/* SIDEBAR */

.sidebar{
width:240px;
height:100vh;
position:fixed;
background:#111827;
color:white;
padding-top:20px;
}

.sidebar h4{
text-align:center;
margin-bottom:30px;
}

.sidebar a{
display:block;
color:white;
padding:12px 20px;
text-decoration:none;
transition:.3s;
}

.sidebar a:hover{
background:#1f2937;
padding-left:28px;
}

/* MAIN */

.main{
margin-left:240px;
min-height:100vh;
background:linear-gradient(to bottom,#294c8e,#365da5);
padding:20px;
}

/* TOPBAR */

.topbar{
background:#e5e7eb;
padding:12px 20px;
border-radius:10px;
display:flex;
justify-content:space-between;
align-items:center;
}

/* CARD */

.container-box{
background:white;
padding:30px;
margin-top:20px;
border-radius:12px;
box-shadow:0px 0px 15px rgba(0,0,0,0.3);
}

</style>

<script>

/* LIVE CLOCK */
function startTime(){
let now=new Date();
document.getElementById("clock").innerHTML=
now.toLocaleTimeString();
setTimeout(startTime,1000);
}

</script>

</head>

<body onload="startTime()">

<!-- SIDEBAR -->

<div class="sidebar">

<h4>⚡ Electric Shop</h4>

<a href="dashboard.jsp">🏠 Dashboard</a>
<a href="addProduct.jsp">📦 Add Product</a>
<a href="viewProducts.jsp">📋 Products List</a>
<a href="stock.jsp">🏬 Stock</a>
<a href="purchase.jsp">🛒 Purchase</a>
<a href="billing.jsp">🧾 Billing</a>
<a href="salesReport.jsp">📈 Reports</a>

</div>

<!-- MAIN -->

<div class="main">

<div class="topbar">
<h5>📋 Product Management</h5>

<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>
</div>

<div class="container-box">

<a href="addProduct.jsp" class="btn btn-success mb-3">
➕ Add New Product
</a>

<table class="table table-striped table-hover text-center align-middle">

<thead class="table-dark">
<tr>
<th>ID</th>
<th>Product Name</th>
<th>Price (₹)</th>
<th>Stock Qty</th>
<th>Action</th>
</tr>
</thead>

<tbody>

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select * from products");

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><b><%=rs.getString("name")%></b></td>

<td>₹ <%=rs.getDouble("price")%></td>

<td>

<%
int qty = rs.getInt("quantity");

if(qty <= 5){
%>
<span class="badge bg-danger">⚠ <%=qty%> Low</span>
<%
}else{
%>
<span class="badge bg-success"><%=qty%></span>
<%
}
%>

</td>

<td>

<a href="editProduct.jsp?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm">
✏ Edit
</a>

<a href="DeleteProductServlet?id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete this product?')">
🗑 Delete
</a>

</td>

</tr>

<% } %>

</tbody>

</table>

</div>

</div>

</body>
</html>