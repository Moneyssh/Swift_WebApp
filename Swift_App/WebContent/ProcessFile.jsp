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
String FILE=(String)request.getAttribute("UploadFile");
String FilePath="C:/uploads/"+FILE;
FILE=FILE.replace(" ","%20");
FOLDER=FOLDER.replace(" ","%20");
String requestURL=PublicURL+"/"+FOLDER+"/"+FILE;
 URL url ;
 HttpURLConnection connection=null;
System.out.println(FOLDER);
System.out.println(FILE);
System.out.println(FilePath);


//File file =new File(FilePath);
//String path=file.getAbsolutePath();
//out.println(path);
//System.out.println(file.length());
//String length=Objects.toString(file.length());


try{
 	url = new URL(requestURL);
 	connection = (HttpURLConnection) url.openConnection();
 	String boundary = "===" + System.currentTimeMillis() + "===";
	connection.setRequestProperty("Content-Type","multipart/form-data; boundary=" + boundary);
	connection.setRequestMethod("PUT");
	
	connection.setRequestProperty("X-Auth-Token",ID);
	// connection.setRequestProperty("Content-Type","application/json");
	 connection.setRequestProperty("Content-Length","0");
	connection.setRequestProperty("Content-Language", "en-US");  
	connection.setUseCaches(false);
	connection.setDoOutput(true); // indicates POST method
	connection.setDoInput(true);

	OutputStream outputStream = connection.getOutputStream();

	 FileInputStream inputStream = new FileInputStream(FilePath);
     byte[] buffer = new byte[4096];
     int bytesRead = -1;
     while ((bytesRead = inputStream.read(buffer)) != -1) {
         outputStream.write(buffer, 0, bytesRead);
     }
     outputStream.flush();
     inputStream.close();
    
 	int rc=connection.getResponseCode();
 	//out.println(rc);
 	File file = new File(FilePath);
    file.delete();
 	 if(rc==201)
 	  {
 		 %>
 		 <script>
    alert('File Added Successfully');
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