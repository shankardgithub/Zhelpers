<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*,java.util.*,project.*, connection.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>zHelpers</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400">  
    <link rel="stylesheet" href="font-awesome-4.5.0/css/font-awesome.min.css">                
    <link rel="stylesheet" href="css/bootstrap.min.css">                                      
    <link rel="stylesheet" href="css/hero-slider-style.css">                              
    <link rel="stylesheet" href="css/magnific-popup.css">                                 
    <link rel="stylesheet" href="css/templatemo-style.css">                                   
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript">

var vfname = "";
var vlname = "";
var vemail = "";
var vphno = "";
var vpassword = "";
var vcpassword = "";
var vapno = "";
var vad = "";
var vadd = "";
var vpin = "";
var vstate = "";
var vdistrict = ""; 
var varea = "";
var vutype = "";
var vdob = ""; 
var vgender = "";

function checklog(){
    var id=document.log.id.value;
    var pass=document.log.pass.value;
    if(id==""||pass==""){
        document.getElementById("warn").innerHTML="All fields must be filled";
        return false;
    }
}
function vali()
{
	vfname = document.signature.fname.value;
	vlname = document.signature.lname.value;
	vemail = document.signature.email.value;
	vphno = document.signature.phno.value;
	vpassword = document.signature.pass.value;
	vcpassword = document.signature.cpass.value;
	vapno = document.signature.apno.value;
	vad = document.signature.ado.value;
	vadd = document.signature.adt.value;
	vpin = document.signature.pin.value;
	vstate = document.getElementById("mySelect").value;
	vdistrict = document.getElementById("dis").value; 
	varea = document.getElementById("arrea").value; 
	vutype = document.getElementById("utype").value;
	vdob = document.signature.dob.value; 
	vgender = document.getElementById("gender").value;
	document.getElementById("warnsignup").innerHTML="Please Wait.....";
    if((vfname == "") || (vlname == "") || (vemail == "") || (vphno == "") || (vpassword == "") || (vcpassword == "") || (vapno == "") || (vad == "") || (vadd == "") || (vpin == "") || (vstate == "") || (vdistrict == "") || (varea == "") || (vutype == "") || (vdob == "") || (vgender == "")){
        document.getElementById("warnsignup").innerHTML="All fields must be filled";
    }
    else if(vpassword != vcpassword)
    	{
    	document.getElementById("warnsignup").innerHTML="Password and Confirm Password must be same";
    	}
    else
    	{
    	document.getElementById("warnsignup").innerHTML="Please Wait.....";
		var url="Otpsender?mail="+vemail;
		var obj=new XMLHttpRequest();
		obj.onreadystatechange=function(){
			if(obj.status==200 && obj.readyState==4){
				var st = obj.responseText;
				if(st == "Exists")
					{
					document.getElementById("warnsignup").innerHTML="Register user exists with this email id you can login to use" ;
					}
				else if(st == "send")
					{
					document.getElementById("warnsignup").innerHTML="OTP sent Sucessfully to your email id" ;
			    	document.getElementById("signature").style.display = "none"; 
			    	document.getElementById("otpform").style.display = "block";
					}
				else if(st == "problem")
					{
					document.getElementById("warnsignup").innerHTML="Problem Occured Please try again" ;
					}
			}
		}
		obj.open("GET",url,true);
		obj.send();
    	
    	}
	
	
}
function forgot()
{
	document.getElementById("login").style.display = "none";
	document.getElementById("fp").style.display = "none";
	document.getElementById("forgotpass").style.display = "block";
	document.getElementById("si").style.display = "block";
	document.getElementById("warn").innerHTML="";
}
function signin()
{
	document.getElementById("forgotpass").style.display = "none";
	document.getElementById("si").style.display = "none";
	document.getElementById("login").style.display = "block";
	document.getElementById("fp").style.display = "block";
	document.getElementById("warn").innerHTML="";
}
function sendValue() {
	var mail=document.forgotpass.email.value;
	if(mail == "")
		{
		document.getElementById("warn").innerHTML="Email must be entered";
		}
	else
		{
		document.getElementById("warn").innerHTML="Please Wait.....";
		var url="Forgotval?mail="+mail;
		var obj=new XMLHttpRequest();
		obj.onreadystatechange=function(){
			if(obj.status==200 && obj.readyState==4){
				document.getElementById("warn").innerHTML=obj.responseText;
			}
		}
		obj.open("GET",url,true);
		obj.send();
		
		}

}
function registar()
{
	var otp = document.otpform.otp.value;
	if(otp==""){
        document.getElementById("warnsignup").innerHTML="OTP must be entered";
    }
	else
		{
		document.getElementById("warnsignup").innerHTML="Please Wait.....";
		var url="Register?fname="+vfname+"&lname="+vlname+"&email="+vemail+"&phno="+vphno+"&password="+vpassword+"&apno="+vapno;
			url =url+"&ad="+vad+"&add="+vadd+"&pin="+vpin+"&state="+vstate+"&district="+vdistrict+"&area="+varea+"&utype="+vutype+"&dob="+vdob;
			url =url+"&gender="+vgender+"&otp="+otp;
		var obj=new XMLHttpRequest();
		obj.onreadystatechange=function(){
			if(obj.status==200 && obj.readyState==4){
				var st = obj.responseText;
				if(st == "wrongotp")
					{
					document.getElementById("signature").style.display = "block"; 
			    	document.getElementById("otpform").style.display = "none";
			    	document.getElementById("warnsignup").innerHTML="Wrong OTP Entered Please try again";
					}
				else if(st == "sucess")
					{
					document.getElementById("signature").style.display = "block"; 
			    	document.getElementById("otpform").style.display = "none";
			    	document.getElementById("warnsignup").innerHTML="Registered sucessfully Please login to use";
					}
				else if(st == "problem")
					{
					document.getElementById("signature").style.display = "block"; 
			    	document.getElementById("otpform").style.display = "none";
			    	document.getElementById("warnsignup").innerHTML="Error occured please try again";
					}
				else
					{
					document.getElementById("signature").style.display = "block"; 
			    	document.getElementById("otpform").style.display = "none";
			    	document.getElementById("warnsignup").innerHTML="Error occured please try again";
					}
				
			}
		}
		obj.open("GET",url,true);
		obj.send();
		}
}
function contact()
{
	var name = document.contactfrom.contact_name.value; 
	var subject = document.contactfrom.contact_subject.value; 
	var email = document.contactfrom.contact_email.value; 
	var messege = document.contactfrom.contact_message.value; 
	if((name == "") || (subject == "") || (email == "") || (messege == ""))
		{
		document.getElementById("contactwarn").innerHTML="All fields must be filled";
		}
	else
		{
		document.getElementById("contactwarn").innerHTML="Please Wait.....";
		var url="Support?email="+email+"&name="+name+"&subject="+subject+"&messege="+messege;
		var obj=new XMLHttpRequest();
		obj.onreadystatechange=function(){
			if(obj.status==200 && obj.readyState==4){
				document.getElementById("contactwarn").innerHTML=obj.responseText;
			}
		}
		obj.open("GET",url,true);
		obj.send();
		}
	
	
}
</script>
<style type="text/css">
 input[type=text],input[type=password],input[type=date],select{
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  font-family: 'Work Sans', sans-serif;
}
input[type=text]:FOCUS,input[type=date]:FOCUS,input[type=password]:FOCUS,.button:FOCUS{
  outline: none;
}
}
input[type=submit],input[type=button],button{
  width: 100px;
  background-color: #00001a;
  color: white;
  padding: 7px 10px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-family: 'Work Sans', sans-serif;
}
input[type=submit]:HOVER,input[type=button]:HOVER,button:HOVER{
    background-color: white;
    color: #00001a;
    box-shadow: 0 1px 5px rgba(0, 0, 26,0.5);
}
</style>
</head>

    <body>
    <%
