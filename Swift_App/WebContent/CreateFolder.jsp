<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
  
<form method="post" action="ProcessFolder.jsp">
    <label >Folder Name</label>

        <input type="text" name="FolderName" id="FolderName" >
    <button type="submit">Create Folder</button>
</form>  
  
</body>
</html>