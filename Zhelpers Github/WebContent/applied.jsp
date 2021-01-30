<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, connection.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<title>Applied</title>
<script type="text/javascript">
function view(eid){
	var x="ereview.jsp?eid="+eid;
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
  <li ><a href="wrating.jsp" title='My Ratings'><i class="material-icons">assessment</i></a></li>
  <li><a href="accepted.jsp" title='Accepted'><i class="material-icons">mail_outline</i></a></li>
  <li><a href="applied.jsp" title='Applied' class="active"><i class="material-icons">playlist_add_check</i></a></li>
  <li style="float: right;" title='Log Out'><a href="Logout"><i class="material-icons">exit_to_app</i></a></li>
  <li style="float: right;" title='Profile'><a href="workerprofile.jsp"><i class="material-icons">person_outline</i></a></li>
  <li style="float: right;" title='Rating'><a style="cursor: default;"><%=rating %>&nbsp;<i class="material-icons" style="vertical-align: -16%;">star_rate</i></a></li>
</ul>
<%
	sql="select * from advertisement";
	ps=cn.prepareStatement(sql);
	rs=ps.executeQuery();
	String sql1;
	PreparedStatement ps1;
	ResultSet rs1;
	while(rs.next()){
		sql1="select * from apply where aid=? and wid=?";
		ps1=cn.prepareStatement(sql1);
		ps1.setString(1, rs.getString(1));
		ps1.setString(2, n);
		rs1=ps1.executeQuery();
		if(rs1.next()){
			String sq="select * from userdetails where mobilenumber="+rs.getString(3);
			PreparedStatement p=cn.prepareStatement(sq);
			ResultSet r=p.executeQuery();
			while(r.next()){
				String sqx="select * from worker_review where eid="+rs.getString(3);
				PreparedStatement px=cn.prepareStatement(sqx);
				ResultSet rx=px.executeQuery();
				float r2=0 ;
				int n2=0;
				while(rx.next()){
					r2= r2+Integer.parseInt(rx.getString(3));
					n2++;
				}
				if(n2!=0){
					r2= r2/n2;
				}
			
%>
<div class="row" style="height: auto;">
<b>Employer Name: </b><a href="javascript:view('<%=rs.getString(3)%>')" title='View Profile'><%=r.getString(1)%> <%=r.getString(2)%></a> <%=r2 %>/5<a style="float: right;color: green;cursor: default;" title='Applied'><i class="material-icons" style="vertical-align: middle;">check_circle</i> Applied</a>
<br>
<br>
<%} %>
<b>Posted on -</b> <%=rs.getString(2)%>
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
<%} }%>
<%}catch(Exception e){
	out.print(e);
} %>

<br>
</body>
</html>