response.setHeader("Cache-control","no-cache,no-store,must-revalidate");
    String n=(String)session.getAttribute("id");
    if(n!=null){
		Connection cn=ConnectDatabase.getCn();
		String sql="select * from nlogin where mobile=?";
		PreparedStatement ps=cn.prepareStatement(sql);
		ps.setString(1, n);
		ResultSet rs=ps.executeQuery();
		if(rs.next())
		{
			String p=rs.getString(3);
	        if(p.equals("u"))
	        {
	        	response.sendRedirect("user.jsp");
	        }
	        else if(p.equals("w"))
	        {
	        	response.sendRedirect("worker.jsp");
	        }
		}
    	
    }
%>
        
        <div class="cd-hero">
        
            <div class="cd-slider-nav">
                <nav class="navbar">
                    <div class="tm-navbar-bg">
                        
                        <a class="navbar-brand text-uppercase" href="#"><i class="fa fa-send-o tm-brand-icon"></i>zHelpers</a>

                        <button class="navbar-toggler hidden-lg-up" type="button" data-toggle="collapse" data-target="#tmNavbar">
                            &#9776;
                        </button>
                        <div class="collapse navbar-toggleable-md text-xs-center text-uppercase tm-navbar" id="tmNavbar">
                            <ul class="nav navbar-nav">
                                <li class="nav-item active selected">
                                    <a class="nav-link" href="#0" data-no="1">Home <span class="sr-only">(current)</span></a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#0" data-no="2">Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#0" data-no="3">Sign Up</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#0" data-no="4">About Us</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#0" data-no="5">Contact Us</a>
                                </li>
                            </ul>
                        </div>                        
                    </div>

                </nav>
            </div> 

            <ul class="cd-hero-slider"> 
                <li class="selected">
                    <div class="cd-full-width">
                        <div class="container-fluid js-tm-page-content tm-page-1" data-page-no="1">

                            <div class="cd-bg-video-wrapper" data-video="video/moving-cloud">
                            </div> 
                            
                            <div class="row">
                            
                                <div class="col-xs-12">
                                    <div class="tm-2-col-container tm-bg-white-translucent">

                                        <div class="row">
                                            <div class="col-xs-12">
                                                <h2 class="tm-text-title">Zhelpers for everyone</h2>    
                                            </div>                                            
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 tm-2-col-left">
                                                <div class="text-xs-left tm-textbox tm-2-col-textbox">                                            
                                                    <p class="tm-text">Our website will help you to find the perfect helper you need.You can easily find the perfect helper according to your convenience.Now there is no need to wait for others to find your helper.</p>
                                                    <p class="tm-text">One can easily avail this website.Nowadays each and everyone is aware of the use of website.So it does not seems difficult to use.</p>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 tm-2-col-right">
                                                <div class="text-xs-left tm-textbox tm-2-col-textbox">
                                                    <p class="tm-text">Also the workers can find the suitable job they need.Workers can apply for jobs and can create their profile.According to their ability one can hire the workers.</p>
                                                    <p class="tm-text">So this website is now one of the most useful one to find helpers and also to find jobs for the workers.It will be very much helpful to find the work you need and also as well to find the helper you need</p>
                                                </div>          
                                            </div>
                                            
                                        </div>

                                    </div>
                                </div>

                            </div>

                        </div>
                    </div> 
                </li>

                
        
                <li>
                    
                   <div class="cd-full-width">

                        <div class="container-fluid js-tm-page-content" data-page-no="2">

                            <div class="cd-bg-video-wrapper" data-video="video/o">
                            </div> 
                            
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="tm-flex tm-2-col-container-2">
                            <div class="tm-bg-white-translucent text-xs-left tm-textbox tm-2-col-textbox-2 tm-textbox-padding" style="height:400px;">
                                         <center>
                                            <form action="Login" method="post" name="log" id="login">
                                                <br><br>

