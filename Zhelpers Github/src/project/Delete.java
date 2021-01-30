package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connection.ConnectDatabase;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
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
			String sql="DELETE FROM advertisement WHERE aid=?";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ps.execute();
			sql="DELETE FROM apply WHERE aid=?";
			ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ps.execute();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Successfully Deleted advertisement');");
			out.println("location='user.jsp';");
			out.println("</script>");	
		}catch(Exception e){
			System.out.println(e);
	}
	}
}
