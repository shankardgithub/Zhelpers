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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class emplrsreviewup
 */
@WebServlet("/emplrsreviewup")
public class emplrsreviewup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
	try{
		arg1.setHeader("Cache-control","no-cache,no-store,must-revalidate");
		HttpSession session=arg0.getSession();
		String n=(String)session.getAttribute("id");
		if(n==null){
			arg1.sendRedirect("index.jsp");
		}
		Connection cn=ConnectDatabase.getCn();
		
	String comment= arg0.getParameter("comment");
	String rate= arg0.getParameter("rating");
	
	
	HttpSession ses= arg0.getSession(false);
	String wid=(String)ses.getAttribute("wid");
	String eid=(String)ses.getAttribute("eid");
	String wtype=(String)ses.getAttribute("wtype");
	System.out.println(wid);
	System.out.println(eid);System.out.println(wtype);System.out.println(rate);System.out.println(comment);
	String selectsql="select * from EMPL_REVIEW where EID=? and WID=? and type=?";
	PreparedStatement ps=cn.prepareStatement(selectsql);
	ps.setString(1, eid);
	ps.setString(2, wid);
	ps.setString(3, wtype);
	ResultSet rs= ps.executeQuery();
	if(rs.isBeforeFirst())
		
	{System.out.println("not empty");
	
	

		String updatesql="update EMPL_REVIEW set RATING=?,REVIEW=? where EID=? and WID=? and type=? ";
		
		PreparedStatement pu=cn.prepareStatement(updatesql);
		pu.setString(1, rate);
		pu.setString(2, comment);
		pu.setString(3, eid);
		pu.setString(5, wtype);
		pu.setString(4, wid);
		pu.executeUpdate();
		

		
	}
	
	
	else {
	String insertsql="insert into EMPL_REVIEW values(?,?,?,?,?)";
	
	PreparedStatement pi=cn.prepareStatement(insertsql);

	pi.setString(1, eid);
	pi.setString(2, wid);
	pi.setString(3, rate);
	pi.setString(4, comment);
	pi.setString(5, wtype);

	
	pi.execute();}
	
	
	PrintWriter out= arg1.getWriter();
	
	out.println("<script type=\"text/javascript\">");
	out.println("alert('Successfully Posted');");
	out.println("location='user.jsp';");
	out.println("</script>");
	 
	
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
	
	}
}
