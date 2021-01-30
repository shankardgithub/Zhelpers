package mail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.*;

/**
 * Servlet implementation class Otpsender
 */
@WebServlet("/Otpsender")
public class Otpsender extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		final String mail=request.getParameter("mail");
		System.out.println(mail);
		Connection cn;
		String uname = null;
		String wname = null;
		
		try {
			cn = ConnectDatabase.getCn();
			
			System.out.println("u");
			
			String usql="select firstname from USERDETAILS where MAIL='"+mail+"'"; 
			String wsql="select firstname from WORKERDETAILS where MAIL='"+mail+"'";
			PreparedStatement ups=cn.prepareStatement(usql);
			PreparedStatement wps=cn.prepareStatement(wsql);
			ResultSet urs=ups.executeQuery();
			ResultSet wrs=wps.executeQuery();
			
			while(urs.next()){
				
				uname = urs.getString(1);
	
			}
			while(wrs.next()){
				
				wname = wrs.getString(1);
	
			}
			if((uname != null) || (wname != null))
			{
				out.print("Exists");
			}
			else
			{
				String token = getAlphaNumericString(5);
				
				String search="Select * from OTP where email=?";
				String dlt="delete from OTP where email=?";
				PreparedStatement ps1=cn.prepareStatement(search);
				ps1.setString(1, mail);
				PreparedStatement ps2=cn.prepareStatement(dlt);
				ps2.setString(1, mail);
				ResultSet nrs=ps1.executeQuery();
				if(nrs.next()){
					ps2.execute();
				}
				String insertsql="insert into otp values(?,?)";
				PreparedStatement rps=cn.prepareStatement(insertsql);
				rps.setString(1, mail);
				rps.setString(2, token);
				
				rps.execute();
				Mail  ms = new Mail();
				String messg = "You otp is "+token;
				String subject = "OTP for registration";
				int s = ms.sendMail(mail, messg, subject);
				System.out.println(s);
				out.print("send");
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.print("problem");
		}
	}
	 public String getAlphaNumericString(int n) 
	    { 
	  
	        String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	                                    + "0123456789"
	                                    + "abcdefghijklmnopqrstuvxyz"; 
	  
	        StringBuilder sb = new StringBuilder(n); 
	  
	        for (int i = 0; i < n; i++) { 
	            int index 
	                = (int)(AlphaNumericString.length() 
	                        * Math.random()); 
	            sb.append(AlphaNumericString 
	                          .charAt(index)); 
	        } 
	  
	        return sb.toString(); 
	    } 


}