<i class="material-icons" >account_circle</i>&nbsp;<input type="text" name="id" id="userid" placeholder="Mobile Number">
<br>
<br>
<i class="material-icons" >lock</i>&nbsp;<input type="password" name="pass" id="userpass" placeholder="Password">
<br>
<br>
<input type="submit" value="OK" style=" width: 100px;
  background-color: #00001a;
  color: white;
  padding: 7px 10px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;" class="button" onclick="return checklog();">

</form>
 <form name="forgotpass" id="forgotpass" style="display:none;">
                                                <br><br>

<i class="material-icons" >account_circle</i>&nbsp;<input type="text" name="email" id="email" placeholder="Email id">
<br>
<br>
<input type="button" value="Submit" style=" width: 100px;
  background-color: #00001a;
  color: white;
  padding: 7px 10px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;" onclick="sendValue()">

</form>
<br>
<a href="#" onclick='forgot()' id="fp">Forgot Password</a>
<a href="#" onclick='signin()' id="si" style="display:none;">Login</a>
<div id="warn" style="font-family: serif; font-size: 1vw;text-decoration: none;color: red"></div>
</center>
                 </div>                       

                                    </div>
                                </div>
                            </div>
                        
                        </div>
                                                
                    </div>
                </li>

                <li>
          <div class="cd-full-width">

                        <div class="container-fluid js-tm-page-content" data-page-no="2">

                            <div class="cd-bg-video-wrapper" data-video="video/o">
                               
                            </div>
                            
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="tm-flex tm-2-col-container-2">
                            <div class="tm-bg-white-translucent text-xs-left tm-textbox tm-2-col-textbox-2 tm-textbox-padding" style="height:800px;">
                                         <center>
                                            <form name="signature" id="signature">
                                                <table>
                                                <br><br>
