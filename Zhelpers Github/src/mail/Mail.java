package mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail {
	final String from=""; //write your mail address here
	final String pass="";  //write your password  here
	final String host="";  //write your host address here
	
	public int sendMail(String mail,String messg,String subject)
	{
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
			message.setText(messg);
			Transport.send(message);
			System.out.println("mail send successfully...");
			return 1;
			
		}catch(Exception e){
			System.out.println(e);
			return 0;
		}
		
	}


}
