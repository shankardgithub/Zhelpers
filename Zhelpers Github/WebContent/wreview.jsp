<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, connection.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>Worker Details</title>
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
  <li><a href="reviewworker.jsp" title='Rate Others'><i class="material-icons">rate_review</i></a></li>
  <li><a href="my_ad.jsp" title='My Advertisements'><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="userprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<div class="row" >
<%
	String g=request.getParameter("wid");
	sql="select * from workerdetails where mobilenumber="+g;
	ps=cn.prepareStatement(sql);
	rs=ps.executeQuery();
	while(rs.next()){
%>
<div class="column1">
<p>
<img src="img_avatar.png" width="470px" height="auto" style="border-radius: 50%;" title="<%=rs.getString(1) %> <%=rs.getString(2) %>">
</p>
</div>
<div class="column2" style="border-left: 1px solid black;padding-left: 10px">

<p style="font-size: 1.3vw;">
<b>Name: </b><%=rs.getString(1) %> <%=rs.getString(2) %>
<br>
<br>
<b>Mobile Number:</b> <%=rs.getString(3) %>
<br>
<br>
<b>Email id:</b> <%=rs.getString(4) %>
<br>
<br>
<b>D.O.B.:</b> <%=rs.getString(6) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Gender:</b> <%=rs.getString(7) %>
<br>
<br>
<b>Address :</b> <%=rs.getString(8) %>&nbsp;<%=rs.getString(9) %>&nbsp;<%=rs.getString(10) %>
<br>
<br>
<b>State:</b> <%=rs.getString(11) %>
<br>
<br>
<b>City:</b> <%=rs.getString(12) %>
<br>
<br>
<b>Pincode:</b> <%=rs.getString(13) %>
</p>
</div>
<%
	}
%>
</div>
<br>
<div class="row" style="height: auto;">
<h2>Reviews:</h2>
<%
String sq="select * from empl_review where wid="+g;
PreparedStatement p=cn.prepareStatement(sq);
ResultSet r=p.executeQuery();
while(r.next()){
%>
<div class="row" style="height: auto;width: auto;">
<b>Rating:</b> <%=r.getString(3)%>/5<br><br>
<p><b>Comment:</b> <%=r.getString(4)%></p><br><br>
<b>Job Role:</b> <%=r.getString(5) %>
</div>
<br>
<br>
<%}%>
</div>
<%}catch(Exception e){
	out.print(e);
} %>
</body>
</html>
</html>