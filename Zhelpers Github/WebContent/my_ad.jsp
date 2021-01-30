<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>My Advertisement</title>
<script type="text/javascript">
function del(aid){
	var url="Delete?aid="+aid;
	document.location.href = url;
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
  <li><a href="reviewworker.jsp" title='Rate Others'><i class="material-icons">rate_review</i></a></li>
  <li><a href="my_ad.jsp" title='My Advertisements' class="active"><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="userprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<%
	sql="select * from advertisement where mobile=?";
	ps=cn.prepareStatement(sql);
	ps.setString(1, n);
	rs=ps.executeQuery();
	while(rs.next()){
%>
<div class="row" style="height: auto;">
<b>Posted on -</b> <%=rs.getString(2)%><a href="javascript:del('<%=rs.getString(1)%>')"style="float: right;" title='Delete'><i class="material-icons">delete</i></a>
<br>
<br>
<p>
<b>Description: </b><%=rs.getString(4) %>
</p>
<br>
<b>Location for work -</b> <%=rs.getString(5) %>
<br>
<br>
<b>Job Profile Needed -</b> <%=rs.getString(8) %>
<br>
<br>
<b>Salary -</b> <%=rs.getString(6) %> to <%=rs.getString(7) %>
</div>
<br>
<%} %>
<%}catch(Exception e){
	out.print(e);
} %>

<br>
</body>
</html>