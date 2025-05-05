package box;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class AnimalServlet
 */
public class AnimalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnimalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = getServletContext();
		Animal animal = (Animal)  context.getAttribute("animal");
		User user = (User) context.getAttribute("loggedinUser");
		String button = request.getParameter("action");		
		
		
		Database connect = new Database();
		
		if(user == null) {
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
		
		if(button.equals("adopt")) {
			
		
		
		animal.setOwner(user);
		user.getAdoptionPets().add(animal);
		connect.insertAnimalForUser(animal.getAnimalId(),user.getUserId());
		}else {
			animal.setOwner(null);
			
			for(int i = 0; i < user.getAdoptionPets().size(); i++) {
				Animal remove = user.getAdoptionPets().get(i);
				if(remove.getAnimalId() == animal.getAnimalId()) {
					user.getAdoptionPets().remove(i);
					if(connect.cancelAdoption(user.getUserId(), remove.getAnimalId())) {
						System.out.println(" Adoption Canacelation was a success ");
					}
				}
			}
			
		}
		
		//connect.updateAnimal(animal);
		
		
		context.setAttribute("loggedinUser", user);
		context.setAttribute("animal", animal);
		request.getRequestDispatcher("AnimalInfo.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = getServletContext();
		String animalId = request.getParameter("animalId");
		
		long id = Long.parseLong(animalId);
		
		Database connect = new Database();
		
		ArrayList<Animal> animals = (ArrayList) connect.getAllAnimals();
		
		Animal animal = null;
		
		for(Animal animal1 : animals) {
			if(id == animal1.getAnimalId()) {
				animal = animal1;
				context.setAttribute("animal", animal);
				request.getRequestDispatcher("AnimalInfo.jsp").forward(request, response);
			}
		}
		
		
		
	}

}
