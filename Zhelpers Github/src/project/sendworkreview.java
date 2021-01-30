package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class sendworkreview
 */
@WebServlet("/sendworkreview")
public class sendworkreview extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
		protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
			try{String eid= arg0.getParameter("eid");
			String wid= arg0.getParameter("wid");
			String wt= arg0.getParameter("wtypes");
			HttpSession ses= arg0.getSession();
			ses.setAttribute("wid", wid);
			ses.setAttribute("eid", eid);ses.setAttribute("wtypes", wt);
			//String comment= arg0.getParameter("comment");
			//String rate= arg0.getParameter("rating");
			
			///Connection cn=DatabaseConnection.getCn();

			
			//String insertsql="insert into WORKER_REVIEW values(?,?,?,?)";
			
			
			//PreparedStatement ps=cn.prepareStatement(insertsql);
			//ps.setString(1, wid);
			//ps.setString(3, rate);
			//ps.setString(2, eid);
			//ps.setString(4, comment);
			
			//ps.execute(); 
			//PrintWriter out= arg1.getWriter();
			
			//out.println("<script type=\'text/javascript\'>");
			 //  out.println("alert('Your review has been submitted..');");
			   
			 //  out.println("</script>");
			   arg1.sendRedirect("worker_doreview.jsp");
			 
			
			}
			//arg0.setAttribute("cidd", cid);
		//RequestDispatcher rd=	arg0.getRequestDispatcher("showsinglec.jsp");
			//rd.include(arg0,arg1);
			
			

		
	catch(Exception e)
	{
		
	}

	}

}
