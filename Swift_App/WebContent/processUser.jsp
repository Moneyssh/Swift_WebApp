<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.util.*" import="org.json.simple.*" import="java.net.*" import="org.json.simple.parser.JSONParser"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int flag=0;
String username=request.getParameter("uname");
String password=request.getParameter("pass1");
String email=request.getParameter("email");

JSONObject user=new JSONObject();
user.put("name", username);
user.put("email",email);
user.put("enabled",true);
user.put("OS-KSADM:password",password);



JSONObject tenant=new JSONObject();
tenant.put("name", username);
tenant.put("description","");
tenant.put("enabled",true);



JSONObject passwordCredentials = new JSONObject();
passwordCredentials.put("username","admin");
passwordCredentials.put("password", "openstack");

JSONObject auth = new JSONObject();
auth.put("tenantName", "admin");
auth.put("passwordCredentials", passwordCredentials);

JSONObject main = new JSONObject();
main.put("auth", auth);
String urlParameters=main.toString();
String targetURL="http://192.168.0.15:5000/v2.0/tokens";

  URL url;
  HttpURLConnection connection = null;  
  try {
	  
	 main.put("auth", auth);
	  urlParameters=main.toString();  
    //Create connection
    url = new URL(targetURL);
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
    //out.println(in);
    JSONParser jsonParser = new JSONParser();
    JSONObject ob = (JSONObject)jsonParser.parse(in);
    ob = (JSONObject)ob.get("access");
    ob = (JSONObject)ob.get("token");
    String Authid = ob.get("id").toString();
    out.println("Admin="+Authid+"\n");
    
    
    main.clear();
    main.put("user", user);
    urlParameters=main.toString();
    //System.out.println(main);
    url = new URL("http://192.168.0.15:35357/v2.0/users");
    connection = (HttpURLConnection)url.openConnection();
    connection.setRequestMethod("POST");
    connection.setRequestProperty("X-Auth-Token",Authid);
    connection.setRequestProperty("Content-Type", 
         "application/json");
			
    connection.setRequestProperty("Content-Length", "" + 
             Integer.toString(urlParameters.getBytes().length));
    connection.setRequestProperty("Content-Language", "en-US");  
			
    connection.setUseCaches (false);
    connection.setDoInput(true);
    connection.setDoOutput(true);

    //Send request
    wr = new DataOutputStream (
                connection.getOutputStream ());
    wr.writeBytes (urlParameters);
    wr.flush ();
    wr.close ();

    //Get Response	
    is = connection.getInputStream();
    rd = new BufferedReader(new InputStreamReader(is));
    res = new StringBuffer(); 
    while((line = rd.readLine()) != null) {
      res.append(line);
      res.append('\r');
    }
    rd.close();
    
    in = res.toString();
    //out.println(in);
    jsonParser = new JSONParser();
    ob = (JSONObject)jsonParser.parse(in);
    ob = (JSONObject)ob.get("user");
    //ob = (JSONObject)ob.get("token");
    String Userid = ob.get("id").toString();
    out.println("User="+Userid+"\n");
    
    
    
    
    
    main.clear();
    main.put("tenant", tenant);
     urlParameters=main.toString();
     //System.out.println(urlParameters);
     url = new URL("http://192.168.0.15:35357/v2.0/tenants");
    connection = (HttpURLConnection)url.openConnection();
    connection.setRequestMethod("POST");
    connection.setRequestProperty("X-Auth-Token",Authid);
    connection.setRequestProperty("Content-Type", 
         "application/json");
			
    connection.setRequestProperty("Content-Length", "" + 
             Integer.toString(urlParameters.getBytes().length));
    connection.setRequestProperty("Content-Language", "en-US");  
			
    connection.setUseCaches (false);
    connection.setDoInput(true);
    connection.setDoOutput(true);

    //Send request
    wr = new DataOutputStream (
                connection.getOutputStream ());
    wr.writeBytes (urlParameters);
    wr.flush ();
    wr.close ();
    //System.out.println("Hello");
    //Get Response	
    is =(InputStream)connection.getInputStream();
    rd = new BufferedReader(new InputStreamReader(is));
    res = new StringBuffer();
    while((line = rd.readLine()) != null) {
      res.append(line);
      res.append('\r');
    }
    rd.close();
    
    in = res.toString();
    //out.println(in);
    jsonParser = new JSONParser();
    ob = (JSONObject)jsonParser.parse(in);
    ob = (JSONObject)ob.get("tenant");
    String Tenantid =(String) ob.get("id").toString();
    out.println("Tenant="+Tenantid+"\n");
    
    
    
   
    main.clear();
    user.put("id",Userid);
    user.put("tenantId",Tenantid);
    main.put("user", user);
    urlParameters=main.toString();
    url = new URL("http://192.168.0.15:35357/v2.0/users/"+Userid);
    connection = (HttpURLConnection)url.openConnection();
    connection.setRequestMethod("PUT");
    connection.setRequestProperty("X-Auth-Token",Authid);
    connection.setRequestProperty("Content-Type", 
         "application/json");
			
    connection.setRequestProperty("Content-Length", "" + 
             Integer.toString(urlParameters.getBytes().length));
    connection.setRequestProperty("Content-Language", "en-US");  
			
    connection.setUseCaches (false);
    connection.setDoInput(true);
    connection.setDoOutput(true);

    //Send request
    wr = new DataOutputStream (
                connection.getOutputStream ());
    wr.writeBytes (urlParameters);
    wr.flush ();
    wr.close ();

    //Get Response	
    is = connection.getInputStream();
    rd = new BufferedReader(new InputStreamReader(is));
    res = new StringBuffer(); 
    while((line = rd.readLine()) != null) {
      res.append(line);
      res.append('\r');
    }
    rd.close(); 
    
    in = res.toString();
    out.println(in);
    //out.println(in);
    //jsonParser = new JSONParser();
    //ob = (JSONObject)jsonParser.parse(in);
    //ob = (JSONObject)ob.get("user");
    //ob = (JSONObject)ob.get("token");
    //String Tenantid = ob.get("id").toString();
    
   
     
    //urlParameters="";
    url = new URL("http://192.168.0.15:35357/v2.0/OS-KSADM/roles/");
    connection = (HttpURLConnection)url.openConnection();
    connection.setRequestMethod("GET");
    connection.setRequestProperty("X-Auth-Token",Authid);
   // connection.setRequestProperty("Content-Type", 
     //    "application/json");
			
   // connection.setRequestProperty("Content-Length", "" + 
     //        Integer.toString(urlParameters.getBytes().length));
    connection.setRequestProperty("Content-Language", "en-US");  
			
    connection.setUseCaches (false);
    connection.setDoInput(true);
    connection.setDoOutput(true);

    //Send request
   // wr = new DataOutputStream (
       //         connection.getOutputStream ());
   // wr.writeBytes (urlParameters);
   // wr.flush ();
   // wr.close ();

    //Get Response	
    is = connection.getInputStream();
    rd = new BufferedReader(new InputStreamReader(is));
    res = new StringBuffer(); 
    while((line = rd.readLine()) != null) {
      res.append(line);
      res.append('\r');
    }
    rd.close(); 
    
    in = res.toString();
   // out.println(in);
   String comp;
    jsonParser = new JSONParser();
    ob=(JSONObject)jsonParser.parse(in);
    JSONArray ob1=(JSONArray)ob.get("roles");
    for(int i=0;i<ob1.size();i++)
    {
    	ob=(JSONObject)ob1.get(i);
    	comp=ob.get("name").toString();
    	if(comp.equals("Member"))
    		break;
    	
    }
    String Memberid = ob.get("id").toString();
    out.println(Memberid);
    
    
   
    
    url = new URL("http://192.168.0.15:35357/v2.0/tenants/"+Tenantid+"/users/"+Userid+"/roles/OS-KSADM/"+Memberid);
    connection = (HttpURLConnection)url.openConnection();
    connection.setRequestMethod("PUT");
    connection.setRequestProperty("X-Auth-Token",Authid);
    connection.setRequestProperty("Content-Language", "en-US");  
			
    connection.setUseCaches (false);
    connection.setDoInput(true);
    connection.setDoOutput(true);

    //Send request
   // wr = new DataOutputStream (
       //         connection.getOutputStream ());
   // wr.writeBytes (urlParameters);
   // wr.flush ();
   // wr.close ();

    //Get Response	
    is = connection.getInputStream();
    rd = new BufferedReader(new InputStreamReader(is));
    res = new StringBuffer(); 
    while((line = rd.readLine()) != null) {
      res.append(line);
      res.append('\r');
    }
    rd.close(); 
    
    in = res.toString();
    out.println(in);
   
    
    flag=1;
    
    
   
  } catch (Exception e) {

    e.printStackTrace();

  } finally {

    if(connection != null) {
      connection.disconnect(); 
    }
  }
  if(flag==0)
	  request.getRequestDispatcher("adduser.jsp").forward(request, response);
  else
	  request.getRequestDispatcher("index.jsp").forward(request, response);
%>
</body>
</html>