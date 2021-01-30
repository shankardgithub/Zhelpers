package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connection.*;

/**
 * Servlet implementation class Accept
 */
@WebServlet("/Accept")
public class Accept extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			response.setHeader("Cache-control","no-cache,no-store,must-revalidate");
			HttpSession session=request.getSession();
			String n=(String)session.getAttribute("id");
			if(n==null){
				response.sendRedirect("index.jsp");
			}
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			Connection cn=ConnectDatabase.getCn();
			String aid=request.getParameter("aid");
			String wid=request.getParameter("wid");
			String sql="select * from advertisement where aid=?";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ResultSet rs=ps.executeQuery();
			String type="";
			if(rs.next()){
				type=rs.getString(8) ;
			}
			sql="INSERT INTO accept values(?,?,?,?)";
			String date= new SimpleDateFormat("dd-MM-yyy").format(new Date());
			ps=cn.prepareStatement(sql);
			ps.setString(1, n);
			ps.setString(2, wid);
			ps.setString(3, date);
			ps.setString(4, type);
			ps.execute();
			sql="DELETE FROM apply WHERE aid=? and wid=?";
			ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ps.setString(2, wid);
			ps.execute();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Successfully Accepted');");
			out.println("location='user.jsp';");
			out.println("</script>");	
		}catch(Exception e){
			System.out.println(e);
	}
	}

}
