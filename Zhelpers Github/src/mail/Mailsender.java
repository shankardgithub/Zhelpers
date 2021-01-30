package mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mailsender {
	
	final String from=""; //write your mail address here
	final String pass="";  //write your password  here
	final String host="";  //write your host address here
	final String subject="Reset Your Password";
	
	public int sendMail(String mail, String name, String token)
	{
		
		final String messg="<center>"
				+ "<h2>Express Service</h2>"
				+ "</center>"
				+ "<p>Hi "+name+",</p>"
				+ "<p>We've received a request to reset your password. If you don't make the request, just ignore this email. Other wise you can reset your password using this link</p>"
				+ "<center><a href='http://localhost:10108/Zhelpers/setpass.jsp?token="+token+"&mail="+mail+"'>"
				+ "<button style='width: 50%;  background-color: #4CAF50;border: none;color: white;padding: 15px 32px;text-align: center;text-decoration: none;display: inline-block;font-size: 16px;margin: 4px 2px;cursor: pointer;'>"
				+ "Click Here To Reset Your Password"
				+ "</button>"
				+ "</a></center>"
				+ "<p>Thanks,</p>"
				+ "<p>Team Devacharya</p>"
				+ "<center><br><br>"
				+ "<p>Note : This is an auto-generated email. Please Do not reply.</p>"
				+ "<h4>Have Queries?</h4>"
				+ "<p>Feel free to mail us at support@devachrya.in</p>"
				+ "<p>Devachrya Pvt. Ltd.</p>"
				+ "</center>";

		Properties props=new Properties();

		props.put("mail.smtp.host", host);
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.auth","true");
		props.put("mail.smtp.starttls.enable","true");
		props.put("mail.user", from);
		props.put("mail.password",pass);
		props.put("mail.port","465");

		Session mailsession=Session.getInstance(props,new Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(from,pass);
			}
		});

		try{
			MimeMessage message=new MimeMessage(mailsession);
			message.setFrom(new InternetAddress(from));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));
			message.setSubject(subject);
			message.setContent( messg, "text/html");
			Transport.send(message);
			System.out.println("mail send successfully...");
			return 1;
			
		}catch(Exception e){
			System.out.println(e);
			return 0;
		}
		
	}

}
