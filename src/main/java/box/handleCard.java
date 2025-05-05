package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class removeCard
 */
public class handleCard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public handleCard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
ServletContext context =  getServletContext();
		
		User user = (User) context.getAttribute("loggedinUser");
		
		String cardNumber =  request.getParameter("cardNumber");
		String change = request.getParameter("action");
		
		long userId = user.getUserId();
		
		Database connect =  new Database();
		
		
		for (int i = 0; i < user.getAllPayments().size(); i++) {
		    Card currentCard = user.getAllPayments().get(i);

		    // Check if the current card matches the desired card number
		    if (currentCard.getCardNumber().equals(cardNumber)) {
		            // Move the desired card to the first position in the list
		            user.getAllPayments().remove(i);
		            user.getAllPayments().add(0, currentCard); 
		        
		        break;  // No need to continue once we've handled the card
		    }
		}
		
		
		
		try {
				connect.updatePaymentMethodsForUser(userId, user.getAllPayments());
			
		} catch (SQLException e) {
			System.out.println("removing card threw an error");
			e.printStackTrace();
		}
		context.setAttribute("loggedinUser", user);
		
		request.getRequestDispatcher("Profile.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context =  getServletContext();
		
		User user = (User) context.getAttribute("loggedinUser");
		
		String cardNumber =  request.getParameter("cardNumber");
		System.out.println(" " + cardNumber.replaceAll(".{4}(?!$)", "$0 ")  + " ");
		String change = request.getParameter("action");
		
		long userId = user.getUserId();
		
		Database connect =  new Database();
		
		boolean cardChanged = false;
		try {
			if(change.equals("change")) {
				cardChanged = true;
			}
			
		}catch(NullPointerException e) {
				
			
			
		}
		for(int i = 0; i < user.getAllPayments().size(); i++) {
			if(user.getAllPayments().get(i).getCardNumber().equals(cardNumber)) {
				Card temp = user.getAllPayments().get(i);
				user.getAllPayments().remove(i);
				
					System.out.println(" " + cardNumber + " ");
					user.getAllPayments().add(0, temp);
				}
				
			}
			
	
	

		try {
			connect.removePaymentMethod(cardNumber);
			
		} catch (SQLException e) {
			System.out.println("removing card threw an error");
			e.printStackTrace();
		}
		context.setAttribute("loggedinUser", user);
		
		request.getRequestDispatcher("Profile.jsp").forward(request, response);
		
	}

}
