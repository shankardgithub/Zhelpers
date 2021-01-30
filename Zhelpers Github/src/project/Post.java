package project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import connection.*;
import java.sql.*;
import java.text.SimpleDateFormat;

/**
 * Servlet implementation class Post
 */
@WebServlet("/Post")
public class Post extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			String mobile=n;
			String city=request.getParameter("city");
			String type=request.getParameter("type");
			String min=request.getParameter("min");
			String max=request.getParameter("max");
			String des=request.getParameter("des");
			String sql="insert into advertisement values(?,?,?,?,?,?,?,?)";
			String date = new SimpleDateFormat("yyMMddhhmmss").format(new Date());
			String aid= mobile+date;
			date= new SimpleDateFormat("dd-MM-yyy").format(new Date());
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ps.setString(2, date);
			ps.setString(3, mobile);
			ps.setString(4, des);
			ps.setString(5, city);
			ps.setString(6, min);
			ps.setString(7, max);
			ps.setString(8, type);
			ps.execute();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Successfully Posted');");
			out.println("location='user.jsp';");
			out.println("</script>");				
		}catch(Exception e){
			System.out.println(e);
		}
	}

}
