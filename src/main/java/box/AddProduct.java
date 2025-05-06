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
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProduct() {
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
		  String name = request.getParameter("name");
		    String description = request.getParameter("description");
		    String Stringamount = request.getParameter("amount");
		    String Stringprice = request.getParameter("price");
		    
		    int amount = Integer.parseInt(Stringamount);
		    double price = Double.parseDouble(Stringprice);
		    
		    byte[] imgData = null;
		    
		    
		    try {
			    Part filePart = request.getPart("productImage");
			    System.out.println(filePart.getSize());

			  //  String fileName = getFileName(filePart);
			    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
			    File uploadDir = new File(uploadPath);
			    if (!uploadDir.exists()) {
			        uploadDir.mkdir(); // Create the directory if it doesn't exist
			    }

			    

			    try (InputStream inputStream = filePart.getInputStream()) {
			        imgData = inputStream.readAllBytes();
			        
			        
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			    }catch(NullPointerException e) {
			
			    //	newUser.setPrpfilePic(staticImgPath); //image generated and set for the user
			    	}
		    
		    Product product = new Product(name,description,amount,price);
		    
		    product.getImages().add(imgData);
		    
		    Database connect = new Database();
		    
		    connect.insertProduct(product);
		    
		    request.getRequestDispatcher("Products.jsp").forward(request, response);
		    
	}

}
