<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser" %>
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
<script type="text/javascript">
function validate()
{
var fname=document.getElementById("fileName").value;	
var ok=true;
if ( 0 === fname.length)
{
ok=false;
alert("Choose File");
}


	
return ok;
}
	function showModal()
	{
		$("#myModal").modal('show');
	}
	
	$(document).ready(function () {
	    $("input#submit").click(function(){
	       
	                $("#myModal").modal('hide'); //hide popup  
	              //  location.reload();
	        
	    });
	});
</script>
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
<title>Insert title here</title>
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
               <form class="addFile" name="addFile" action="UploadFileServlet" onsubmit="return validate()" method="post" enctype="multipart/form-data">
          	Select File to Upload:<br>
          	<input type="file" name="fileName" id="fileName"><br>
          	<input class="btn btn-success" type="submit" value="Add File" id="submit">
          	<a href="#" class="btn" data-dismiss="modal">Cancel</a>
        </form>
                
            </div>
        </div>
    </div>
</div>

<br />
 <button type="submit" class="btn btn-primary" onClick="showModal()">Add File</button>
<%
String Folder=(String)session.getAttribute("FOLDER");
String PublicURL=(String)session.getAttribute("Purl");
String ID=(String)session.getAttribute("Token");
//out.println(PublicURL);
//out.println(ID);


URL url;
HttpURLConnection connection=null;

try
{
	
url=new URL(PublicURL+"/"+Folder);
//System.out.println(url.toString());
connection= (HttpURLConnection)url.openConnection();
connection.setRequestMethod("GET");
connection.setRequestProperty("X-Auth-Token",ID);
connection.setRequestProperty("Accept","*/*");
connection.setRequestProperty("Content-Language", "en-US");  
		
connection.setUseCaches (false);
connection.setDoInput(true);
connection.setDoOutput(true);

//Get Response	
InputStream is = connection.getInputStream();
int rc=connection.getResponseCode();
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
	out.println("<h1>No Files available</h1>");
         }
else
{
String in = res.toString();
//out.println(in);
//jsonParser = new JSONParser();
//ob = (JSONObject)jsonParser.parse(in);
String Links=in;
%>
	<table>
	  <col width="300">
      <col width="80">
	<%
for (String retval: Links.split("\n")){
	out.println("<tr>");
	String htmlFolder=Folder.replace(" ", "%20");
	String htmlFile=retval.replace(" ", "%20");
	System.out.println(htmlFile);
	%>
	<%
    out.println("<td><a href=Download.jsp?folder="+htmlFolder+"&file="+htmlFile+">"+retval+"</a></td>");
   
    out.println("<td><a href=DeleteFile.jsp?file="+htmlFile+"><button type='input' class='btn btn-default'><span class='glyphicon glyphicon-trash'></span></button></a></td></tr>");

    }
%>
</table>
<% 
}
} catch (Exception e) {

    e.printStackTrace();

  } finally {

    if(connection != null) {
      connection.disconnect(); 
    }
  }
%>

</form>  
</body>
</html>