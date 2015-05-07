<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser"%>
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

<title>Welcome</title>
<script type="text/javascript">
	function showModal()
	{
		$("#myModal").modal('show');
	}
	
	$(document).ready(function () {
	    $("input#submit").click(function(){
	        $.ajax({
	            type: "POST",
	            url: "ProcessFolder.jsp", //process to mail
	            data: $('form.createFolder').serialize(),
	            success: function(){
	                $("#myModal").modal('hide'); //hide popup  
	                location.reload();
	            },
	            error: function(){
	                alert("failure");
	            }
	        });
	    });
	});
</script>
<span class="glyphicon glyphicon-class-name"></span>

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
<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Add Folder</h4>
            </div>
            <div class="modal-body">
               <form class="createFolder" name="createFolder">
          	<label for="FolderName">Folder Name</label><br>
            <input type="text" name="FolderName" class="input-xlarge"><br>
        </form>
                
            </div>
            <div class="modal-footer">
                <input class="btn btn-success" type="submit" value="Create Folder" id="submit">
       			 <a href="#" class="btn" data-dismiss="modal">Cancel</a>
            </div>
        </div>
    </div>
</div>

<br />

<%
if (session.getAttribute("Token")==null)
{
%>
<jsp:forward page="index.jsp"></jsp:forward>

<%
}

%>
    <button type="submit" class="btn btn-primary" onClick="showModal()">Create Folder</button>
<%
//main.put("auth", auth);
// urlParameters=main.toString();  
//Create connection
URL url = new URL((String)session.getAttribute("Purl"));
HttpURLConnection connection = (HttpURLConnection)url.openConnection();
connection.setRequestMethod("GET");
//out.println(url.toString());
//out.println(session.getAttribute("Token"));
connection.setRequestProperty("X-Auth-Token",(String)session.getAttribute("Token"));
connection.setRequestProperty("Accept","*/*");
connection.setRequestProperty("Accept-Encoding","gzip,deflate,sdch");
//connection.setRequestProperty("Content-Type", 
//   "application/json");
	
//connection.setRequestProperty("Content-Length", "" + 
//       Integer.toString(urlParameters.getBytes().length));
connection.setRequestProperty("Content-Language", "en-US");
	
connection.setUseCaches (false);
connection.setDoInput(true);
connection.setDoOutput(true);

//Send request
/* 
wr = new DataOutputStream (
        connection.getOutputStream ());
wr.writeBytes (urlParameters);
wr.flush ();
wr.close ();
*/
//Get Response	
int rc=connection.getResponseCode();
if(rc==401)
{
	session.invalidate();
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<% 
}

InputStream is = connection.getInputStream();
//out.println(rc);
BufferedReader rd = new BufferedReader(new InputStreamReader(is));
StringBuffer res = new StringBuffer(); 
String line;
while((line = rd.readLine()) != null) {
res.append(line);
res.append('\n');
}
rd.close();

if(rc==204)
{
out.println("<h1>No Folders available</h1>");
}
else
{
String in = res.toString();
//out.println(in);
//jsonParser = new JSONParser();
//ob = (JSONObject)jsonParser.parse(in);
String Links=in;
out.println("</br> ");

out.println("</br> ");
%>

<table>
<col width="300">
<col width="80">
<%

for (String retval: Links.split("\n")){
out.println("<tr>");
String htmlFolder=retval.replace(" ", "%20");

%>
<%
out.println("<td><a href=CheckFolder.jsp?folder="+htmlFolder+">");
%>
<img src="images/OpenStack.png" height="40px" width="40px"> </img>
</a>
<%
out.println("<a href=CheckFolder.jsp?folder="+htmlFolder+">"+retval+"</a></td>");

out.println("<td><a href=DeleteFolder.jsp?folder="+htmlFolder+"><button type='input' class='btn btn-default'><span class='glyphicon glyphicon-trash'></span></button></a></td></tr>");

}
}


%>
 

</body>
</html>