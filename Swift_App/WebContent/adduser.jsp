<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a user to the system</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/jquery.gridster.min.css" rel="stylesheet"/>

<script type="text/javascript">
function validate()
{
var pass1=document.getElementById("pass1").value;	
var pass2=document.getElementById("pass2").value;	
var uname=document.getElementById("uname").value;
var name=document.getElementById("name").value;
var ok=true;
if (!pass1 || 0 === pass1.length || !pass2 || 0 === pass2.length)
{
ok=false;
alert("Password Empty");
}

if (!uname || 0 === uname.length)
{
ok=false;
	alert("Please enter a usename");	
}
if (!name || 0 === name.length)
{
ok=false;
	alert("Please enter your name");	
}

if (pass1!=pass2 || pass1.length<6){
	alert("Passwords dont match, or insufficient length!");
	document.getElementById("pass1").style.borderColor = "#E34234";
    document.getElementById("pass2").style.borderColor = "#E34234";
    ok=false;
	}
	
return ok;
}
</script>
</head>
<body>
			<header>     
               <div class="container">
                    <h3 class="pull-left">
                        <a href='index.jsp'>Openstack - MSRIT</a>                        
                    </h3>                                        
                    <ul class="nav nav-pills pull-right">
                        <li class="active"><a href="index.jsp">Home</a></li>
                        </ul> 
                </div>
            </header>
<h1><center>Add User</center></h1>
<br/>
<br/>
<center>
<div style="width:30%">
<form action="processUser.jsp" onsubmit="return validate()" method="post">

 <div class="form-group">

        <label for="name">Name</label>

        <input type="text" class="form-control" name="name" id="name" placeholder="Name">

    </div>

 <div class="form-group">

        <label for="uname">Username</label>

        <input type="text" class="form-control" name="uname" id="uname" placeholder="UserName">

    </div>

 <div class="form-group">

        <label for="pass1">Password</label>

        <input type="password" class="form-control" name="pass1" id="pass1" placeholder="Password">

    </div>
    
 <div class="form-group">

        <label for="pass2">Confirm Password</label>

        <input type="password" class="form-control" name="pass2 "id="pass2" placeholder="Confirm Password">

    </div>

 <div class="form-group">

        <label for="email">E-Mail</label>

        <input type="text" class="form-control" name="email" id="email" placeholder="Enter your Email">

    </div>

<br/>

<button type="submit" class="btn btn-primary">Add User</button>
</form>
</div>
</center>
</body>
</html>