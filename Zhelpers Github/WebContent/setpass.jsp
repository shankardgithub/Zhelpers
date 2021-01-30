<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*,java.util.*,project.*,connection.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
function sendValue() {
	var x = document.getElementById("myInput").value;
	var y = document.getElementById("myIn").value;
	var password=document.frm.password.value;
	var passwordn=document.frm.passwordn.value;
	
	if(password == passwordn)
		{
		document.getElementById("d").innerHTML="Please Wait.....";
		var url="Passchange?mail="+x+"&token="+y+"&password="+password;
		var obj=new XMLHttpRequest();
		obj.onreadystatechange=function(){
			if(obj.status==200 && obj.readyState==4){
				document.getElementById("d").innerHTML=obj.responseText;
			}
		}
		obj.open("GET",url,true);
		obj.send();
		}
	else
		{
		document.getElementById("d").innerHTML="Password and Confirm Password is not same please try again";
		}
}
</script>
</head>
<body bgcolor="cyan">
<center><h1>Change Your Password Here</h1></center><br><br>
<%
try{
	String token=request.getParameter("token");
	String mail=request.getParameter("mail");
	Calendar cal = Calendar.getInstance();
	long min =cal.get(Calendar.MINUTE);
	long hrs = cal.get(Calendar.HOUR);
	String mail2=null;
	long hr=9999;
	long mi=9999;
	Connection cn=ConnectDatabase.getCn();
	String sql="select email,HOURS,MINUTES from FORGOTPASSWORD where email='"+mail+"' and token='"+token+"'";
	PreparedStatement ps=cn.prepareStatement(sql);
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		mail2 = rs.getString(1);
		hr = rs.getLong(2);
		mi = rs.getLong(3);
} 
	if(mail2 == null)
	{
		out.print("<center>Invalid authentication</center>");
	}
	else
	{
		
		if((hrs-hr) == 0)
		{
			if((min-mi) < 14)
			{
				%>
				<center><form name="frm"><br>
						<input type="hidden" id="myInput" value="<%=mail %>">
						<input type="hidden" id="myIn" value="<%=token %>">
						<input type="hidden" name="email" value="some">
						<label><b>Enter New Password<b></label><br><br>
						<input type="password" name="password" id="my"><br><br>
						<label><b>Enter New Password Again<b></label><br><br>
						<input type="password" name="passwordn" id="myI" disabled><br><br>
						<input type="button" id="myBtn" value="Submit" onclick="sendValue()" disabled><br>
						</form><br><div id="d"></div></center>
						<script>
document.getElementById("myI").addEventListener("input", myFunction);
document.getElementById("my").addEventListener("input", myFun);
function myFunction() {
var n= document.getElementById("myI").value;
var ln= document.getElementById("my").value;
	  if((n == ln) && (n.length >= 5) && (ln.length >= 5)){
		  document.getElementById("myBtn").disabled = false;
	  }
	  else
		  {
		  document.getElementById("myBtn").disabled = true;
		  }
}
function myFun() {
	var n= document.getElementById("my").value;
	var ln= document.getElementById("my").value;
	  if(n.length >= 5)
	  {
	  document.getElementById("myI").disabled = false;
	  if(n != ln)
	  {
	  document.getElementById("myI").disabled = true;
	  document.getElementById("myBtn").disabled = true;
	  }
	  }
	  else
		  {
		  document.getElementById("myI").disabled = true;
		  document.getElementById("myBtn").disabled = true;
		 
		  }
}
</script>
						<%
			}
			else
			{
				out.print("<center>Request Time Out. Please Try Again</center>");
			}
		}
		else
		{
			out.print("<center>Request Time Out. Please Try Again</center>");
		}
	}
}catch(Exception e){
	out.print(e);
}
%>
</body>
</html>