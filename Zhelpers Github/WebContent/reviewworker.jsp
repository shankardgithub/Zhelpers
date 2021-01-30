<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>Review workers</title>
<script type="text/javascript">
function view(wid){
	var x="wreview.jsp?wid="+wid;
	document.location.href = x;
}
</script>
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
	String sql="select * from worker_review where eid="+n;
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
  <li ><a href="user.jsp" title='Home'><i class="material-icons">home</i></a></li>
  <li ><a href="urating.jsp" title='My Ratings'><i class="material-icons">assessment</i></a></li>
  <li><a href="application.jsp" title='Applications'><i class="material-icons">mail_outline</i></a></li>
  <li><a href="reviewworker.jsp" title='Rate Others' class="active"><i class="material-icons">rate_review</i></a></li>
  <li><a href="my_ad.jsp" title='My Advertisements'><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="userprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<%
	sql="select * FROM workerdetails JOIN accept ON workerdetails.mobilenumber =accept.wid where eid="+n;//static widn change it
	ps=cn.prepareStatement(sql);	
	rs=ps.executeQuery();
	while(rs.next()){
%>
<div class="row" style="height: auto;">
<p>Your Worker Name :<a href="javascript:view('<%=rs.getString(3)%>')"title='View Profile'><%=rs.getString(1)%> <%=rs.getString(2)%></a></p>
<form action="sendemplreview" method="post">
<p>Working Since :<%=rs.getString(16)%> as <%=rs.getString(17)%></p>
<input type="hidden" name="eid" value="<%=rs.getString(14)%>">
<input type="hidden" name="wid" value="<%=rs.getString(15)%>">
<input type="hidden" name="wtype" value="<%=rs.getString(17)%>">  
<input type="submit" value="Review">
</form>
</div>
<%} %>
<%}catch(Exception e){
	out.print(e);
} %>
</body>
</html>