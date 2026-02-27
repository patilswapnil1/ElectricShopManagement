<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,shop.DBConnection" %>

<%
Connection con = null;
Statement st = null;

int totalProducts = 0;
int totalQty = 0;
double stockValue = 0;

try{

con = DBConnection.getConnection();
st = con.createStatement();

/* TOTAL PRODUCTS */
ResultSet p = st.executeQuery("select count(*) from products");
if(p.next()) totalProducts = p.getInt(1);

/* TOTAL STOCK QTY */
ResultSet q = st.executeQuery("select IFNULL(sum(quantity),0) from products");
if(q.next()) totalQty = q.getInt(1);

/* STOCK VALUE */
ResultSet v = st.executeQuery("select IFNULL(sum(price*quantity),0) from products");
if(v.next()) stockValue = v.getDouble(1);

}catch(Exception e){
out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

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
transition:0.3s;
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

/* TOP BAR */

.topbar{
background:#e5e7eb;
padding:12px 20px;
border-radius:10px;
display:flex;
justify-content:space-between;
align-items:center;
}

/* CARDS */

.card-box{
background:white;
border-radius:12px;
padding:30px;
text-align:center;
box-shadow:0 5px 20px rgba(0,0,0,0.2);
transition:0.3s;
}

.card-box:hover{
transform:translateY(-5px);
}

.card-box h2{
margin-top:10px;
font-weight:bold;
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

<a href="addProduct.jsp">📦 Add Product</a>
<a href="viewProducts.jsp">📋 Products List</a>
<a href="stock.jsp">🏬 Stock</a>
<a href="purchase.jsp">🛒 purchase entry</a>
<a href="billing.jsp">🧾 Billing</a>
<a href="salesReport.jsp">📈 Reports</a>

</div>

<!-- MAIN -->
<div class="main">

<div class="topbar">
<h5>Welcome Admin 👋</h5>

<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>

</div>

<br>

<div class="row g-4">

<div class="col-md-4">
<div class="card-box">
<h5>📦 Total Products</h5>
<h2><%=totalProducts%></h2>
</div>
</div>

<div class="col-md-4">
<div class="card-box">
<h5>💰 Total Stock Value</h5>
<h2>₹ <%=stockValue%></h2>
</div>
</div>

<div class="col-md-4">
<div class="card-box">
<h5>📚 Total Stock Quantity</h5>
<h2><%=totalQty%></h2>
</div>
</div>

</div>

</div>

</body>
</html>