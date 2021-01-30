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
 * Servlet implementation class Dataprovider
 */
@WebServlet("/Dataprovider")
public class Dataprovider extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		final String param=request.getParameter("param");
		final String op=request.getParameter("op");
		String sql = "";
		String ar = "";
		try
		{
			Connection cn = ConnectDatabase.getCn();
			if(op.equals("state")) {
				sql="SELECT DISTINCT DISTRICT FROM ADDRESS WHERE STATE = '"+param+"' ORDER BY DISTRICT";
			}
			else
			{
				sql="SELECT DISTINCT AREA FROM ADDRESS WHERE DISTRICT = '"+param+"' ORDER BY AREA";
			}
			PreparedStatement ps=cn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				
				ar = ar+rs.getString(1)+",";
			}
			System.out.println("mydata "+sql);
			String p = ar.substring(0,(ar.length()-1));
			out.print(p);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
