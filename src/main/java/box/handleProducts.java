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
import java.sql.Date;
import java.text.*;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class handleProducts
 */
public class handleProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public handleProducts() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String stringId = request.getParameter("productId");
		String delete = request.getParameter("delete");
		String edit = request.getParameter("edit");
		
		
		long id = Long.parseLong(stringId);
		
		Database connect = new Database();
		
		try {
			if(delete.equals("delete")) {
				connect.removeProduct(id);
				request.getRequestDispatcher("Products.jsp").forward(request, response);
				
			}
			
			
		}catch(NullPointerException e) {
			
		}
		try {
			if(edit.equals("edit")) {
				for(Product product : connect.getAllProducts()) {
					if(product.getProductId() == id) {
				request.setAttribute("product", product);
				request.getRequestDispatcher("editProduct.jsp").forward(request, response);
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
	    String view = request.getParameter("view");
	    String stringId = request.getParameter("productId");
	    String cart = request.getParameter("addtocart");
	    String stringAmount = request.getParameter("amount");
	    
	    ServletContext context = request.getServletContext();
	    User user = (User) context.getAttribute("loggedinUser");

	    if (stringId == null || user == null) {
	        // Redirect to login if no product ID or user is not logged in
	        request.getRequestDispatcher("Login.jsp").forward(request, response);
	        return;
	    }

	    long productId;
	    int amount = 1;

	    try {
	        productId = Long.parseLong(stringId);
	        if (stringAmount != null) {
	            amount = Integer.parseInt(stringAmount);
	        }
	    } catch (NumberFormatException e) {
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID or amount");
	        return;
	    }

	    Database connect = new Database();
	    Product productForUser = null; 
	    
	    
	    List<Product> products = connect.getAllProducts(); // Fetch product directly
	    
	    
	    boolean found = false;
	    try {
	    	for(Product product : products) {
	    		if(productId == product.getProductId()) {
	    			productForUser = product;
	    			product.setAmount(amount);
	    			found = true;
	    		}
	    	}
	    	
	    	
	    }catch(IndexOutOfBoundsException e) {
	    	
	    }

	    if (productForUser == null) {
	        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
	        return;
	    }

	    try {
	        if ("view".equals(view)) {
	            context.setAttribute("product", productForUser);
	            request.getRequestDispatcher("ProductInfo.jsp").forward(request, response);
	            return;
	        }

	        if ("addtocart".equals(cart)) {
	            boolean isUpdated = false;

	            // Check if product already exists in user's cart
	            for (Product userProduct : user.getAllProducts()) {
	                if (userProduct.getProductId() == productId) {
	                    int newAmount = userProduct.getAmount() + amount;
	                    userProduct.setAmount(newAmount);
	                    connect.updateProductForUser(user.getUserId(), productId, newAmount);
	                    isUpdated = true;
	                	context.setAttribute("loggedinUser", user);
			            request.getRequestDispatcher("Products.jsp").forward(request, response);
	                    break;
	                }
	            }

	            if (!isUpdated) {
	                // Add new product to the cart
	                productForUser.setAmount(amount);
	                connect.insertProductForUser(user.getUserId(), productId, amount);
	                user.getAllProducts().add(productForUser);
	            }

	            // Update context with logged-in user
	            context.setAttribute("loggedinUser", user);
	            request.getRequestDispatcher("Products.jsp").forward(request, response);
	        }
	        
	        else {
	        	
	        	if(user.getAllPayments() != null) {
	        		System.out.println(" amount being sent " + amount);
	        		Card payment = user.getAllPayments().get(0);
	        		double tax = 0.07 *(productForUser.getPrice() * amount);
	        		double fee = 5.0;
	        		double subtotal = tax + (productForUser.getPrice() * amount) + fee;
	        		DecimalFormat df = new DecimalFormat("#,###.##");
	        		String format = df.format(subtotal);
	        		double total = Double.parseDouble(format);
	        		System.out.println(" formated as: " + format + " ");
	        		List<Product> receiptProducts = new ArrayList<>();
	        		receiptProducts.add(productForUser);
	        		Receipt receipt = new Receipt(total,receiptProducts,payment);
	        		connect.insertReceipt(receipt, user.getUserId());
	        		user.getAllReceipts().add(receipt);
	        		context.setAttribute("loggedinUser", user);
		            request.getRequestDispatcher("Products.jsp").forward(request, response);
	        	}else {
	        		request.getRequestDispatcher("AddPayment.jsp").forward(request, response);
	        	}
	        	
	        	
	        	
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request");
	    }
	}


}
