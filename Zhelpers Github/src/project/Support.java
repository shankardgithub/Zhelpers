package project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mail.*;
/**
 * Servlet implementation class Support
 */
@WebServlet("/Support")
public class Support extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		final String email=request.getParameter("email");
		final String name=request.getParameter("name");
		final String subject=request.getParameter("subject");
		String messege=request.getParameter("messege");
		try {
	
				Mail  ms = new Mail();
				messege = "Messege from "+name+" email id ("+email+")\n"+messege;
				int s = ms.sendMail("",messege, subject); //enter your email here
				System.out.println(s);
				out.print("Your messege sent sucessfully");
			}
			catch (Exception e) {
			e.printStackTrace();
			out.print("Something went wrong please try again");
		}
	}

}
