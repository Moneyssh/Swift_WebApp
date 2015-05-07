<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String Folder=request.getParameter("FolderName");
Folder=Folder.replace(" ","%20");
String urlParameters;
System.out.println(Folder);
String PublicURL=(String)session.getAttribute("Purl");
String ID=(String)session.getAttribute("Token");
String url1=PublicURL+"/"+Folder;
URL url;
HttpURLConnection connection = null;  
try {  
  //Create connection
  url = new URL(url1);
  connection = (HttpURLConnection)url.openConnection();
  connection.setRequestMethod("PUT");
  connection.setRequestProperty("X-Auth-Token",ID);
  connection.setRequestProperty("Content-Type","application/json");
  connection.setRequestProperty("Accept","*/*");
  connection.setRequestProperty("Content-Language", "en-US");  
			
  connection.setUseCaches (false);
  connection.setDoInput(true);
  connection.setDoOutput(true);
  int rc=connection.getResponseCode();
  String res=connection.getResponseMessage();
  
  System.out.println(rc);
  System.out.println(res);
  connection.disconnect(); 
} catch (Exception e) {

    e.printStackTrace();

  } 
%>
<jsp:forward page="Dashboard.jsp"></jsp:forward>
</body>
</html>