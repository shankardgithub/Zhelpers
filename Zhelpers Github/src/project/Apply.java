package project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import connection.*;
import java.sql.*;
/**
 * Servlet implementation class Apply
 */
@WebServlet("/Apply")
public class Apply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			response.setHeader("Cache-control","no-cache,no-store,must-revalidate");
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			Connection cn=ConnectDatabase.getCn();
			String aid=request.getParameter("aid");
			String wid=request.getParameter("wid");
			String sql="insert into apply values(?,?)";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ps.setString(2, wid);
			ps.execute();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Successfully Applied');");
			out.println("location='worker.jsp';");
			out.println("</script>");	
		}catch(Exception e){
			System.out.println(e);
		}
	}

}