<tr><td><i class="material-icons" >person</i>&nbsp;<input type="text" name="fname" id="fname" placeholder="First Name">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="lname" id="lname" placeholder="Last Name"></td></tr>

<tr><td><i class="material-icons" >email</i>&nbsp;<input type="text" name="email" id="email" placeholder="Email"></td><td><i class="material-icons" >phone_android</i>&nbsp;<input type="text" name="phno" id="phno" placeholder="Phone Number"></td>
</tr>
<tr><td><i class="material-icons" >lock</i>&nbsp;<input type="password" name="pass" id="userpass" placeholder="Password"></td>
    <td><i class="material-icons" >lock</i>&nbsp;<input type="password" name="cpass" id="cuserpass" placeholder="Confirm Password"></td>
</tr>
<tr><td><i class="material-icons" >location_city</i>&nbsp;<input type="text" name="apno" id="apno" placeholder="Apartment Number"></td>
<td><i class="material-icons" >location_city</i>&nbsp;<input type="text" name="ado" id="ado" placeholder="Address line one"></td></tr>
<tr><td><i class="material-icons" >location_city</i>&nbsp;<input type="text" name="adt" id="adt" placeholder="Address line two"></td>
<td><i class="material-icons" >my_location</i>&nbsp;<input type="text" name="pin" id="pin" placeholder="Pin Code"></td>
</tr>
<tr><td><i class="material-icons">location_city</i>&nbsp;<select name="type" id="mySelect" onchange="myFunction()">
    <option value="">Select State</option>
        <%
try{
	Connection cn=ConnectDatabase.getCn();
	String sql="SELECT DISTINCT STATE FROM ADDRESS ORDER BY STATE";
	PreparedStatement ps=cn.prepareStatement(sql);
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		out.print("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");
		
	}
	
}catch(Exception e){
	out.print(e);
}
%>

