package box;

import java.util.UUID;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Blob;
import java.util.Base64;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.sql.Date;
import java.text.*;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * Servlet implementation class handleProducts
 */
@MultipartConfig
public class handleAnimals extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public handleAnimals() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String stringId = request.getParameter("animalId");
		String action = request.getParameter("action");
		
		ServletContext context = getServletContext();
		
		
		long id = Long.parseLong(stringId);
		
		Database connect = new Database();
		
		try {
			if(action.equals("delete")) {
				System.out.println(" animal Id Check: " + id);
				connect.removeAnimal(id);
				request.getRequestDispatcher("AllAnimals.jsp").forward(request, response);
				
			}
			
			
		}catch(NullPointerException e) {
			
		}
		try {
			if(action.equals("edit")) {
				System.out.println(" edit option chosen");
				for(Animal animal : connect.getAllAnimals()) {
					if(animal.getAnimalId() == id) {
				context.setAttribute("animal", animal);
				request.getRequestDispatcher("editAnimal.jsp").forward(request, response);
				}
				}
			}
			
			
		}catch(NullPointerException e) {
			
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    String breed = request.getParameter("breed");
	    String stringAge = request.getParameter("age");
	    String foundDate = request.getParameter("date");
	    
	    ServletContext context = request.getServletContext();
	    
	    int age =  Integer.parseInt(stringAge);
	    int year = Integer.parseInt(foundDate.substring(0,4));
		int month = Integer.parseInt(foundDate.substring(5,7));
		int day = Integer.parseInt(foundDate.substring(8,10));
	  
	    
		LocalDate today = LocalDate.now();
		LocalDate date = LocalDate.of(year,month,day);

	 

	    Database connect = new Database();
	    
	    Accounts work = new Accounts();
	    
	    
	    
	    
	    try {
		    Part filePart = request.getPart("animalImage");
		    
		    String fileName = work.getFileName(filePart);
		    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
		    File uploadDir = new File(uploadPath);
		    if (!uploadDir.exists()) {
		        uploadDir.mkdir(); // Create the directory if it doesn't exist
		    }

		    String filePath = uploadPath + File.separator + fileName;
		    byte[] imgData = null;

		    try (InputStream inputStream = filePart.getInputStream()) {
		        imgData = inputStream.readAllBytes();
		        
		        Animal animal = new Animal(name,breed,description,age,date);
		        animal.getImages().add(imgData);
		        System.out.print(" Animal info: " + animal.getAge() + " " + animal.getName() + " " + animal.getBreed() + " "  + animal.getDateFound().toString());
		        System.out.println(" length of animal image is: " + animal.getImages().get(0).length);
		        connect.insertAnimal(animal);
		        
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		    }catch(NullPointerException e) {
		
		    //	newUser.setPrpfilePic(staticImgPath); //image generated and set for the user
		    	}
		    
	    request.getRequestDispatcher("AllAnimals.jsp").forward(request, response);
	    
	}


}
