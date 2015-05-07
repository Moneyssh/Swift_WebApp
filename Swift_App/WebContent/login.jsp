<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Processing.. please wait</title>
</head>
<body>
<%

String username=request.getParameter("username");
String password=request.getParameter("pass");
session.setAttribute("username", username);

JSONObject passwordCredentials = new JSONObject();
passwordCredentials.put("username",username);
passwordCredentials.put("password",password);

JSONObject user=new JSONObject();
user.put("tenantName", username);
user.put("passwordCredentials",passwordCredentials);

JSONObject auth=new JSONObject();
auth.put("auth",user);

String urlParameters;
//String targetURL="http://192.168.0.15:5000/v2.0/tokens";


URL url;
HttpURLConnection connection = null;  
try {  
  //Create connection
  urlParameters=auth.toString();
  url = new URL("http://192.168.0.15:5000/v2.0/tokens");
  connection = (HttpURLConnection)url.openConnection();
  connection.setRequestMethod("POST");

  connection.setRequestProperty("Content-Type", 
       "application/json");
			
  connection.setRequestProperty("Content-Length", "" + 
           Integer.toString(urlParameters.getBytes().length));
  connection.setRequestProperty("Content-Language", "en-US");  
			
  connection.setUseCaches (false);
  connection.setDoInput(true);
  connection.setDoOutput(true);

  //Send request
  DataOutputStream wr = new DataOutputStream (
              connection.getOutputStream ());
  wr.writeBytes (urlParameters);
  wr.flush ();
  wr.close ();

  int rc=connection.getResponseCode();
  if (rc==401)
  {
	 
	 %>
	 <script>
    alert('Login Failed');
    window.location = 'index.jsp';
 </script>
	 <!--  <script type="text/javascript">alert("Login Failed");</script> -->
	<%  
  }
  //Get Response
  InputStream is = connection.getInputStream();
  BufferedReader rd = new BufferedReader(new InputStreamReader(is));
  String line;
  StringBuffer res = new StringBuffer(); 
  while((line = rd.readLine()) != null) {
    res.append(line);
    res.append('\r');
  }
  rd.close();
  
  String in = res.toString();
  String in1=in;
  //out.println(in);
  JSONParser jsonParser = new JSONParser();
  JSONObject ob = (JSONObject)jsonParser.parse(in);
  ob = (JSONObject)ob.get("access");
  ob = (JSONObject)ob.get("token");
  String Userid = ob.get("id").toString();
  System.out.println("UserID="+Userid+"\n");
  
  
  ob = (JSONObject)jsonParser.parse(in);
 // out.println(ob.toString());
  ob = (JSONObject)ob.get("access");
  JSONArray ob1=(JSONArray)ob.get("serviceCatalog");
 // out.println(ob.get("serviceCatalog").toString());
 	 String comp="";
 for(int i=0;i<ob1.size();i++)
  {
	 ob=(JSONObject)ob1.get(i);
	 //out.println(ob1.get(i));
	 comp=(String)ob.get("name");
	 if(comp.equals("swift"))
	 break;
  }
 // ob=(JSONObject)ob1.get(9);
  //out.println(ob.toString());
  //out.println(ob.get("endpoints").toString());
  if(comp.equals("swift")){
  ob1=(JSONArray)ob.get("endpoints");
  ob=(JSONObject)ob1.get(0);
  String PublicUrl=ob.get("publicURL").toString();
  System.out.println(PublicUrl);
  session.setAttribute("Purl", PublicUrl);
  session.setAttribute("Token",Userid);  
  }
  else
  {
	 
	 %>
	 <script type="text/javascript">alert("Openstack Swift Server Down... Please try again later");</script>
	<%  
  }  
  %>
  <jsp:forward page="Dashboard.jsp"></jsp:forward>
  <% 

} catch (Exception e) {

    e.printStackTrace();

  } finally {

    if(connection != null) {
      connection.disconnect(); 
    }
  }
%>


  
</body>
</html>