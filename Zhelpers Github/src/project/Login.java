package project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connection.ConnectDatabase;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
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
			String aid=request.getParameter("id");
			String pass=request.getParameter("pass");
			String sql="select * from nlogin where mobile=? and pass=?";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1, aid);
			ps.setString(2, pass);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				HttpSession session=request.getSession();  
		        session.setAttribute("id",rs.getString(1));
		        String p=rs.getString(3);
		        if(p.equals("u")){
		        	out.println("<script type=\"text/javascript\">");
					out.println("location='user.jsp';");
					out.println("</script>");
		        }
		        else if(p.equals("w")){
		        	out.println("<script type=\"text/javascript\">");
					out.println("location='worker.jsp';");
					out.println("</script>");
		        }
			}else{
				out.println("<script type=\"text/javascript\">");
				out.println("alert('Wrong credentials!');");
				out.println("location='index.jsp';");
				out.println("</script>");
				
			}			
		}catch(Exception e){
			System.out.println(e);
		}
	}

}
