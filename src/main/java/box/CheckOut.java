package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Servlet implementation class CheckOut
 */
public class CheckOut extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOut() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO set up payment method
		ServletContext context = getServletContext();
		User user = (User) context.getAttribute("loggedinUser");
		String cvv = request.getParameter("cvv");
		String cardNumber = request.getParameter("cardNumber");
		String expiry = request.getParameter("expiry");
		String holderName = request.getParameter("holderName");
		String cardType = request.getParameter("cardType");
		
			if(cardType.equals("empty")) {
				request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
			}
			
			boolean containsNumber = false;
		
		try {
			long checkNumber = Long.parseLong(cardNumber);
			if(checkNumber > 0) {
				containsNumber = true;
			}
			
		}catch(NumberFormatException e) {
			request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
		}
			
		int year = Integer.parseInt(expiry.substring(0,4));
		int month = Integer.parseInt(expiry.substring(5,7));
		int day = Integer.parseInt(expiry.substring(8,10));
		
		LocalDate today = LocalDate.now();
		LocalDate expDate = LocalDate.of(year,month,day);
		
		
		if(cvv.length() > 2 && cvv.length() < 5 && cardNumber.length() == 16 && containsNumber && expDate.isAfter(today)) {
	      
	     // long convert = Long.parseLong(expiry);

		Card paymentMethod = new Card(cvv,expDate,cardType,cardNumber,holderName);
		user.getAllPayments().add(paymentMethod);
		context.setAttribute("loggedinUser", user);
		Database connect = new Database();
		try {
			 connect.insertPaymentMethod(paymentMethod, user.getUserId());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	//	connect.insertReceipt(receipt,user.getUserId(),paymentMethod.getPaymentId());

	        request.getRequestDispatcher("Profile.jsp").forward(request, response);
		}
		request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = getServletContext();
		User user = (User) context.getAttribute("loggedinUser");
		String checkOut = request.getParameter("checkOut");
		String totalString = request.getParameter("subTotal");
		String buyNow = request.getParameter("buyNow");
		String id = request.getParameter("productId");
		String productAmount = request.getParameter("amount");
		String clearAll = request.getParameter("clearAll");
		long productId = 0;
		int amount = 1;
		try {
			 productId = Long.parseLong(id);
			 amount = Integer.parseInt(productAmount);
			
		}catch(NumberFormatException e) {
			
		}
		
		double subTotal = Double.parseDouble(totalString);
		
		Database connect = new Database();
		
		Card paymentMethod = null;
		
		try {
			paymentMethod = user.getAllPayments().get(0); // desired payment should be set as index 0
			
		}catch(IndexOutOfBoundsException e) {
			
			request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
			
		}
		
		try {
			if(checkOut.equals("checkOut") && !user.getAllProducts().isEmpty()) {
				
				Receipt receipt = new Receipt(subTotal,user.getAllProducts(),paymentMethod);
				for(Product product : user.getAllProducts()) {
					long removeId = product.getProductId();
					connect.removeProductForUser(user.getUserId(), removeId);
					break;
				}
				user.getAllProducts().clear();
				user.getAllReceipts().add(receipt);
				context.setAttribute("receipt", receipt);
				context.setAttribute("loggedinUser", user);
				connect.insertReceipt(receipt,user.getUserId());
				System.out.println(" " + receipt.getName() + " " + receipt.getPaymentMethod().getCardNumber() + " " + receipt.getProducts().get(0).getPrice());
				request.getRequestDispatcher("Receipt.jsp").forward(request, response);
			}
			
		}catch(NullPointerException e) {
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			if(buyNow.equals("buyNow")) {
				int index = 0;
				ArrayList<Product> products = new ArrayList<>();
				for(Product product : connect.getAllProducts()) {
					if(product.getProductId() == productId) {
						product.setAmount(amount);
						products.add(product);
					}
					if(index < user.getAllProducts().size()) {
						if(user.getAllProducts().get(index).getProductId() == productId) {
							user.getAllProducts().remove(index);
							index ++;
						}
					}
				}
				
				
				
				Receipt receipt = new Receipt(subTotal,products,paymentMethod);
				user.getAllReceipts().add(receipt);
				context.setAttribute("receipt", receipt);
				context.setAttribute("loggedinUser", user);
				request.getRequestDispatcher("Receipt.jsp").forward(request, response);
			}
			
		}catch(NullPointerException e) {
			
		}
		
		request.getRequestDispatcher("Cart.jsp").forward(request, response);
	}

}
