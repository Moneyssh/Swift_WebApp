<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/jquery.gridster.min.css" rel="stylesheet"/>

</head>
<body>
<%
if (session.getAttribute("Token")!=null)
{
%>
	 <jsp:forward page="Dashboard.jsp" />
<%
}
%>

			<header>     
               <div class="container">
                    <h3 class="pull-left">
                        <a href='Welcome.jsp'>OpenStack - MSRIT</a>                        
                    </h3>                                        
                    <ul class="nav nav-pills pull-right">
                        <li class="active"><a href="index.jsp">Home</a></li>
                    </ul> 
                </div>
            </header>
<h1><center>Please Identify Yourself</center></h1>
<br/>
<br/>
<center>
<div style="width:25%" >
<form method="post" action="login.jsp">

    <div class="form-group">

        <label for="username">Username</label>

        <input type="text" class="form-control" name="username" id="username" placeholder="Username">

    </div>

    <div class="form-group">

        <label for="pass">Password</label>

        <input type="password" class="form-control" name="pass" id="pass" placeholder="Password">

    </div>
<br/>

    <button type="submit" class="btn btn-primary">Login</button>
 	<a href="adduser.jsp" class="btn btn-primary">Sign Up</a>
</form>
</div>
</center>

</body>
</html>