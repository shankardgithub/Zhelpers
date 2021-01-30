package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import connection.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Passchange
 */
@WebServlet("/Passchange")
public class Passchange extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String mail=request.getParameter("mail");
		String token=request.getParameter("token");
		String password=request.getParameter("password");
		Calendar cal = Calendar.getInstance();
		long min =cal.get(Calendar.MINUTE);
		long hrs = cal.get(Calendar.HOUR);
		String mail2=null;
		long hr=9999;
		long mi=9999;
		try{
		Connection cn = ConnectDatabase.getCn();
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
					String updatesql="update UserDetails set PASSWORD=? where MAIL=?";
					
					PreparedStatement ups=cn.prepareStatement(updatesql);
					ups.setString(1, password);
					ups.setString(2, mail);
					
					ups.execute();
					
					out.print("Password Updated Sucessfully");
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
	}

}
