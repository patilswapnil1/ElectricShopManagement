<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>Electric Shop Login</title>
<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

/* ===== BACKGROUND ===== */

body{
margin:0;
height:100vh;
font-family:'Segoe UI';

background:
linear-gradient(rgba(0,0,0,.75),rgba(0,0,0,.75)),
url("https://images.unsplash.com/photo-1509395176047-4a66953fd231");

background-size:cover;
background-position:center;
display:flex;
justify-content:center;
align-items:center;
overflow:hidden;
}

/* Electric Glow Animation */

body::before{
content:"";
position:absolute;
width:200%;
height:200%;
background:radial-gradient(circle,#00c6ff22,#0072ff22,transparent);
animation:rotate 20s linear infinite;
}

@keyframes rotate{
from{transform:rotate(0deg);}
to{transform:rotate(360deg);}
}

/* ===== LOGIN CARD ===== */

.login-card{
position:relative;
width:420px;
padding:45px;
background:rgba(255,255,255,0.08);
backdrop-filter:blur(15px);
border-radius:18px;
box-shadow:0 0 40px rgba(0,0,0,0.6);
color:white;
text-align:center;
z-index:10;
}

/* LOGO */

.logo{
font-size:50px;
color:#ffd700;
margin-bottom:10px;
text-shadow:0 0 15px #ffd700;
}

/* TITLE */

.login-card h3{
margin-bottom:25px;
font-weight:bold;
}

/* INPUT GROUP */

.input-group{
margin-bottom:20px;
}

.input-group-text{
background:#0072ff;
color:white;
border:none;
}

.form-control{
background:rgba(255,255,255,0.2);
border:none;
color:white;
}

.form-control::placeholder{
color:#eee;
}

/* BUTTON */

.btn-login{
background:linear-gradient(45deg,#00c6ff,#0072ff);
border:none;
font-weight:bold;
padding:12px;
transition:.4s;
}

.btn-login:hover{
transform:scale(1.05);
box-shadow:0 0 20px #00c6ff;
}

/* FOOTER */

.footer{
margin-top:15px;
font-size:14px;
opacity:.8;
}

</style>

</head>

<body>

<div class="login-card">

<div class="logo">⚡</div>

<h3>Electric Shop Management</h3>

<form action="LoginServlet" method="post">

<div class="input-group">
<span class="input-group-text">
<i class="fa fa-user"></i>
</span>
<input type="text"
name="username"
class="form-control"
placeholder="Username"
required>
</div>

<div class="input-group">
<span class="input-group-text">
<i class="fa fa-lock"></i>
</span>
<input type="password"
name="password"
class="form-control"
placeholder="Password"
required>
</div>

<button class="btn btn-login w-100">
<i class="fa fa-bolt"></i> Login
</button>

</form>

<div class="footer">
⚡ Smart Electric Shop Software
</div>

</div>

</body>
</html>