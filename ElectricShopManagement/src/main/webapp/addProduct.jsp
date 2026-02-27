<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<title>Add Product | Electric Shop</title>

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

/* CARD */

.card-box{
background:white;
border-radius:12px;
padding:30px;
box-shadow:0 5px 20px rgba(0,0,0,.2);
width:450px;
margin:40px auto;
}

.btn-custom{
background:#198754;
color:white;
}

.btn-custom:hover{
background:#146c43;
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
<h5>📦 Add New Product</h5>

<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>
</div>

<div class="card-box">

<form action="AddProductServlet" method="post">

<div class="mb-3">
<label>Product Name</label>
<input type="text" name="name"
class="form-control" required>
</div>

<div class="mb-3">
<label>Price (₹)</label>
<input type="number" name="price"
class="form-control" required>
</div>

<div class="mb-3">
<label>Quantity</label>
<input type="number" name="qty"
class="form-control" required>
</div>

<button class="btn btn-custom w-100">
💾 Add Product
</button>

</form>

</div>

</div>

</body>
</html>