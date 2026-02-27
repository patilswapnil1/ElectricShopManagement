<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.*,shop.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
<title>Stock Management</title>

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

.main-card{
background:white;
padding:30px;
margin-top:20px;
border-radius:12px;
box-shadow:0px 0px 20px rgba(0,0,0,0.3);
}

.low-stock{
color:white;
background:red;
padding:6px 12px;
border-radius:6px;
}

.good-stock{
color:white;
background:green;
padding:6px 12px;
border-radius:6px;
}

</style>

<script>
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

<!-- MAIN AREA -->

<div class="main">

<div class="topbar">
<h5>📦 Stock Management</h5>

<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>
</div>

<div class="main-card">

<table class="table table-bordered table-hover text-center align-middle">

<thead class="table-dark">
<tr>
<th>ID</th>
<th>Product</th>
<th>Stock</th>
<th>Add Stock</th>
</tr>
</thead>

<tbody>

<%
Connection con = DBConnection.getConnection();

if(con==null){
out.println("<h4 style='color:red'>Database Connection Failed</h4>");
return;
}

PreparedStatement ps =
con.prepareStatement("select * from products");

ResultSet rs = ps.executeQuery();

while(rs.next()){

// ✅ IMPORTANT FIX
int stock = rs.getInt("quantity");
%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><b><%=rs.getString("name")%></b></td>

<td>

<% if(stock<=5){ %>
<span class="low-stock">⚠ LOW (<%=stock%>)</span>
<% } else { %>
<span class="good-stock">✅ <%=stock%></span>
<% } %>

</td>

<td>

<form action="UpdateStockServlet"
method="post"
class="d-flex justify-content-center gap-2">

<input type="hidden" name="id"
value="<%=rs.getInt("id")%>">

<input type="number"
name="stock"
class="form-control"
style="width:120px"
placeholder="Qty"
required>

<button class="btn btn-success">
➕ Add
</button>

</form>

</td>

</tr>

<% } %>

</tbody>

</table>

</div>

</div>

</body>
</html>