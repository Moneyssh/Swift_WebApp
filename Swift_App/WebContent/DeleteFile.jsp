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
String PublicURL=(String)session.getAttribute("Purl");
String ID=(String)session.getAttribute("Token");
String FOLDER=(String)session.getAttribute("FOLDER");
String FILE=(String)request.getParameter("file");

FILE=FILE.replace(" ","%20");
FOLDER=FOLDER.replace(" ","%20");
String requestURL=PublicURL+"/"+FOLDER+"/"+FILE;
 URL url ;
 HttpURLConnection connection=null;
System.out.println(FOLDER);
System.out.println(FILE);



try{
 	url = new URL(requestURL);
 	connection = (HttpURLConnection) url.openConnection();
	connection.setRequestMethod("DELETE");
	
	connection.setRequestProperty("X-Auth-Token",ID);
	connection.setRequestProperty("Content-Type","application/json");
	connection.setRequestProperty("Content-Language", "en-US");  
	connection.setUseCaches(false);
	connection.setDoOutput(true); 
	connection.setDoInput(true);
    
 	int rc=connection.getResponseCode();
 	//out.println(rc);
 	 if(rc==204)
 	  {
 		 %>
 		 <script>
    alert('File Deleted Successfully');
    window.location ='files.jsp';
      </script>
 		<% 
 	  }
 	  else
 	  {
 		%>
 		  <script>
 		  alert('Failed');
           window.location ='files.jsp';
           </script>
 		<% 
 		 
 	  }
   }catch (Exception e) {

        e.printStackTrace();

  		} finally {

    if(connection != null) {
      connection.disconnect(); 
       }
  		}


%>

</body>
</html>