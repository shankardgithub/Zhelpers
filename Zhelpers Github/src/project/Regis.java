package project;
import connection.*;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Regis
 */
@WebServlet("/Regis")
public class Regis extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			PrintWriter ut=response.getWriter();
			Connection cn=ConnectDatabase.getCn();
			String f_name=request.getParameter("f_name");
			String l_name=request.getParameter("l_name");
			String m_num=request.getParameter("m_num");
			String pass=request.getParameter("pass");
			String c_pass=request.getParameter("c_pass");
			String d_o_b=request.getParameter("d_o_b");
			String gnder=request.getParameter("gnder");
			String state=request.getParameter("state");
			String city=request.getParameter("city");
			String p_num=request.getParameter("p_num");
			String sql="insert into Login values(?,?)";
			PreparedStatement ps=cn.prepareStatement(sql);
			ps.setString(1,  f_name);
			ps.setString(2, l_name);
			ps.setString(3, m_num);
			ps.setString(4, pass);
			ps.setString(5, c_pass);
			ps.setString(6, d_o_b);
			ps.setString(7, gnder);
			ps.setString(8, state);
			ps.setString(9, city);
			ps.setString(10, p_num);
			ps.execute();
			ut.print("success");
			RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
		}catch(Exception e){
			System.out.println(e);
		}
	}

}
