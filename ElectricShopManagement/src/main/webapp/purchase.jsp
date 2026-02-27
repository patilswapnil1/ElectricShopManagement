<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<title>Purchase Entry</title>

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

/* FORM CARD */

.form-box{
background:white;
padding:30px;
border-radius:12px;
box-shadow:0 5px 20px rgba(0,0,0,0.2);
max-width:700px;
margin:auto;
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

/* PURCHASE CALCULATION */
function calculate(){

var price=document.getElementById("price").value;
var qty=document.getElementById("qty").value;
var gst=document.getElementById("gst").value;
var sell=document.getElementById("sell").value;

if(price==""||qty=="") return;

var total = price*qty;
var gstAmt = total*gst/100;
var net = total+gstAmt;

document.getElementById("net").value=net.toFixed(2);

if(sell!=""){
var margin = sell-price;
document.getElementById("margin").value=margin.toFixed(2);
}
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
<h5>Purchase Entry 🛒</h5>

<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>
</div>

<br>

<div class="form-box">

<form action="PurchaseServlet" method="post">

<div class="row g-3">

<div class="col-md-6">
<label class="form-label">Product</label>
<input type="text" name="product" class="form-control" required>
</div>

<div class="col-md-6">
<label class="form-label">Company</label>
<input type="text" name="company" class="form-control">
</div>

<div class="col-md-6">
<label class="form-label">Quantity</label>
<input type="number" id="qty" name="qty"
class="form-control" onkeyup="calculate()" required>
</div>

<div class="col-md-6">
<label class="form-label">Purchase Price</label>
<input type="number" id="price" name="price"
class="form-control" onkeyup="calculate()" required>
</div>

<div class="col-md-6">
<label class="form-label">GST %</label>
<input type="number" id="gst" name="gst"
value="18" class="form-control"
onkeyup="calculate()">
</div>

<div class="col-md-6">
<label class="form-label">Selling Price</label>
<input type="number" id="sell" name="sell"
class="form-control" onkeyup="calculate()">
</div>

<div class="col-md-6">
<label class="form-label">Net Amount</label>
<input type="text" id="net" name="net"
class="form-control" readonly>
</div>

<div class="col-md-6">
<label class="form-label">Margin</label>
<input type="text" id="margin" name="margin"
class="form-control" readonly>
</div>

</div>

<br>

<div class="text-center">
<button class="btn btn-success px-5">
💾 Save Purchase
</button>
</div>

</form>

</div>

</div>

</body>
</html>