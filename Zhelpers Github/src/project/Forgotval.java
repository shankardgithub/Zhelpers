package project;

import java.io.IOException;
import java.io.PrintWriter;
import connection.*;
import mail.*;
import java.sql.*;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Forgotval
 */
@WebServlet("/Forgotval")
public class Forgotval extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String mail=request.getParameter("mail");
		String uname = null;
		String wname = null;
		Connection cn;
		String name = null;
		try {
			cn = ConnectDatabase.getCn();
			String usql="select firstname from USERDETAILS where MAIL='"+mail+"'"; 
			String wsql="select firstname from WORKERDETAILS where MAIL='"+mail+"'";
			PreparedStatement ups=cn.prepareStatement(usql);
			PreparedStatement wps=cn.prepareStatement(wsql);
			ResultSet urs=ups.executeQuery();
			ResultSet wrs=wps.executeQuery();
			while(urs.next()){
				
				uname = urs.getString(1);
				name = uname;
	
			}
			while(wrs.next()){
				
				wname = wrs.getString(1);
				name = wname;
			}
			if((uname == null) && (wname == null))
			{
				out.print("No register user exists with this email id Register Now to use");
			}
			else
			{
				System.out.println("J"+"\n"+mail+"\n"+uname+"\n"+wname);
				String token = getAlphaNumericString(20);
				String search="Select * from forgotpassword where Email=?";
				String dlt="delete from forgotpassword where Email=?";
				PreparedStatement ps1=cn.prepareStatement(search);
				ps1.setString(1, mail);
				PreparedStatement ps2=cn.prepareStatement(dlt);
				ps2.setString(1, mail);
				ResultSet nrs=ps1.executeQuery();
				if(nrs.next()){
					ps2.execute();
				}
				Calendar cal = Calendar.getInstance();
				int min =cal.get(Calendar.MINUTE);
				int hr = cal.get(Calendar.HOUR);
				String insertsql="insert into forgotpassword values(?,?,?,?)";
				PreparedStatement rps=cn.prepareStatement(insertsql);
				rps.setString(1, mail);
				rps.setString(2, token);
				rps.setLong(3, hr);
				rps.setLong(4, min);
				rps.execute();
				Mailsender  ms = new Mailsender();
				int s = ms.sendMail(mail, name,token);
				System.out.println(s);
				out.print("Mail send sucessfully. Please Check your mail to change the password");
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.print("Some problem occur please try again");
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
