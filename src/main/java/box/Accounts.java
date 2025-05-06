package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.Map;
import java.util.Random;
import java.util.Base64;
import java.sql.Blob;




@MultipartConfig
public class Accounts extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String URL = "jdbc:mysql://mysql-34364a6e-vehicles09.g.aivencloud.com:21946/defaultdb?useSSL=true&requireSSL=true";
	 private static String DB_USER = "avnadmin";
	    private static String DB_PASSWORD = "AVNS_QqDY7kXrl4nRX-3cyt8";
	private String[] staticPics = {"StaticPro1","StaticPro2","StaticPro3","StaticPro4","StaticPro5"};
    /**
     * Default constructor. 
     */
    public Accounts() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ServletContext context = request.getServletContext();
	    
	    
	    context.removeAttribute("loggedinUser");
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
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
	    
	    String specialChars = "!/[!@#$%^&*()_+\\-=\\[\\]{}";
	    
	    User newUser = null;
	    boolean userExist = true;
	    Database database = new Database();
	    
	    try {
	    	ArrayList<User> allusers = (ArrayList) database.getAllUsers();
	    	for(User user : allusers) {
	    		if(user.getEmail().equalsIgnoreCase(newEmail)) {
	    			userExist = true;
	    		}
	    	}
	    	
	    }catch(IndexOutOfBoundsException e) {
	    	
	    }
	    
	    try {
	    	if(!newEmail.isBlank() && !newPassword.isBlank() && !newFirstName.isBlank() && !newLastName.isBlank()){
	    		if(newPassword.length() > 7 && newPassword.equals(confirmPassword)) {
	    			for(char check : specialChars.toCharArray()) {
	    				if(newPassword.contains(String.valueOf(check))) {
	    					userExist = false;
	    					newUser = new User(newFirstName,newLastName,newEmail,newPassword);
	    				}
	    			}
	    		
	    		}
	    	}
	    	
	    }catch(NullPointerException e) {
	    	//System.out.println("Not empty");
	    }
	    
	    if(newUser == null) {
	    	request.getRequestDispatcher("SignUp.jsp").forward(request, response);
	    }

	    
	    try {
	    Part filePart = request.getPart("file");
	    System.out.println(filePart.getSize());

	    String fileName = getFileName(filePart);
	    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdir(); // Create the directory if it doesn't exist
	    }

	    String filePath = uploadPath + File.separator + fileName;
	    byte[] imgData = null;

	    try (InputStream inputStream = filePart.getInputStream()) {
	        imgData = inputStream.readAllBytes();
	        
	        System.out.print("Image being Set");
	        newUser.setPrpfilePic(imgData); //image provided by the user
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    }catch(NullPointerException e) {
	
	    //	newUser.setPrpfilePic(staticImgPath); //image generated and set for the user
	    	}
	    
	    if(newUser.getProfilePic().length == 0) {
	      	Random random = new Random();
	    	int num = random.nextInt(4); // generate a random index for a static profile pic
	    	String profilePicPath = "images/" + staticPics[num] + ".jpeg";
	    	byte[] staticImgPath = fileToByteArray(getServletContext(),profilePicPath);
	    	

	    	newUser.setPrpfilePic(staticImgPath); //image generated and set for the user

	    }

	    try {
	    String picPath = byteArrayToFile(newUser.getProfilePic());
	    }catch(NullPointerException e) {
	  
	    }
  	   // System.out.println(picPath);
	    if(!userExist) {
	    ServletContext context = request.getServletContext();
	    
	    
	    context.setAttribute("loggedinUser", newUser);
	    
	    database.insertUser(newUser);
	    
	    request.getRequestDispatcher("Profile.jsp").forward(request, response);
	}
	    // Add logic to save or process the data as needed
	}
	
	public static byte[] fileToByteArray(ServletContext context, String relativePath) throws IOException {
	    String absolutePath = context.getRealPath(relativePath);
	    File file = new File(absolutePath);

	    if (!file.exists()) {
	        throw new FileNotFoundException("File not found: " + absolutePath);
	    }

	    return Files.readAllBytes(file.toPath());
	}


	  public String getFileName(Part part) {
	        String contentDisposition = part.getHeader("content-disposition");
	        if (contentDisposition != null) {
	            for (String content : contentDisposition.split(";")) {
	                if (content.trim().startsWith("filename")) {
	                    return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
	                }
	            }
	        }
	        return null;
	    }
	  
	  public static String byteArrayToFile(byte[] byteArray) throws IOException {
	

		    // Create a temporary file with a generic extension (e.g., ".tmp")
		    File tempFile = Files.createTempFile("file_", ".tmp").toFile();

		    // Write the byte array to the temporary file
		    try (FileOutputStream fos = new FileOutputStream(tempFile)) {
		        fos.write(byteArray);
		    }

		    // Ensure the temporary file persists until explicitly deleted
		    tempFile.deleteOnExit();

		    // Return the absolute path of the created file
		    return tempFile.getAbsolutePath();
		}
	 

}
