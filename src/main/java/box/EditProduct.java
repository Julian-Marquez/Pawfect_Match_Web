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
public class EditProduct extends HttpServlet {
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
	    String Stringamount = request.getParameter("amount");
	    String Stringprice = request.getParameter("price");
		    
		    Accounts handle = new Accounts();
		    
		    ServletContext context = request.getServletContext();
		    
		    Product product = (Product) context.getAttribute("product");
		    
		    boolean productChanged = false;
		    
		    String oldName = product.getName();
		    String oldDescription = product.getDescription();
		    int oldAmount = product.getAmount();
		    double oldPrice = product.getPrice();
		    
		    if(!oldName.equals(name) && !name.isBlank()) {
		    	product.setName(name);
		    	productChanged = true;
		    }
		    if(!oldDescription.equals(description) && !description.isBlank()) {
		    	product.setDescription(description);
		    	productChanged = true;
		    }
		    
		    try {
		    	int amount = Integer.parseInt(Stringamount);		    	
		    	 if(amount != oldAmount && amount >= 1 ) {
				    	product.setAmount(amount);
				    	productChanged = true;
				    }
		    	
		    }catch(NumberFormatException e) {
		    	
		    }
		   try {
			   double price = Double.parseDouble(Stringprice);
		    if(price != oldPrice && price >= 0.99) {
		    	product.setPrice(price);
		    	productChanged = true;
		    }
		   }catch(NumberFormatException e) {
			   
		   }
		    
		    try {
			    Part filePart = request.getPart("productImage"); //this is to replace existing image
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
			        	product.getImages().set(0, imgData);
			        	productChanged = true;
			        }
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    }catch(NullPointerException e) {
			
			    
			    	}
		    try {
			    Part filePart = request.getPart("productImage2"); // this is to add on images
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
			        	product.getImages().add(imgData);
			        	productChanged = true;
			        }
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    }catch(NullPointerException e) {
			
			    
			    	}
		    
		    if(productChanged) {
		    	
		    	Database connect =  new Database();
		    	
		    	connect.updateProduct(product);
		    	
		    
		    request.getRequestDispatcher("Products.jsp").forward(request, response);
		    }else {
		    	request.getRequestDispatcher("editProduct.jsp").forward(request, response);
		    }
		    
	}

}
