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
 * Servlet implementation class Workersreviewup
 */
@WebServlet("/Workersreviewup")
public class Workersreviewup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		try{String comment= arg0.getParameter("comment");
		String rate= arg0.getParameter("rating");
		
		Connection cn=ConnectDatabase.getCn();
		HttpSession ses= arg0.getSession(false);
		String wid=(String)ses.getAttribute("wid");
		String eid=(String)ses.getAttribute("eid");
		String selectsql="select * from WORKER_REVIEW where EID=? and WID=?";
		PreparedStatement ps=cn.prepareStatement(selectsql);
		ps.setString(1, eid);
		ps.setString(2, wid);
		ResultSet rs= ps.executeQuery();
	if(rs.isBeforeFirst())
	{
		
		
		
String updatesql="update WORKER_REVIEW set RATING=?,REVIEW=? where EID=? and WID=?";
		
		PreparedStatement pu=cn.prepareStatement(updatesql);
		pu.setString(1, rate);
		pu.setString(2, comment);
		pu.setString(3, eid);
		pu.setString(4, wid);
		pu.executeUpdate();
	}
	else
		
		{
		String insertsql="insert into WORKER_REVIEW values(?,?,?,?)";
		PreparedStatement pi=cn.prepareStatement(insertsql);
		pi.setString(1, wid);
		pi.setString(2, eid);
		pi.setString(3, rate);
		pi.setString(4, comment);
		
		pi.execute(); }
		PrintWriter out= arg1.getWriter();
		
		out.println("<script type=\"text/javascript\">");
		out.println("alert('Successfully Posted');");
		out.println("location='worker.jsp';");
		out.println("</script>");
		 
		
		}
		catch(Exception e)
		{}
		
		
	}

}
