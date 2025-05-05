package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


@MultipartConfig
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditProfile() {
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
		 String newEmail = request.getParameter("Email");
		    String newPassword = request.getParameter("Password");
		    String confirmPassword = request.getParameter("ConfirmPassword");
		    String newFirstName = request.getParameter("Firstname");
		    String newLastName = request.getParameter("Lastname");
		    
		    Accounts handle = new Accounts();
		    String specialChars = "!/[!@#$%^&*()_+\\-=\\[\\]{}";
		    
		    ServletContext context = request.getServletContext();
		    
		    User user = (User) context.getAttribute("loggedinUser");
		    
		    boolean userChanged = false;
		    
		    String ogEmail = user.getEmail();
		    String ogPassword = user.getPassword();
		    String ogFirstname = user.getFirstname();
		    String ogLastname = user.getLastname();
		    
		    if(!ogEmail.equals(newEmail) && !newEmail.isBlank()) {
		    	user.setEmail(newEmail);
		    	userChanged = true;
		    }
		    if(!ogPassword.equals(newPassword) && !newPassword.isBlank()) {
		    	for(char check : specialChars.toCharArray()) {
		    	if(newPassword.equals(confirmPassword) && newPassword.contains(String.valueOf(check))) {
		    	user.setPasswrod(newPassword);
		    	userChanged = true;
		    	}
		    	}
		    }
		    if(!ogFirstname.equals(newFirstName) && !newFirstName.isBlank()) {
		    	user.setFirstname(newFirstName);
		    	userChanged = true;
		    }
		    if(!ogLastname.equals(newLastName) && !newLastName.isBlank()) {
		    	user.setLastname(newLastName);
		    	userChanged = true;
		    }
		    
		    try {
			    Part filePart = request.getPart("file");
			    System.out.println(filePart.getSize());

			    String fileName = handle.getFileName(filePart);
			    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
			    File uploadDir = new File(uploadPath);
			    if (!uploadDir.exists()) {
			        uploadDir.mkdir(); // Create the directory if it doesn't exist
			    }

			    String filePath = uploadPath + File.separator + fileName;
			    byte[] imgData = null;

			    try (InputStream inputStream = filePart.getInputStream()) {
			        imgData = inputStream.readAllBytes();
			        
			        if(filePart.getSize() != 0) {
			        	userChanged = true;
			        user.setPrpfilePic(imgData); //image provided by the user
			        }
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    }catch(NullPointerException e) {
			
			    //	newUser.setPrpfilePic(staticImgPath); //image generated and set for the user
			    	}
		    
		    if(userChanged) {
		    	
		    	Database connect =  new Database();
		    	
		    	connect.updateUser(user);
		    	
		    context.setAttribute("loggedinUser", user);
		    
		    request.getRequestDispatcher("Profile.jsp").forward(request, response);
		    }else {
		    	request.getRequestDispatcher("EditProfile.jsp").forward(request, response);
		    }
		    
	}

}
