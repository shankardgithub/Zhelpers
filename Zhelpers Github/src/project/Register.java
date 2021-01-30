package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import connection.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out=response.getWriter();
		final String fname=request.getParameter("fname");
		final String lname=request.getParameter("lname");
		final String email=request.getParameter("email");
		final String phno=request.getParameter("phno");
		final String password=request.getParameter("password");
		final String apno=request.getParameter("apno");
		final String ad=request.getParameter("ad");
		final String add=request.getParameter("add");
		final String pin=request.getParameter("pin");
		final String state=request.getParameter("state");
		final String district=request.getParameter("district");
		final String utype=request.getParameter("utype");
		final String dob=request.getParameter("dob");
		final String gender=request.getParameter("gender");
		final String otp=request.getParameter("otp");
		String dotp="null";
		Connection cn;	
		try {
			cn = ConnectDatabase.getCn();
			String sql="select mess from otp where email='"+email+"'"; 
			PreparedStatement ps=cn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				
				dotp = rs.getString(1);
	
			}
			System.out.println("mydata"+otp+email+sql);
			if((dotp == null) || (!(otp.equals(dotp))))
			{
				out.print("wrongotp");
				System.out.println(otp+"=="+dotp);
			}
			else
			{
				System.out.println("tab");
				String insertsql;
				String login;
				
				if(utype.equals("user"))
				{
					System.out.println("tab");
					login = "insert into NLOGIN values(?,?,?)";
					PreparedStatement rnps=cn.prepareStatement(login);
					rnps.setString(1, phno);
					rnps.setString(2, password);
					rnps.setString(3, "u");
					rnps.execute();
					 insertsql="insert into USERDETAILS values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				}
				else
				{
					System.out.println("tab");
					login = "insert into NLOGIN values(?,?,?)";
					PreparedStatement rnps=cn.prepareStatement(login);
					rnps.setString(1, phno);
					rnps.setString(2, password);
					rnps.setString(3, "w");
					rnps.execute();
					 insertsql="insert into WORKERDETAILS values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				}
				PreparedStatement rps=cn.prepareStatement(insertsql);
				rps.setString(1, fname);
				rps.setString(2, lname);
				rps.setString(3, phno);
				rps.setString(4, email);
				rps.setString(5, password);
				rps.setString(6, dob);
				rps.setString(7, gender);
				rps.setString(8, apno);
				rps.setString(9, ad);
				rps.setString(10, add);
				rps.setString(11, state);
				rps.setString(12, district);
				rps.setString(13, pin);
				rps.execute();
				
				System.out.println("sucess");
				out.print("sucess");
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.print("problem");
		}
		
	}

}