</select></td><td><i class="material-icons">location_city</i>&nbsp;<select id="dis" onchange="areafind()">
<option value="">Select District</option>
</select></tr>
<tr><td><i class="material-icons">location_city</i>&nbsp;<select id="arrea">
<option value="">Select City</option>
</select></td><td><i class="material-icons">card_membership</i>&nbsp;<select name="type" id="utype">
    <option value="">Select User Type</option>
    <option value="user">User</option>
    <option value="worker">Worker</option>
</select></td></tr><tr><td><i class="material-icons" >date_range</i>&nbsp;<input type="date" name="dob" id="dob" placeholder="Date of Birth"></td>
    <td><i class="material-icons" >wc</i>&nbsp;<select name="gender" id="gender">
    <option value="">Select Gender</option>
    <option value="male">Male</option>
    <option value="female">Female</option>
    <option value="others">Others</option>
</select></td>
</tr>

<tr><td colspan="2" align="center"><input type="button" style=" width: 100px;
  background-color: #00001a;
  color: white;
  padding: 7px 10px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;" value="Submit" onclick="vali()"></td></tr>

</table>
</form>
 <form name="otpform" id="otpform" style="display:none;">
                                                <br><br>

<i class="material-icons" >account_circle</i>&nbsp;<input type="text" name="otp" id="otp" placeholder="Enter OTP">
<br>
<br>
<input type="button" style=" width: 100px;
  background-color: #00001a;
  color: white;
  padding: 7px 10px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;" value="Submit" onclick="registar()">

