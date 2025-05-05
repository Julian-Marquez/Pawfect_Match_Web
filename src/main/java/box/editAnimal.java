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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


@MultipartConfig
public class editAnimal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  

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
		String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    String Stringage = request.getParameter("age");
	    String breed = request.getParameter("breed");
	    String dateString = request.getParameter("date");
		    
		    Accounts handle = new Accounts();
		    
		    ServletContext context = request.getServletContext();
		    
		    Animal animal = (Animal) context.getAttribute("animal");
		    
		    boolean Changed = false;
		    
		    String oldName = animal.getName();
		    String oldDescription = animal.getDescription();
		    String oldBreed= animal.getBreed();
		    int oldAge = animal.getAge();
		    LocalDate oldDate = animal.getDateFound();
		    
		    if(!oldName.equals(name) && !name.isBlank()) {
		    	animal.setName(name);
		    	Changed = true;
		    }
		    if(!oldDescription.equals(description) && !description.isBlank()) {
		    	animal.setDescription(description);
		    	Changed = true;
		    }
		    
		    if (dateString != null && !dateString.isBlank()) {
		    	int year = Integer.parseInt(dateString.substring(0,4));
				int month = Integer.parseInt(dateString.substring(5,7));
				int day = Integer.parseInt(dateString.substring(8,10));
		        try {
		            LocalDate date = LocalDate.of(year,month,day); // Assumes ISO format (yyyy-MM-dd)
		            LocalDate today = LocalDate.now();
		            if (today.isAfter(date) && !oldDate.equals(date)) {
		            	System.out.println(" Date Changed ");
		                animal.setDateFound(date);
		                Changed = true;
		            }
		        } catch (DateTimeParseException e) {
		            // Handle invalid date format
		            System.err.println("Invalid date format: " + dateString);
		        }
		    }

		    
		    try {
		    	int age = Integer.parseInt(Stringage);		    	
		    	 if(age != oldAge && age >= 0 ) {
				    	animal.setAge(age);
				    	Changed = true;
				    }
		    	
		    }catch(NumberFormatException e) {
		    	
		    }
		    if(!oldBreed.equals(breed) && !breed.isBlank()) {
		    	animal.setBreed(breed);
		    	Changed = true;
		    }
		    
		    try {
			    Part filePart = request.getPart("animalImage"); //this is to replace existing image
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
			        	animal.getImages().set(0, imgData);
			        	Changed = true;
			        }
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    }catch(NullPointerException e) {
			
			    
			    	}
		    try {
			    Part filePart = request.getPart("animalImage2"); // this is to add on images
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
			        	animal.getImages().add(imgData);
			        	Changed = true;
			        }
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    }catch(NullPointerException e) {
			
			    
			    	}
		    
		    if(Changed) {
		    	
		    	Database connect =  new Database();
		    	
		    	connect.updateAnimal(animal);
		    	
		    
		    request.getRequestDispatcher("AllAnimals.jsp").forward(request, response);
		    }else {
		    	request.getRequestDispatcher("editAnimal.jsp").forward(request, response);
		    }
		    
	}

}
