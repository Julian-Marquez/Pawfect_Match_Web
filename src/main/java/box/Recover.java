package box;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.random.*;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * Servlet implementation class Recover
 */
public class Recover extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private long setCode = 0;
	private String setEmail;
	private User loggedinUser;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Recover() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ServletContext context = getServletContext();
		
		Database connect =  new Database();
		
		String code = request.getParameter("code");
		String action = request.getParameter("action");
		String email = request.getParameter("email");
		setEmail = request.getParameter("email");
		
		
		
		if(action.equals("login")) {
			
			try {
				long checkCode = Long.parseLong(code);
				
				if(checkCode == setCode) {
					
					context.setAttribute("loggedinUser", loggedinUser);
					request.getRequestDispatcher("Profile.jsp").forward(request, response);
					
				}
				
			}catch(NumberFormatException e) {
				request.getRequestDispatcher("Recover.jsp").forward(request, response);
			}
			
			
			
		}
		else if(action.equals("reSendCode")) {
					
					Random random =  new Random();
					setCode = random.nextInt(1000000,99999999);
					
					sendEmail(loggedinUser,setCode);
					request.getRequestDispatcher("Recover.jsp").forward(request, response);
				
			
			
		}
		else {
			System.out.println("Attempting to send email");
			boolean codeSent = false;
			List<User> allUsers = connect.getAllUsers();
			
			
			
			for(User user: allUsers) {
				if(user.getEmail().equals(email)) {
					
					Random random =  new Random();
					codeSent = true;
					setCode = random.nextInt(1000000,99999999);
					loggedinUser = user;
					
					sendEmail(user,setCode);
					context.setAttribute("codeSent", codeSent);
					request.getRequestDispatcher("Recover.jsp").forward(request, response);
					
				}
			}
			
			
		}
		
		
		
	}
	
	private void sendEmail(User user, long code) throws UnsupportedEncodingException {
		
		
		String subject = "Recovery Code Request";
		String content = "Hello " + user.getFirstname() + " your recovery code is: " + code;
		
		 String host = "smtp.gmail.com";
	        int port = 587;
	        Properties props = new Properties();
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.port", port);
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");

	        // Authentication information
	        String username = "turbotowing505@gmail.com"; // Use your Gmail address
	        String password = "pwnd mleh nfgf tkxt"; // Use the app-specific password

	        // Create a session with the properties and the authenticator
	        Session session = Session.getInstance(props, new Authenticator() {
	            @Override
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(username, password);
	            }
	        });

	        try {
	            // Create a message
	            Message message = new MimeMessage(session);
	            message.setFrom(new InternetAddress("Pawfect_Team@gmail.com", "Pawfect Team"));
	            message.setReplyTo(InternetAddress.parse("Pawfect_Team@gmail.com"));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
	            message.setSubject(subject);
	            message.setText(content);

	            // Send the message
	            Transport.send(message);

	            System.out.println("Email sent successfully!");
	        } catch (MessagingException e) {
	            e.printStackTrace(); // Print the exception details (you can customize this)
	        }
		
	}

}