</form>
<br>
<div id="warnsignup" style="font-family: serif; font-size: 1vw;text-decoration: none;color: red"></div>
</center>
                  </div>                      
                                    </div>
                                </div>
                            </div>
                        
                        </div>
                                                
                    </div>
                </li>

                <li>

                    <div class="cd-full-width">
                        <div class="container-fluid js-tm-page-content" data-page-no="5">
                        
                            <div class="cd-bg-video-wrapper" data-video="video/padaut-bee">
                                
                            </div> 

                            <div class="row">
                                
                                <div class="col-xs-12">
                                    <div class="tm-flex tm-3-col-container">
                                        
                                            <div class="tm-3-col-textbox tm-bg-white-translucent" style="height: 500px;border-radius: 15px;">
                                                <div class="text-xs-left tm-textbox tm-textbox-padding">

                                                  <h2 class="tm-text-title">person 1</h2>

                                                    <p class="tm-text"><center><img src="img/img_avatar.png" style="border-radius: 50%;height:250px;width: 250px;"></center></p>

                                                    <p class="tm-text">email@hostname.com</p>

                                                </div>
                                            </div>

                                            <div class="tm-3-col-textbox tm-bg-white-translucent" style="height: 500px;border-radius: 15px;">
                                                <div class="text-xs-left tm-textbox tm-textbox-padding">

                                                    <h2 class="tm-text-title">person 2</h2>

                                                    <p class="tm-text"><img src="img/img_avatar.png" style="border-radius: 50%;height:250px;width: 250px;"></p>

                                                    <p class="tm-text">email@hostname.com</p>
                                                </div>          
                                            </div>

                                            <div class="tm-3-col-textbox tm-bg-white-translucent" style="height: 500px;border-radius: 15px;">
                                                <div class="text-xs-left tm-textbox tm-textbox-padding">

                                                  <h2 class="tm-text-title">person 3</h2>

                                                    <p class="tm-text"><img src="img/img_avatar.png" style="border-radius: 50%;height:250px;width: 250px;"></p>

                                                    <p class="tm-text">email@hostname.com</p>
                                                </div>          
                                            </div>
                                            
                                             <div class="tm-3-col-textbox tm-bg-white-translucent" style="height: 500px;border-radius: 15px;">
                                                <div class="text-xs-left tm-textbox tm-textbox-padding">

                                                    <h2 class="tm-text-title">person 4</h2>

                                                    <p class="tm-text"><img src="img/img_avatar.png" style="border-radius: 50%;height:250px;width: 250px;"></p>

                                                    <p class="tm-text">email@hostname.com</p>
                                                </div>          
                                            </div>
                                        
                                    </div>
                                </div>

                            </div>

                        </div>         
                    </div>                                       

                </li>

                <li>
                    <div class="cd-full-width">

                        <div class="container-fluid js-tm-page-content" data-page-no="6">

                        <div class="cd-bg-video-wrapper" data-video="video/u">
                            
                        </div>
                            
                            <div class="tm-contact-page">
                                
                                <div class="row">

                                    <div class="col-xs-12">

                                        <div class="tm-flex tm-contact-container">
                                
                                            <div class="tm-bg-white-translucent text-xs-left tm-textbox tm-2-col-textbox-2 tm-textbox-padding tm-textbox-padding-contact">
                                                <h2 class="tm-text-title">Get in touch</h2>                                                
                                                
                                                
                                                <form name="contactfrom" class="tm-contact-form">

                                                    <div class="form-group col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 tm-form-group-left">
                                                        <input type="text" id="contact_name" name="contact_name" class="form-control" placeholder="Name"  required/>
                                                    </div>
                                        
                                                    <div class="form-group col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 tm-form-group-right">                                                        
                                                        <input type="email" id="contact_email" name="contact_email" class="form-control" placeholder="Email"  required/>
                                                    </div>
                                                                                                            
                                                    <div class="form-group">
                                                        <input type="text" id="contact_subject" name="contact_subject" class="form-control" placeholder="Subject"  required/>
                                                    </div>  
                                                    
                                                    <div class="form-group">
                                                        <textarea id="contact_message" name="contact_message" class="form-control" rows="5" placeholder="Your message" required></textarea>
                                                    </div> 

                                                    <input type="button" class="pull-xs-right tm-submit-btn" value="Send" onclick="contact()">
                                                
                                                </form>  
                                                <div id="contactwarn" style="font-family: serif; font-size: 1vw;text-decoration: none;color: red"></div>
                                            </div>

                                            <div class="tm-bg-white-translucent text-xs-left tm-textbox tm-2-col-textbox-2 tm-textbox-padding tm-textbox-padding-contact">
                                                <h2 class="tm-contact-info">Address</h2>
                                                
                                                <div id="google-map"></div>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>    

                        </div>
                        
                    </div> 
                </li>
            </ul> 
            
            <footer class="tm-footer">
            
                <div class="tm-social-icons-container text-xs-center">
                    <a href="#" class="tm-social-link"><i class="fa fa-facebook"></i></a>
                    <a href="#" class="tm-social-link"><i class="fa fa-google-plus"></i></a>
                    <a href="#" class="tm-social-link"><i class="fa fa-twitter"></i></a>
                    <a href="#" class="tm-social-link"><i class="fa fa-behance"></i></a>
                    <a href="#" class="tm-social-link"><i class="fa fa-linkedin"></i></a>
                </div>
                
                <p class="tm-copyright-text">Copyright &copy; Devacharya Pvt. Ltd. </p>

            </footer>
                    
        </div>
        
        <div id="loader-wrapper">
            
            <div id="loader"></div>
            <div class="loader-section section-left"></div>
            <div class="loader-section section-right"></div>

        </div>
        
    
        <script src="js/jquery-1.11.3.min.js"></script>        
        <script src="https://www.atlasestateagents.co.uk/javascript/tether.min.js"></script> 
        <script src="js/bootstrap.min.js"></script>             
        <script src="js/hero-slider-main.js"></script>         
        <script src="js/masonry.pkgd.min.js"></script>          
        <script src="js/jquery.magnific-popup.min.js"></script> 
                <script>
