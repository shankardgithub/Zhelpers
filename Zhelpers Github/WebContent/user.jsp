<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>Home</title>
<script type="text/javascript">
function checkfield(){
	var city=document.ad.city.value;
	var type=document.ad.type.value;
	var min=document.ad.min.value;
	var max=document.ad.max.value;
	var des=document.ad.des.value;
	if(city==""||type==""||min==""||max==""||des==""){
		document.getElementById("warn").innerHTML="All fields must be filled";
		return false;
	}
	else if(isNaN(min)||isNaN(max)){
		document.getElementById("warn").innerHTML="Salary must be a number";
		return false;
	}
	else if(parseInt(min)>=parseInt(max)){
		document.getElementById("warn").innerHTML="Minimum Salary cannot be more than or equal to Maximum Salary";
		return false;
	}
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
  <li ><a href="user.jsp" title='Home' class="active"><i class="material-icons">home</i></a></li>
  <li ><a href="urating.jsp" title='My Ratings'><i class="material-icons">assessment</i></a></li>
  <li><a href="application.jsp" title='Applications'><i class="material-icons">mail_outline</i></a></li>
  <li><a href="reviewworker.jsp" title='Rate Others'><i class="material-icons">rate_review</i></a></li>
  <li><a href="my_ad.jsp" title='My Advertisements'><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="userprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<br>
<div class="row" >
  <h1>Create New Advertisement</h1>
  <form action="Post" method="post" name="ad">
  <select id="city" name="city" >
  <option value="">Location</option>
  <option value="Kolkata">Kolkata</option>
  <option value="Kalyani">Kalyani</option>
  <option value="Howrah">Howrah</option>
  </select>&nbsp;
  <b>Salary: </b><input type="text" placeholder="Min" name="min">&nbsp;to&nbsp;<input type="text" placeholder="Max" name="max">
  &nbsp;
  <select id="type" name="type" >
  <option value="">Job Profile</option>
  <option value="Cook">Cook</option>
  <option value="Baby Sitter">Baby Sitter</option>
  <option value="Driver">Driver</option>
  </select>
  <br><br><br>
  <textarea placeholder="Describe what you are looking for..." name="des"></textarea>
  <br>
  <center><input type="submit" value="Submit" onclick="return checkfield();"></center>
  </form>
  <center><div id="warn" style="color: red;"></div></center>
</div>
<%}catch(Exception e){
	out.print(e);
} %>
</body>
</html>