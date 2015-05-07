<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String Folder=request.getParameter("folder");
Folder=Folder.replace(" ", "%20");
System.out.println(Folder);
session.setAttribute("FOLDER",Folder);
%>
<jsp:forward page="files.jsp"></jsp:forward>
</body>
</html>