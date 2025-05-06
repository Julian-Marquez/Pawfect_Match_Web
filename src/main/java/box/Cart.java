package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

/**
 * Servlet implementation class Cart
 */
public class Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Cart() {
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
        User user = (User) context.getAttribute("loggedinUser");
        String stringId = request.getParameter("productId");
		String cart = request.getParameter("addtocart");
		String stringAmount = request.getParameter("amount");
		String viewitem = request.getParameter("view");
		
		String clearCart = request.getParameter("clear");
		String remove1 = request.getParameter("remove1");
		String removeAll = request.getParameter("removeall");
		String add1 = request.getParameter("add1");
		Database connect = new Database();
		
		long productId = -1;
		
		
		try {
		 productId = Long.parseLong(stringId);
		
		}catch(NumberFormatException e) {
			
			for(Product product :user.getAllProducts()) {
				
				long id = product.getProductId();
			
			connect.removeProductForUser(user.getUserId(),id);
			
			}
			user.getAllProducts().clear();
			context.setAttribute("loggedinUser", user);
			 request.getRequestDispatcher("Cart.jsp").forward(request, response);
			
		}
		
		Product productForUser = null;
		
		try {
			for(Product product : connect.getSavedProductsForUser(user.getUserId())) {
				if(product.getProductId() == productId) {
					productForUser = product;
				}
			}
			
		}catch(IndexOutOfBoundsException e) {
			
		}
		
		
		
		try {
			if(remove1.equals("remove1")) {
				int regAmount = productForUser.getAmount();
				
				int newAmount = regAmount - 1;
				
				if(regAmount == 1) {
					
					for(int i = 0; i < user.getAllProducts().size() ;i++) {
						if(user.getAllProducts().get(i).getProductId() == productForUser.getProductId()) {
							Product productToRemove = user.getAllProducts().get(i);
							user.getAllProducts().remove(i);
							connect.removeProductForUser(user.getUserId(),productToRemove.getProductId());
						}
					}
				
					
					
				}
				else {
					Iterator<Product> iterator = user.getAllProducts().iterator();
					while (iterator.hasNext()) {
					    Product product = iterator.next();
					    if (product.getProductId() == productForUser.getProductId()) {
					        iterator.remove(); // Safely remove the product
					        productForUser.setAmount(newAmount);
					        user.getAllProducts().add(productForUser); // Add updated product
					        break; // Exit the loop once the product is updated
					    }
					}

					connect.updateProductForUser(user.getUserId(),productForUser.getProductId(),newAmount);
				}
				context.setAttribute("loggedinUser", user);
				 request.getRequestDispatcher("Cart.jsp").forward(request, response);
			}
		}catch(NullPointerException e) {
			
		}
		
		try {
			if(add1.equals("add1")) {
				System.out.println(" add1 was selected ");
				int regAmount = productForUser.getAmount();
				
				int newAmount = regAmount + 1;
				
				for(int i = 0; i < user.getAllProducts().size() ;i++) {
					if(user.getAllProducts().get(i).getProductId() == productForUser.getProductId()) {
						user.getAllProducts().remove(i);
					}
				}
				
				user.getAllProducts().remove(productForUser);
				productForUser.setAmount(newAmount);
				user.getAllProducts().add(productForUser);
				
				connect.updateProductForUser(user.getUserId(),productForUser.getProductId(),newAmount);
				context.setAttribute("loggedinUser", user);
				 request.getRequestDispatcher("Cart.jsp").forward(request, response);
			}
			
		}catch(NullPointerException e) {
			
		}
		try {
			
			if(removeAll.equals("removeall")) {
				System.out.println(" removeAll was selected ");
				
				for(int i = 0; i < user.getAllProducts().size() ;i++) {
					if(user.getAllProducts().get(i).getProductId() == productForUser.getProductId()) {
						user.getAllProducts().remove(i);
					}
				}
				
				connect.removeProductForUser(user.getUserId(),productForUser.getProductId());
				context.setAttribute("loggedinUser", user);
				 request.getRequestDispatcher("Cart.jsp").forward(request, response);
			}
			
		}catch(NullPointerException e) {
			
		}
	}

}
