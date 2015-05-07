<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*" import="java.security.AccessController" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/jquery.gridster.min.css" rel="stylesheet"/>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<header>     
               <div class="container">
                    <h3 class="pull-left">
                        <a href='Dashboard.jsp'>OpenStack - MSRIT</a>                        
                    </h3>                              
                  <h3 class="pull-left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Welcome <%=session.getAttribute("username")%></h3>
                    <ul class="nav nav-pills pull-right">
                        <li class="active"><a href="Dashboard.jsp">Home</a></li>
                        <li><a href="logout.jsp">Logout!</a></li>
                    </ul> 
                </div>
            </header>
</head>
<body>
<%

String Folder=request.getParameter("folder");
Folder=Folder.replace(" ","%20");
String File=request.getParameter("file");
File=File.replace(" ","%20");
String PublicURL=(String)session.getAttribute("Purl");
String ID=(String)session.getAttribute("Token");
//out.println(PublicURL);
//out.println(ID);

String Folder1=Folder.replace("%20"," ");
String user=(String)session.getAttribute("username");
String saveDir="C:/uploads/"+user+"/"+Folder1+"/";
File f = new File(saveDir);
if(!f.exists())
f.mkdirs();
String fileURL=PublicURL+"/"+Folder+"/"+File;
System.out.println(fileURL);
URL url = new URL(fileURL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("X-Auth-Token",ID);
        connection.setRequestProperty("Accept","*/*");
        
        
        
        int responseCode = connection.getResponseCode();
        System.out.println("\n"+responseCode); 
        // always check HTTP response code first
        if (responseCode == HttpURLConnection.HTTP_OK) {
            String fileName = "";
            String disposition = connection.getHeaderField("Content-Disposition");
            String contentType = connection.getContentType();
            int contentLength = connection.getContentLength();
 
            System.out.println("Content-Type = " + contentType);
            System.out.println("Content-Disposition = " + disposition);
            System.out.println("Content-Length = " + contentLength);
            System.out.println("<br /> Downloading");
            // opens input stream from the HTTP connection
            InputStream inputStream = connection.getInputStream();
            
            fileName=File.replace("%20"," ");
            String a=saveDir+fileName;
            System.out.println(a);
            // opens an output stream to save into file
            FileOutputStream outputStream = new FileOutputStream(a);
 
            int bytesRead = -1;
            byte[] buffer = new byte[4096];
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
 
            outputStream.close();
            inputStream.close();
           // out.println("<br />File downloaded");
            //System.out.println("<a href=DownloadFileServlet?fileName="+File+"user="+user+"folder="+Folder+">Download "+fileName+"</a>");
           out.println("<center><br /><br />");
            out.println("<h3><a href=DownloadFileServlet?fileName="+File+"&user="+user+"&folder="+Folder+">Download "+fileName+"</a></h3>");
            out.println("</center>");
        } else {
            out.println("<br />No file to download. Server replied HTTP code: " + responseCode);
        }
          out.println("<br />");
   		  out.println("<a href=Dashboard.jsp>Go Back To Home Directory</a>");
   	
        connection.disconnect();
    %>
</body>
</html>