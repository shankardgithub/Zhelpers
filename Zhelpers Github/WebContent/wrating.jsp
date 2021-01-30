<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*, connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>My rating</title>
</head>
<body>
<%
response.setHeader("Cache-control","no-cache,no-store,must-revalidate");
try{
	Connection cn=ConnectDatabase.getCn();
	String n=(String)session.getAttribute("id");
	if(n==null){
		response.sendRedirect("index.jsp");
	}
	String sql="select * from empl_review where wid="+n;
	PreparedStatement ps=cn.prepareStatement(sql);
	ResultSet rs=ps.executeQuery();
	float rating=0 ;
	int n1=0;
	while(rs.next()){
		rating= rating+Integer.parseInt(rs.getString(3));
		n1++;
	}
	if(n1!=0){
		rating= rating/n1;
	}
%>
<ul style="font-size: 1.3vw;">
  <li ><a href="worker.jsp " title='Home'><i class="material-icons">home</i></a></li>
  <li ><a href="wrating.jsp" title='My Ratings' class="active"><i class="material-icons">assessment</i></a></li>
  <li><a href="accepted.jsp" title='Accepted'><i class="material-icons">mail_outline</i></a></li>
  <li><a href="applied.jsp" title='Applied'><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="workerprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<%
	rs=ps.executeQuery();
	while(rs.next()){
%>
<div class="row" style="height: auto;">
<b>Rating:</b> <%=rs.getString(3)%>/5<br><br>
<p><b>Comment:</b> <%=rs.getString(4)%></p><br><br>
<b>Job Role:</b> <%=rs.getString(5) %>
</div>
<br>
<%}%>
<%}catch(Exception e){
	out.print(e);
} %>

<br>
</body>
</html>