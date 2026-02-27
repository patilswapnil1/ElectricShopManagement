<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.sql.*,shop.DBConnection"%>

<%
Connection con = DBConnection.getConnection();

/* ===== TODAY SALE ===== */
PreparedStatement todayPs =
con.prepareStatement(
"SELECT IFNULL(SUM(total),0) FROM bills WHERE DATE(bill_date)=CURDATE()");
ResultSet todayRs = todayPs.executeQuery();

double todaySale=0;
if(todayRs.next()) todaySale=todayRs.getDouble(1);

/* ===== MONTH SALE ===== */
PreparedStatement monthPs =
con.prepareStatement(
"SELECT IFNULL(SUM(total),0) FROM bills WHERE MONTH(bill_date)=MONTH(CURDATE()) AND YEAR(bill_date)=YEAR(CURDATE())");
ResultSet monthRs = monthPs.executeQuery();

double monthSale=0;
if(monthRs.next()) monthSale=monthRs.getDouble(1);
%>

<!DOCTYPE html>
<html>
<head>
<title>Sales Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{margin:0;font-family:Segoe UI;}

.sidebar{
width:240px;height:100vh;position:fixed;
background:#111827;color:white;padding-top:20px;
}

.sidebar h4{text-align:center;margin-bottom:30px;}

.sidebar a{
display:block;color:white;padding:12px 20px;
text-decoration:none;transition:.3s;
}

.sidebar a:hover{background:#1f2937;padding-left:28px;}

.main{
margin-left:240px;
min-height:100vh;
background:linear-gradient(to bottom,#294c8e,#365da5);
padding:20px;
}

.topbar{
background:#e5e7eb;padding:12px 20px;
border-radius:10px;
display:flex;justify-content:space-between;
}

.card-box{
background:white;border-radius:12px;
padding:25px;text-align:center;
box-shadow:0 5px 20px rgba(0,0,0,.2);
}

.table-box{
background:white;padding:20px;
border-radius:12px;margin-top:25px;
box-shadow:0 5px 20px rgba(0,0,0,.2);
}
</style>

<script>
function startTime(){
document.getElementById("clock").innerHTML =
new Date().toLocaleTimeString();
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
<a href="billing.jsp">🧾 Billing</a>
<a href="salesReport.jsp">📈 Reports</a>
</div>

<!-- MAIN -->
<div class="main">

<div class="topbar">
<h5>Sales Report 📊</h5>
<div>
<span id="clock"></span>
<a href="login.jsp" class="btn btn-danger btn-sm ms-3">Logout</a>
</div>
</div>

<br>

<!-- SALES CARDS -->
<div class="row g-4">

<div class="col-md-6">
<div class="card-box">
<h5>🔥 Today's Sale</h5>
<h2>₹ <%=todaySale%></h2>
</div>
</div>

<div class="col-md-6">
<div class="card-box">
<h5>📅 Monthly Sale</h5>
<h2>₹ <%=monthSale%></h2>
</div>
</div>

</div>

<!-- SALES TABLE -->
<div class="table-box">

<h4 class="mb-3">All Sales</h4>

<table class="table table-striped table-hover">
<thead class="table-dark">
<tr>
<th>Bill ID</th>
<th>Customer</th>
<th>Product</th>
<th>Qty</th>
<th>Total</th>
<th>Date</th>
</tr>
</thead>

<tbody>

<%
PreparedStatement sales =
con.prepareStatement(
"SELECT b.id,b.customer_name,i.product_name,i.quantity,i.total,b.bill_date " +
"FROM bills b JOIN bill_items i ON b.id=i.bill_id ORDER BY b.id DESC");

ResultSet rs = sales.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("customer_name")%></td>
<td><%=rs.getString("product_name")%></td>
<td><%=rs.getInt("quantity")%></td>
<td>₹ <%=rs.getDouble("total")%></td>
<td><%=rs.getTimestamp("bill_date")%></td>
</tr>

<% } %>

</tbody>
</table>

</div>

</div>

</body>
</html>