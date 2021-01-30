<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>Applications</title>
<script type="text/javascript">
function del(aid){
	var url="Delete?aid="+aid;
	document.location.href = url;
}
function acc(wid,aid){
	//alert("hitted"+wid+" "+aid);
	var rl="Accept?aid="+aid+"&wid="+wid;
	document.location.href = rl;
}
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
  <li><a href="application.jsp" title='Applications' class="active"><i class="material-icons">mail_outline</i></a></li>
  <li><a href="reviewworker.jsp" title='Rate Others'><i class="material-icons">rate_review</i></a></li>
  <li><a href="my_ad.jsp" title='My Advertisements'><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="userprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<%
	sql="select * from advertisement where mobile=?";
	ps=cn.prepareStatement(sql);
	ps.setString(1, n);
	rs=ps.executeQuery();
	String sql1,sql2;
	PreparedStatement ps1,ps2;
	ResultSet rs1,rs2;
	while(rs.next()){
		sql1="select * from apply where aid=?";
		ps1=cn.prepareStatement(sql1);
		ps1.setString(1, rs.getString(1));
		rs1=ps1.executeQuery();
	if(rs1.next()){
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
<br>
<br>
<b>Applications:</b>
<%
	rs1=ps1.executeQuery();
	while(rs1.next()){
		sql2="select * from workerdetails where mobilenumber=?";
		ps2=cn.prepareStatement(sql2);
		ps2.setString(1, rs1.getString(2));
		rs2=ps2.executeQuery();
		if(rs2.next()){
			String sq="select * from empl_review where wid="+rs2.getString(3);
			PreparedStatement p=cn.prepareStatement(sq);
			ResultSet r=p.executeQuery();
			float r2=0 ;
			int n2=0;
			while(r.next()){
				r2= r2+Integer.parseInt(r.getString(3));
				n2++;
			}
			if(n2!=0){
				r2= r2/n2;
			}
%>
<div class="row" style="height: auto;width: auto;background-color: #595959;border: none;color: white;box-shadow: 0 0 0;padding:5px;">
<p>
<a href="javascript:view('<%=rs2.getString(3)%>')"style="color:white;" title='View Profile'><%=rs2.getString(1)%> <%=rs2.getString(2)%></a> &nbsp;&nbsp;<%=r2 %>/5<a href="javascript:acc('<%=rs2.getString(3)%>','<%=rs.getString(1)%>')"style="float: right;color:white;" title='Accept'><i class="material-icons">check</i></a>
</p>
</div>
<%}} %>
</div>
<br>
<%}}%>
<%}catch(Exception e){
	out.print(e);
} %>
<br>
</body>
</html>