function myFunction() {
	document.getElementById("dis").options.length = 0;
  var state = document.getElementById("mySelect").value;
  var x = document.getElementById("dis");
  var option = document.createElement("option");
  option.text = "Select State";
  x.add(option);
  var url="Dataprovider?param="+state+"&op=state";
  
	var obj=new XMLHttpRequest();
	obj.onreadystatechange=function(){
		if(obj.status==200 && obj.readyState==4){
			var strin = obj.responseText;
			var st = strin.split(',');;
			 for (var i=0; i<st.length; i++)
			   {
			   var option = document.createElement("option");
			  option.text = st[i];
			  x.add(option);
			   }
		}
	}
	obj.open("GET",url,true);
	obj.send();  
}
function areafind() {
	document.getElementById("arrea").options.length = 0;
	  var state = document.getElementById("dis").value;
	  var x = document.getElementById("arrea");
	  var option = document.createElement("option");
	  option.text = "Select City";
	  x.add(option);
	  var url="Dataprovider?param="+state+"&op=area";
		var obj=new XMLHttpRequest();
		obj.onreadystatechange=function(){
			if(obj.status==200 && obj.readyState==4){
				var strin = obj.responseText;
				var st = strin.split(',');;
				 for (var i=0; i<st.length; i++)
				   {
				   var option = document.createElement("option");
				  option.text = st[i];
				  x.add(option);
				   }
			}
		}
		obj.open("GET",url,true);
		obj.send();  
	}
</script>
        
        <script>

            function adjustHeightOfPage(pageNo) {

                var offset = 80;
                var pageContentHeight = $(".cd-hero-slider li:nth-of-type(" + pageNo + ") .js-tm-page-content").height();

                if($(window).width() >= 992) { offset = 120; }
                else if($(window).width() < 480) { offset = 40; }
               
                
                var totalPageHeight = 15 + $('.cd-slider-nav').height()
                                        + pageContentHeight + offset
                                        + $('.tm-footer').height();

                if(totalPageHeight > $(window).height()) 
                {
                    $('.cd-hero-slider').addClass('small-screen');
                    $('.cd-hero-slider li:nth-of-type(' + pageNo + ')').css("min-height", totalPageHeight + "px");
                }
                else 
                {
                    $('.cd-hero-slider').removeClass('small-screen');
                    $('.cd-hero-slider li:nth-of-type(' + pageNo + ')').css("min-height", "100%");
                }
            }

           
            $(window).load(function(){

                adjustHeightOfPage(1); 

                
                $('.gallery-one').magnificPopup({
                    delegate: 'a', 
                    type: 'image',
                    gallery:{enabled:true}                
                });
				
			
				$('.gallery-two').magnificPopup({
                    delegate: 'a',
                    type: 'image',
                    gallery:{enabled:true}                
                });

        
                $('#tmNavbar a').click(function(){
                    $('#tmNavbar').collapse('hide');

                    adjustHeightOfPage($(this).data("no"));       
                });

               
                $( window ).resize(function() {
                    var currentPageNo = $(".cd-hero-slider li.selected .js-tm-page-content").data("page-no");
                    
                    
                    setTimeout(function() {
                        adjustHeightOfPage( currentPageNo );
                    }, 1000);
                    
                });
        
               
                $('body').addClass('loaded');
                           
            });

          
            var map = '';
            var center;

            function initialize() {
                var mapOptions = {
                    zoom: 15,
                    center: new google.maps.LatLng(22.9593472,88.4455396),
                    scrollwheel: false
                };
            
                map = new google.maps.Map(document.getElementById('google-map'),  mapOptions);

                google.maps.event.addDomListener(map, 'idle', function() {
                  calculateCenter();
                });
            
                google.maps.event.addDomListener(window, 'resize', function() {
                  map.setCenter(center);
                });
            }

            function calculateCenter() {
                center = map.getCenter();
            }

            function loadGoogleMap(){
                var script = document.createElement('script');
                script.type = 'text/javascript';
                script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' + 'callback=initialize';
                document.body.appendChild(script);
            }
        
            
            $(function() {                
                loadGoogleMap(); 
            });

        </script>            

</body>
</html>