package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Login() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Email = request.getParameter("Email");
	    String Password = request.getParameter("Password");
	    
	    Database database = new Database();
	    boolean found = false;
	    
	    try {
	    	ArrayList<User> allusers = (ArrayList) database.getAllUsers();
	    	for(User user : allusers) {
	    		System.out.println(user.getPassword());
	    		if(user.getEmail().equalsIgnoreCase(Email) && user.getPassword().equals(Password)) {
	    			
	    			 ServletContext context = request.getServletContext();
	    			    found =true;
	    			    
	    			    context.setAttribute("loggedinUser", user);
	    			    
	    	
	    			    
	    			    
	    			    request.getRequestDispatcher("Profile.jsp").forward(request, response);
	    			
	    		}
	    	}
	    }catch(IndexOutOfBoundsException e) {
	    	System.out.println("error");
	    }
	    
	    if(!found) {
	    	System.out.print("user not was found");
	    request.getRequestDispatcher("Login.jsp").forward(request, response);
	    }else {
	    	System.out.print("user was found");
	    }
	}

}
