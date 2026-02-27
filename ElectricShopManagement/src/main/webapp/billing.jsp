<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.*,shop.DBConnection"%>

<!DOCTYPE html>
<html>
<head>
<title>Electric Shop Billing</title>

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

/* MAIN AREA */

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

/* BILL CARD */

.billing-card{
background:white;
padding:30px;
margin-top:20px;
border-radius:12px;
box-shadow:0px 0px 25px rgba(0,0,0,0.3);
max-width:600px;
margin-left:auto;
margin-right:auto;
}

.total-box{
font-size:20px;
font-weight:bold;
color:#198754;
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

/* PRICE AUTO */
function setPrice(price){
document.getElementById("price").value=price;
calculateTotal();
}

/* TOTAL CALCULATION */
function calculateTotal(){
var price=document.getElementById("price").value;
var qty=document.getElementById("qty").value;

if(price==""||qty=="") return;

document.getElementById("total").value=
(price*qty).toFixed(2);
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
<h5>🧾 Billing System</h5>

<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>
</div>

<div class="billing-card">

<h4 class="mb-4 text-center">Generate Bill</h4>

<form action="BillServlet" method="post">

<div class="mb-3">
<label>Customer Name</label>
<input type="text" name="customer"
class="form-control" required>
</div>

<div class="mb-3">
<label>Select Product</label>

<select name="productId"
class="form-select"
onchange="setPrice(this.options[this.selectedIndex].getAttribute('data-price'))"
required>

<option value="">Select Product</option>

<%
Connection con=DBConnection.getConnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from products");

while(rs.next()){
%>

<option
value="<%=rs.getInt("id")%>"
data-price="<%=rs.getDouble("price")%>">

<%=rs.getString("name")%>

</option>

<% } %>

</select>

</div>

<div class="mb-3">
<label>Price (₹)</label>
<input type="text" id="price"
name="price" class="form-control" readonly>
</div>

<div class="mb-3">
<label>Quantity</label>
<input type="number" id="qty"
name="qty" class="form-control"
onkeyup="calculateTotal()" required>
</div>

<div class="mb-3">
<label>Total Amount (₹)</label>
<input type="text" id="total"
name="total"
class="form-control total-box"
readonly>
</div>

<div class="d-grid">
<button class="btn btn-success btn-lg">
💰 Generate Bill
</button>
</div>

</form>

</div>

</div>

</body>
</html>