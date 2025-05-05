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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Date;

public class Database {

    // Database credentials
	private static final String DB_URL = "jdbc:mysql://avnadmin:AVNS_ulJE6yjjhpfvRhKOlIo@mysql-311964e8-brandonmarquez505-6c36.h.aivencloud.com:20722/defaultdb?ssl-mode=REQUIRED";
	private static final String DB_USER = "avnadmin";
	private static final String DB_PASSWORD = "AVNS_ulJE6yjjhpfvRhKOlIo";

	public Database() {
		try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
	}
	

    public static void insertUser(User user) {
    	
    	 try {
		        Class.forName("com.mysql.cj.jdbc.Driver");
		    } catch (ClassNotFoundException e) {
		        e.printStackTrace();
		    }
    	
        String query = "INSERT INTO \"users\" (first_name, last_name, email, password, profile_pic) VALUES (?, ?, ?, ?, ?)";
        
        String host = "mysql-311964e8-brandonmarquez505-6c36.h.aivencloud.com";
        String port = "20722";
        String databaseName = "defaultdb";
        String userName = "avnadmin";
        String password = "AVNS_ulJE6yjjhpfvRhKOlIo";

        try (Connection connection = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set the values for the PreparedStatement
            stmt.setString(1, user.getFirstname());
            stmt.setString(2, user.getLastname());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());
            stmt.setBytes(5, user.getProfilePic()); // Convert profile_pic to byte array if not null
        

            // Execute the insert query
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("User inserted successfully!");
            } else {
                System.out.println("Failed to insert user.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a User from the database
    public static void deleteUser(long userId) {
        String query = "DELETE FROM \"users\" WHERE id_number = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set the userId for the PreparedStatement
            stmt.setLong(1, userId);

            // Execute the delete query
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("User deleted successfully!");
            } else {
                System.out.println("No user found with the given ID.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static boolean updateUser(User user) {
        String query = "UPDATE \"users\" SET first_name = ?, last_name = ?, email = ?, password = ?, profile_pic = ? WHERE id_number = ?";
        
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {
            
            // Set the parameters for the query
            stmt.setString(1, user.getFirstname());
            stmt.setString(2, user.getLastname());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPassword());

            // If the profile picture is null, set the parameter to null
            if (user.getProfilePic() != null) {
                stmt.setBytes(5, user.getProfilePic()); // Assuming profilePic is stored as a byte array
            } else {
                stmt.setNull(5, Types.BINARY);
            }

            stmt.setLong(6, user.getUserId());  // Assuming user.getIdNumber() returns the user ID

            // Execute the update query
            int rowsAffected = stmt.executeUpdate();

            // If rowsAffected is greater than 0, the update was successful
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Return false if an error occurred
        }
    }
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        
        
        try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
        
        String query = "SELECT id_number, first_name, last_name, email, password, profile_pic FROM \"users\"";
        
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            // Iterate through the result set and populate the list of users
            while (rs.next()) {
            	
            	String firstName = rs.getString("first_name");
            	String lastName = rs.getString("last_name");
            	String email = rs.getString("email");
            	long id = rs.getLong("id_number");
            	String password = rs.getString("password");
            	byte[] proFilePic = rs.getBytes("profile_pic");
                User user = new User(firstName,lastName,email,password);
                
                user.setPrpfilePic(proFilePic);
                user.setUserId(id);
                try {
                    // Get the user's saved products list
                    List<Product> userProducts = getSavedProductsForUser(id);

                    for (Product product : userProducts) {
                        // Check if the product is already in the user's product list (using product_id)
                        boolean productExists = false;
                        for (Product existingProduct : user.getAllProducts()) {
                            if (existingProduct.getProductId() == product.getProductId()) {
                                productExists = true;
                                break;
                            }
                        }

                        // If the product doesn't exist, add it to the list
                        if (!productExists) {
                            user.getAllProducts().add(product);
                        }
                    }
                } catch (IndexOutOfBoundsException e) {
                    // Handle any IndexOutOfBoundsException if necessary
                    e.printStackTrace();
                }
                
                try {
                	List<Animal> animals = getAllAnimalsForUser(id);
                	if(!animals.isEmpty()) {
                	user.getAdoptionPets().addAll(animals);
                	}	
                	for(Animal animal : animals) {
                		animal.setOwner(user);
                		System.out.println(" user has animal ");
                	}
                }catch(NullPointerException e ) {
                	
                }
               
                
                try {
                	List<Receipt> receipts = getReceiptsByUserId(id);
                	for(Receipt reciept : receipts) {
                		user.getAllReceipts().add(reciept);
                		System.out.println(reciept.getProducts().get(0).getProductId());
                	}
                	
                }catch(IndexOutOfBoundsException e) {
                	
                }
                
                try {
                    // Get the user's saved products list
                    List<Card> userPayments = getPaymentMethodsForUser(user.getUserId());
				

                    for (Card payment : userPayments) {
                            user.getAllPayments().add(payment);
                        
                    }
                } catch (IndexOutOfBoundsException e) {
                    // Handle any IndexOutOfBoundsException if necessary
                    e.printStackTrace();
                }

               
                users.add(user);  // Add the user to the list
            }

        } catch (SQLException e) {
            e.printStackTrace();  // Handle any errors
        }

        return users;
    }
    
    public static User getUserById(long userId) {
        User user = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String query = "SELECT id_number, first_name, last_name, email, password, profile_pic FROM users WHERE id_number = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set the user ID parameter
            stmt.setLong(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("email");
                    long id = rs.getLong("id_number");
                    String password = rs.getString("password");
                    byte[] profilePic = rs.getBytes("profile_pic");

                    user = new User(firstName, lastName, email, password);
                    user.setPrpfilePic(profilePic);
                    user.setUserId(id);

                    try {
                        // Get the user's saved products list
                        List<Product> userProducts = getSavedProductsForUser(id);

                        for (Product product : userProducts) {
                            boolean productExists = false;
                            for (Product existingProduct : user.getAllProducts()) {
                                if (existingProduct.getProductId() == product.getProductId()) {
                                    productExists = true;
                                    break;
                                }
                            }

                            if (!productExists) {
                                user.getAllProducts().add(product);
                            }
                        }
                    } catch (IndexOutOfBoundsException e) {
                        e.printStackTrace();
                    }

                

                    try {
                        List<Receipt> receipts = getReceiptsByUserId(id);
                        for (Receipt receipt : receipts) {
                            user.getAllReceipts().add(receipt);
                        }
                    } catch (IndexOutOfBoundsException e) {
                        e.printStackTrace();
                    }

                    try {
                        List<Card> userPayments = getPaymentMethodsForUser(user.getUserId());
                        for (Card payment : userPayments) {
                            user.getAllPayments().add(payment);
                        }
                    } catch (IndexOutOfBoundsException e) {
                        e.printStackTrace();
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }


 // Insert product and its associated image(s)
    public static void insertProduct(Product product) {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL query to insert the product
        String productQuery = "INSERT INTO products (name, description, amount, price) VALUES (?, ?, ?, ?)";
        
        // SQL query to insert the product image
        String imageQuery = "INSERT INTO product_images (product_id, image) VALUES (?, ?)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement productStmt = connection.prepareStatement(productQuery, Statement.RETURN_GENERATED_KEYS)) {

            // Insert the product data first
            productStmt.setString(1, product.getName());
            productStmt.setString(2, product.getDescription());
            productStmt.setInt(3, product.getAmount());
            productStmt.setDouble(4, product.getPrice());
            
            System.out.println(product.getImages().get(0).toString());

            // Execute the insert query for the product
            int productRowsAffected = productStmt.executeUpdate();
            
            // Check if the product was inserted successfully
            if (productRowsAffected > 0) {
                // Retrieve the generated product ID
                try (ResultSet rs = productStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        long productId = rs.getLong(1);
                        
                        // Now insert the image(s) associated with the product
                        if (product.getImages() != null && !product.getImages().isEmpty()) {
                            try (PreparedStatement imageStmt = connection.prepareStatement(imageQuery)) {
                                // Insert the first image associated with the product
                                imageStmt.setLong(1, productId);
                                imageStmt.setBytes(2, product.getImages().get(0)); // Assuming first image in the list
                                
                                // Execute the insert query for the product image
                                int imageRowsAffected = imageStmt.executeUpdate();
                                
                                if (imageRowsAffected > 0) {
                                    System.out.println("Product and its image inserted successfully!");
                                } else {
                                    System.out.println("Failed to insert product image.");
                                }
                            }
                        }
                    }
                }
            } else {
                System.out.println("Failed to insert product.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void insertAnimal(Animal animal) {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return;
        }

        // SQL query to insert the animal
        String animalQuery = "INSERT INTO animals (name, description, breed, age, datefound, owner_id) VALUES (?, ?, ?, ?, ?, ?)";

        // SQL query to insert animal images
        String imageQuery = "INSERT INTO animal_images (animal_id, image) VALUES (?, ?)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Start a transaction
            connection.setAutoCommit(false);

            try (PreparedStatement animalStmt = connection.prepareStatement(animalQuery, Statement.RETURN_GENERATED_KEYS)) {
                // Insert the animal data
                animalStmt.setString(1, animal.getName());
                animalStmt.setString(2, animal.getDescription());
                animalStmt.setString(3, animal.getBreed());
                animalStmt.setInt(4, animal.getAge());
                animalStmt.setDate(5, java.sql.Date.valueOf(animal.getDateFound()));

                if (animal.getOwner() != null) {
                    animalStmt.setLong(6, animal.getOwner().getUserId());
                } else {
                    animalStmt.setNull(6, java.sql.Types.BIGINT);
                }

                int rowsAffected = animalStmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Retrieve the generated animal ID
                    try (ResultSet rs = animalStmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            long animalId = rs.getLong(1);

                            // Insert images associated with the animal
                            if (animal.getImages() != null && !animal.getImages().isEmpty()) {
                                try (PreparedStatement imageStmt = connection.prepareStatement(imageQuery)) {
                                    for (byte[] image : animal.getImages()) {
                                        imageStmt.setLong(1, animalId);
                                        imageStmt.setBytes(2, image);
                                        imageStmt.addBatch();
                                    }
                                    imageStmt.executeBatch();
                                }
                            }
                        }
                    }
                    // Commit the transaction
                    connection.commit();
                    System.out.println("Animal and its images inserted successfully!");
                } else {
                    System.out.println("Failed to insert animal.");
                }
            } catch (SQLException e) {
                // Rollback the transaction if any error occurs
                connection.rollback();
                System.out.println("Transaction rolled back due to an error.");
                e.printStackTrace();
            } finally {
                // Reset auto-commit to true
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static List<Animal> getAllAnimalsForUser(Long userId) {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL queries
        String animalQuery = "SELECT * FROM animals a " +
                             "JOIN adoption_pets ap ON a.animal_id = ap.animal_id " +
                             "WHERE ap.user_id = ?";
        String imageQuery = "SELECT animal_id, image FROM animal_images";

        List<Animal> animals = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement animalStmt = connection.prepareStatement(animalQuery);
             PreparedStatement imageStmt = connection.prepareStatement(imageQuery)) {

            // Set the user ID parameter in the query
            animalStmt.setLong(1, userId);

            // Fetch animals associated with the user
            ResultSet animalRs = animalStmt.executeQuery();
            while (animalRs.next()) {
                Long animalId = animalRs.getLong("animal_id");
                String name = animalRs.getString("name");
                String breed = animalRs.getString("breed");
                String description = animalRs.getString("description");
                int age = animalRs.getInt("age");
                LocalDate dateFound = animalRs.getDate("datefound").toLocalDate();

                Animal animal = new Animal(name, breed, description, age, dateFound);
                animal.setAnimalId(animalId);

                
                Long ownerId = animalRs.getLong("owner_id");
                if(ownerId != null || ownerId == 0) {
                	User owner = getUserById(ownerId);
                	owner.getAdoptionPets().add(animal);
                	animal.setOwner(owner);
                }

                animals.add(animal);
            }

            // Fetch images for all animals associated with the user
            ResultSet imageRs = imageStmt.executeQuery();
            while (imageRs.next()) {
                Long animalId = imageRs.getLong("animal_id");
                byte[] imageData = imageRs.getBytes("image");

                // Find the matching animal in the list
                for (Animal animal : animals) {
                    if (animal.getAnimalId() == animalId && imageData != null) {
                        animal.getImages().add(imageData);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return animals;
    }



    public static List<Animal> getAllAnimals() {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL query to retrieve all animals
        String animalQuery = "SELECT * FROM animals";

        // SQL query to retrieve images for all animals
        String imageQuery = "SELECT animal_id, image FROM animal_images";

        List<Animal> animals = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement animalStmt = connection.prepareStatement(animalQuery);
             PreparedStatement imageStmt = connection.prepareStatement(imageQuery)) {

            // Fetch all animals
            ResultSet animalRs = animalStmt.executeQuery();
            while (animalRs.next()) {
                Long animalId = animalRs.getLong("animal_id");
                String name = animalRs.getString("name");
                String breed = animalRs.getString("breed");
                String description = animalRs.getString("description");
                int age = animalRs.getInt("age");
                LocalDate dateFound = animalRs.getDate("datefound").toLocalDate();

                Animal animal = new Animal(name, breed, description, age, dateFound);
                animal.setAnimalId(animalId);

                
                try {
                Long ownerId = animalRs.getLong("owner_id");
                if(ownerId != null || ownerId != 0) {
                	
                	User owner = getUserById(ownerId);
                	owner.getAdoptionPets().add(animal);
                	animal.setOwner(owner);
                	System.out.println(" owner was found ID: " + owner.getUserId());
                }
                }catch(NullPointerException e) {
                	
                }

                animals.add(animal);
            }

            // Fetch all images and assign to their respective animals
            ResultSet imageRs = imageStmt.executeQuery();
            while (imageRs.next()) {
                Long animalId = imageRs.getLong("animal_id");
                byte[] imageData = imageRs.getBytes("image");

                // Find the matching animal in the list
                for (Animal animal : animals) {
                    if (animal.getAnimalId() == animalId && imageData != null) {
                        animal.getImages().add(imageData);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return animals;
    }
    
    public static boolean removeAnimal(long animalId) {
        // SQL queries for deleting an animal and its images
        String deleteImagesQuery = "DELETE FROM animal_images WHERE animal_id = ?";
        String deleteAnimalQuery = "DELETE FROM animals WHERE animal_id = ?";

        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false; // Fail the operation if the driver is not loaded
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement deleteImagesStmt = connection.prepareStatement(deleteImagesQuery);
             PreparedStatement deleteAnimalStmt = connection.prepareStatement(deleteAnimalQuery)) {

            // Step 1: Delete all images associated with the animal
            deleteImagesStmt.setLong(1, animalId);
            int imagesDeleted = deleteImagesStmt.executeUpdate();

            // Step 2: Delete the animal record
            deleteAnimalStmt.setLong(1, animalId);
            int animalDeleted = deleteAnimalStmt.executeUpdate();

            // Verify if the deletion was successful
            return animalDeleted > 0; // Returns true only if the animal record is deleted

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // Return false in case of an error
    }
    
    public void insertAnimalForUser(long animalId, long userId) {
        // SQL query to update the animal's owner in the main animal table
        String updateAnimalSQL = "UPDATE animals SET owner_id = ? WHERE animal_id = ?";

        // Optionally, maintain a record in an adoption_pets table for tracking
        String insertAdoptionSQL = "INSERT INTO adoption_pets (user_id, animal_id) VALUES (?, ?)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement updateAnimalStmt = connection.prepareStatement(updateAnimalSQL);
             PreparedStatement insertAdoptionStmt = connection.prepareStatement(insertAdoptionSQL)) {

            // Update the owner_id in the animals table
            updateAnimalStmt.setLong(1, userId);
            updateAnimalStmt.setLong(2, animalId);
            int animalUpdateCount = updateAnimalStmt.executeUpdate();

            // Insert a record in the adoption_pets table
            insertAdoptionStmt.setLong(1, userId);
            insertAdoptionStmt.setLong(2, animalId);
            int adoptionInsertCount = insertAdoptionStmt.executeUpdate();

            // Optionally, print success messages
            if (animalUpdateCount > 0) {
                System.out.println("Animal ID " + animalId + " successfully updated with User ID " + userId);
            }
            if (adoptionInsertCount > 0) {
                System.out.println("Adoption record successfully created for Animal ID " + animalId + " and User ID " + userId);
            }

        } catch (SQLException e) {
            // Handle SQL exceptions
            System.err.println("Error linking animal to user: " + e.getMessage());
        }
    }

    public boolean cancelAdoption(long userId, long animalId) {
        String deleteQuery = "DELETE FROM adoption_pets WHERE user_id = ? AND animal_id = ?";
        String updateQuery = "UPDATE animals SET owner_id = NULL WHERE animal_id = ?";
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            conn.setAutoCommit(false); // Begin transaction
            
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
                 PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                
                // Step 1: Remove the link between user and animal
                deleteStmt.setLong(1, userId);
                deleteStmt.setLong(2, animalId);
                int rowsDeleted = deleteStmt.executeUpdate();
                
                if (rowsDeleted > 0) {
                    // Step 2: Set owner_id to NULL in the animals table
                    updateStmt.setLong(1, animalId);
                    int rowsUpdated = updateStmt.executeUpdate();
                    
                    if (rowsUpdated > 0) {
                        conn.commit(); // Commit transaction
                        return true;
                    } else {
                        conn.rollback(); // Rollback transaction if update fails
                    }
                } else {
                    conn.rollback(); // Rollback transaction if delete fails
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false in case of an error or failure
    }

    
    public static boolean updateAnimal(Animal animal) {
        // SQL queries for updating animal details and images
        String updateAnimalQuery = "UPDATE animals SET name = ?, breed = ?, description = ?, age = ?, datefound = ?, owner_id = ? WHERE animal_id = ?";
        String deleteImagesQuery = "DELETE FROM animal_images WHERE animal_id = ?";
        String insertImageQuery = "INSERT INTO animal_images (animal_id, image) VALUES (?, ?)";

        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false; // Fail the operation if the driver is not loaded
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement updateAnimalStmt = connection.prepareStatement(updateAnimalQuery);
             PreparedStatement deleteImagesStmt = connection.prepareStatement(deleteImagesQuery);
             PreparedStatement insertImageStmt = connection.prepareStatement(insertImageQuery)) {

            // Step 1: Update animal details
            updateAnimalStmt.setString(1, animal.getName());
            updateAnimalStmt.setString(2, animal.getBreed());
            updateAnimalStmt.setString(3, animal.getDescription());
            updateAnimalStmt.setInt(4, animal.getAge());
            updateAnimalStmt.setDate(5, java.sql.Date.valueOf(animal.getDateFound()));
            updateAnimalStmt.setLong(6, animal.getAnimalId());
            if(animal.getOwner() != null) {          	
            	updateAnimalStmt.setLong(7, animal.getOwner().getUserId());
            } else {
                updateAnimalStmt.setNull(7, java.sql.Types.BIGINT); // Set NULL for owner_id
            }
            
            int rowsUpdated = updateAnimalStmt.executeUpdate();

            // Step 2: Update animal images if provided
            if (animal.getImages() != null && !animal.getImages().isEmpty()) {
                // Delete existing images
                deleteImagesStmt.setLong(1, animal.getAnimalId());
                deleteImagesStmt.executeUpdate();

                // Insert new images
                for (byte[] image : animal.getImages()) {
                    insertImageStmt.setLong(1, animal.getAnimalId());
                    insertImageStmt.setBytes(2, image);
                    insertImageStmt.executeUpdate();
                }
            }

            return rowsUpdated > 0; // Return true if the animal update was successful

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // Return false in case of an error
    }

    public static void insertProductForUser(long userId, long productId,int amount) {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL query to insert the relationship into users_products
        String userProductQuery = "INSERT INTO users_products (user_id, product_id, amount) VALUES (?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement userProductStmt = connection.prepareStatement(userProductQuery)) {

            // Set the parameters for the query
            userProductStmt.setLong(1, userId);
            userProductStmt.setLong(2, productId);
            userProductStmt.setInt(3, amount);

            // Execute the insert query
            int rowsAffected = userProductStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Product successfully linked to the user!");
            } else {
                System.out.println("Failed to link the product to the user.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void updateProductForUser(long userId, long productId, int newAmount) {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL query to update the product amount in users_products
        String updateProductQuery = "UPDATE \"users_products\" SET amount = ? WHERE user_id = ? AND product_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement updateProductStmt = connection.prepareStatement(updateProductQuery)) {

            // Set the parameters for the query
            updateProductStmt.setInt(1, newAmount);
            updateProductStmt.setLong(2, userId);
            updateProductStmt.setLong(3, productId);

            // Execute the update query
            int rowsAffected = updateProductStmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Product amount successfully updated for the user!");
            } else {
                System.out.println("Failed to update the product amount for the user.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void removeProductForUser(long userId, long productId) {
        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL query to delete a record from users_products
        String query = "DELETE FROM users_products WHERE user_id = ? AND product_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set the parameters for the query
            stmt.setLong(1, userId);
            stmt.setLong(2, productId);

            // Execute the delete statement
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Product successfully removed for user.");
            } else {
                System.out.println("No product found for the given user and product ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    
    public static List<Product> getSavedProductsForUser(long userId) {
        List<Product> products = new ArrayList<>();

        try {
            // Ensure the MySQL JDBC driver is loaded
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        // SQL query to retrieve products and images linked to the user
        String query = """
            SELECT p.product_id, p.name, p.description, up.amount, p.price, pi.image
            FROM products p
            INNER JOIN users_products up ON p.product_id = up.product_id
            LEFT JOIN product_images pi ON p.product_id = pi.product_id
            WHERE up.user_id = ?
        """;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set the parameter for the query
            stmt.setLong(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                // Iterate through the results and populate the product list
                while (rs.next()) {
                    Product product = new Product(rs.getString("name"), rs.getString("description"), rs.getInt("amount"), rs.getDouble("price"));
                    product.setProductId(rs.getLong("product_id"));

                    // Retrieve the image if available
                    byte[] imageBytes = rs.getBytes("image");
                    if (imageBytes != null) {
                        product.getImages().add(imageBytes);
                    }

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
    
    public static void deleteProduct(long productId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String deleteQuery = "DELETE FROM products WHERE product_id = ?";
        
        String deleteImagesQuery = "DELETE FROM product_images WHERE product_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement deleteStmt = connection.prepareStatement(deleteQuery);
             PreparedStatement deleteImagesStmt = connection.prepareStatement(deleteImagesQuery)) {
             
            deleteStmt.setLong(1, productId);
            deleteImagesStmt.setLong(1, productId);
            
            deleteImagesStmt.executeUpdate();
            int rowsAffected = deleteStmt.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Product deleted successfully!");
            } else {
                System.out.println("No product found with the given ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public static List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String productQuery = "SELECT product_id, name, description, amount, price FROM products";
        String imageQuery = "SELECT image FROM product_images WHERE product_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            // Retrieve all products
            try (PreparedStatement stmt = connection.prepareStatement(productQuery);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    long productId = rs.getLong("product_id");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    int amount = rs.getInt("amount");
                    double price = rs.getDouble("price");
                   

                    Product product = new Product(name, description, amount, price);
                    product.setProductId(productId);

                    // Retrieve associated images for this product
                    try (PreparedStatement imageStmt = connection.prepareStatement(imageQuery)) {
                        imageStmt.setLong(1, productId);
                        try (ResultSet imageRs = imageStmt.executeQuery()) {
                            List<byte[]> images = new ArrayList<>();
                            while (imageRs.next()) {
                                byte[] imageData = imageRs.getBytes("image");
                                images.add(imageData);
                            }
                            product.getImages().addAll(images);  // Set the images list in the product
                        }
                    }

                    products.add(product);
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    // Method to get products by user ID (assuming userId is linked to products)
    public static List<Product> getProductsByUserId(long userId) {
        List<Product> products = new ArrayList<>();
        String productQuery = "SELECT product_id, name, description, amount, price FROM products WHERE owner_id = ?";
        String imageQuery = "SELECT image_data FROM product_images WHERE product_id = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            // Retrieve products by user ID
            try (PreparedStatement stmt = connection.prepareStatement(productQuery)) {
                stmt.setLong(1, userId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        long productId = rs.getLong("product_id");
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        int amount = rs.getInt("amount");
                        double price = rs.getDouble("price");

                        Product product = new Product(name, description, amount, price);
                        product.setProductId(productId);

                        // Retrieve associated images for this product
                        try (PreparedStatement imageStmt = connection.prepareStatement(imageQuery)) {
                            imageStmt.setLong(1, productId);
                            try (ResultSet imageRs = imageStmt.executeQuery()) {
                                List<byte[]> images = new ArrayList<>();
                                while (imageRs.next()) {
                                    byte[] imageData = imageRs.getBytes("image_data");
                                    images.add(imageData);
                                    System.out.println("image found");
                                }
                                product.getImages().addAll(images);  // Set the images list in the product
                            }
                        }

                        products.add(product);
                        System.out.println("user has products in the cart");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public static boolean updateProduct(Product product) {
        String updateProductQuery = "UPDATE products SET name = ?, description = ?, amount = ?, price = ? WHERE product_id = ?";
        String deleteImagesQuery = "DELETE FROM product_images WHERE product_id = ?";
        String insertImageQuery = "INSERT INTO product_images (product_id, image) VALUES (?, ?)";


        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Start transaction for atomicity
            connection.setAutoCommit(false);

            try {
                // Update the product details
                try (PreparedStatement stmt = connection.prepareStatement(updateProductQuery)) {
                    stmt.setString(1, product.getName());
                    stmt.setString(2, product.getDescription());
                    stmt.setInt(3, product.getAmount());
                    stmt.setDouble(4, product.getPrice());
                    stmt.setLong(5, product.getProductId());

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected == 0) {
                        connection.rollback();
                        System.out.println("Product update failed. Rolling back.");
                        return false;
                    }
                }

                // Remove existing images
                try (PreparedStatement deleteStmt = connection.prepareStatement(deleteImagesQuery)) {
                    deleteStmt.setLong(1, product.getProductId());
                    deleteStmt.executeUpdate();
                }

                // Insert new images
                if (product.getImages() != null && !product.getImages().isEmpty()) {
                    try (PreparedStatement imageStmt = connection.prepareStatement(insertImageQuery)) {
                        for (byte[] image : product.getImages()) {
                            imageStmt.setLong(1, product.getProductId());
                            imageStmt.setBytes(2, image);
                            imageStmt.addBatch();
                        }
                        imageStmt.executeBatch();
                    }
                }

                // Commit transaction if all operations succeed
                connection.commit();
                System.out.println("Product updated successfully!");
                return true;

            } catch (SQLException e) {
                connection.rollback();
                System.out.println("Error occurred, rolling back transaction.");
                e.printStackTrace();
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    
    public void removeProduct(long productId) {
        // SQL queries to delete images and product
        String deleteImagesSQL = "DELETE FROM product_images WHERE product_id = ?";
        String deleteProductSQL = "DELETE FROM products WHERE product_id = ?";

        // Initialize connection and PreparedStatement
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            // Disable auto-commit to handle transaction manually
            conn.setAutoCommit(false);

            // Step 1: Delete associated images
            try (PreparedStatement pstmtImages = conn.prepareStatement(deleteImagesSQL)) {
                pstmtImages.setLong(1, productId);
                pstmtImages.executeUpdate();
            }

            // Step 2: Delete the product
            try (PreparedStatement pstmtProduct = conn.prepareStatement(deleteProductSQL)) {
                pstmtProduct.setLong(1, productId);
                int rowsAffected = pstmtProduct.executeUpdate();

                if (rowsAffected > 0) {
                    // Commit the transaction if both the image deletion and product deletion succeed
                    conn.commit();
                } else {
                    // If no rows were affected, rollback the transaction
                    conn.rollback();
                    System.out.println("product deletion failure"); // Product deletion failed
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            
          
    }
    }
    
    public static void insertPaymentMethod(Card card, long userId) throws SQLException {
        String query = "INSERT INTO payment_methods (cvv, expiry, card_type, card_number, card_holder_name, user_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            // Set the parameters
            pstmt.setString(1, card.getCvv());
            pstmt.setDate(2, Date.valueOf(card.getExpiry()));
            pstmt.setString(3, card.getCardType());
            pstmt.setString(4, card.getCardNumber());
            pstmt.setString(5, card.getCardHolderName());
            pstmt.setLong(6, userId);

            // Execute the insert statement
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        card.setPaymentId(generatedKeys.getInt(1));
                        System.out.println("Payment method added successfully with card ID " + card.getPaymentId() + ".");
                    }
                }
            } else {
                System.out.println("Failed to add payment method.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error inserting payment method: " + e.getMessage());
        }
    }

    public static List<Card> getPaymentMethodsForUser(long userId) throws SQLException {
        String query = "SELECT card_id, cvv, expiry, card_type, card_number, card_holder_name, user_id " +
                       "FROM payment_methods WHERE user_id = ?";
        List<Card> paymentMethods = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                pstmt.setLong(1, userId);

                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Card card = new Card(rs.getString("cvv"),rs.getDate("expiry").toLocalDate(),rs.getString("card_type"),rs.getString("card_number"),rs.getString("card_holder_name"));
                        card.setPaymentId(rs.getInt("card_id"));
                        paymentMethods.add(card);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-throw to indicate failure
        }

        return paymentMethods;
    }



    
    public static void removePaymentMethod(String cardNumber) throws SQLException {
        String query = "DELETE FROM payment_methods WHERE card_number = ?";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = connection.prepareStatement(query)) {

            // Set the card number parameter
            pstmt.setString(1, cardNumber);

            // Execute the delete statement
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Payment method with card number " + cardNumber + " has been removed successfully.");
            } else {
                System.out.println("No payment method found with card number " + cardNumber + ".");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error removing payment method: " + e.getMessage());
        }
    }
    
    public static void updatePaymentMethodsForUser(long userId, List<Card> newCards) throws SQLException {
        String deleteQuery = "DELETE FROM payment_methods WHERE user_id = ?";
        String insertQuery = "INSERT INTO payment_methods (cvv, expiry, card_type, card_number, card_holder_name, user_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement deleteStmt = connection.prepareStatement(deleteQuery);
             PreparedStatement insertStmt = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {

            // Start transaction
            connection.setAutoCommit(false);

            // Remove all existing payment methods for the user
            deleteStmt.setLong(1, userId);
            deleteStmt.executeUpdate();

            // Re-add new payment methods
            for (Card card : newCards) {
                insertStmt.setString(1, card.getCvv());
                insertStmt.setDate(2, Date.valueOf(card.getExpiry())); 
                insertStmt.setString(3, card.getCardType());
                insertStmt.setString(4, card.getCardNumber());
                insertStmt.setString(5, card.getCardHolderName());
                insertStmt.setLong(6, userId);

                // Add to batch
                insertStmt.addBatch();
            }

            // Execute batch insert
            int[] rowsAffected = insertStmt.executeBatch();

            // Get generated keys for each new card
            try (ResultSet generatedKeys = insertStmt.getGeneratedKeys()) {
                for (Card card : newCards) {
                    if (generatedKeys.next()) {
                        card.setPaymentId(generatedKeys.getInt(1));
                    }
                }
            }

            // Commit transaction
            connection.commit();

            System.out.println("Payment methods updated successfully for user ID: " + userId);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error updating payment methods: " + e.getMessage());
        }
    }

    public void insertPaymentMethodForRecipt(Card card, long receiptId) throws SQLException {
        String query = "INSERT INTO receipt_payment_methods (cvv, expiry, card_type, card_number, card_holder_name, receipt_id) " +
                       "VALUES (?, ?, ?, ?, ?, ?)";
        
        
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, card.getCvv());
            pstmt.setDate(2, Date.valueOf(card.getExpiry())); // Converting LocalDate to SQL Date
            pstmt.setString(3, card.getCardType());
            pstmt.setString(4, card.getCardNumber());
            pstmt.setString(5, card.getCardHolderName());
            pstmt.setLong(6, receiptId);
            pstmt.executeUpdate();
        }
    
    } catch (SQLException e) {
        e.printStackTrace();
        
      
}
    }
    public static List<Card> getPaymentMethodsForReceipt(long receiptId) throws SQLException {
        String query = "SELECT cvv, expiry, card_type, card_number, card_holder_name, card_id " +
                       "FROM receipt_payment_methods WHERE reciept_id = ?";
        List<Card> cards = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setLong(1, receiptId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String cvv = rs.getString("cvv");
                    LocalDate expiry = rs.getDate("expiry").toLocalDate();
                    String cardType = rs.getString("card_type");
                    String cardNumber = rs.getString("card_number");
                    String cardHolderName = rs.getString("card_holder_name");
                    long card_id = rs.getLong("card_id");

                    // Create a Card object and add it to the list
                    Card card = new Card(cvv, expiry, cardType, cardNumber, cardHolderName);
                    card.setPaymentId(card_id);
                    cards.add(card);
                    
                }
            }
        }
        } catch (SQLException e) {
            e.printStackTrace();
            
          
    }

        return cards;
    }
    
    
    public static void insertReceipt(Receipt receipt, long userId) throws SQLException {
        String receiptQuery = "INSERT INTO receipts (receipt_date, total_amount, user_id) VALUES (?, ?, ?)";
        String productQuery = "INSERT INTO receipts_products (receipt_id, product_id, amount) VALUES (?, ?, ?)";
        String paymentQuery = "INSERT INTO receipt_payment_methods (cvv, expiry, card_type, card_number, card_holder_name, receipt_id) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Start a transaction
            connection.setAutoCommit(false);
            
            try (PreparedStatement receiptStmt = connection.prepareStatement(receiptQuery, Statement.RETURN_GENERATED_KEYS)) {
                // Insert receipt
                receiptStmt.setDate(1, Date.valueOf(receipt.getDateBought())); // Convert LocalDate to SQL Date
                receiptStmt.setDouble(2, receipt.getSubTotal());
                receiptStmt.setLong(3, userId); // Use the userId for the receipt
                receiptStmt.executeUpdate();

                // Get the generated receipt ID
                try (ResultSet generatedKeys = receiptStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        long receiptId = generatedKeys.getLong(1);
                        receipt.setReceiptId(receiptId); // Set the generated receiptId in the Receipt object

                        // Insert products associated with the receipt
                        try (PreparedStatement productStmt = connection.prepareStatement(productQuery)) {
                            for (Product product : receipt.getProducts()) {
                                productStmt.setLong(1, receiptId);
                                productStmt.setLong(2, product.getProductId());
                                productStmt.setInt(3, product.getAmount());
                                productStmt.addBatch();
                            }
                            productStmt.executeBatch();
                        }

                        // Insert payment method for the receipt
                        try (PreparedStatement paymentStmt = connection.prepareStatement(paymentQuery)) {
                            Card card = receipt.getPaymentMethod();
                            paymentStmt.setString(1, card.getCvv());
                            paymentStmt.setDate(2, Date.valueOf(card.getExpiry()));
                            paymentStmt.setString(3, card.getCardType());
                            paymentStmt.setString(4, card.getCardNumber());
                            paymentStmt.setString(5, card.getCardHolderName());
                            paymentStmt.setLong(6, receiptId);
                            paymentStmt.executeUpdate();
                        }
                        // Commit the transaction
                        connection.commit();
                    }
                }
            } catch (SQLException e) {
                connection.rollback(); // Rollback the transaction in case of error
                e.printStackTrace();
            } finally {
                connection.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static List<Receipt> getReceiptsByUserId(long userId) {
        List<Receipt> receipts = new ArrayList<>();
        
        String receiptQuery = "SELECT receipt_id, receipt_date, total_amount FROM receipts WHERE user_id = ?";
        String productQuery = """
            SELECT rp.product_id, p.name, p.description, rp.amount, p.price, pi.image
            FROM receipts_products rp
            INNER JOIN products p ON rp.product_id = p.product_id
            LEFT JOIN product_images pi ON p.product_id = pi.product_id
            WHERE rp.receipt_id = ?
        """;
        String paymentQuery = """
            SELECT cvv, expiry, card_type, card_number, card_holder_name
            FROM receipt_payment_methods
            WHERE receipt_id = ?
        """;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement receiptStmt = connection.prepareStatement(receiptQuery)) {
            
            // Set the user ID for the query
            receiptStmt.setLong(1, userId);

            try (ResultSet receiptRs = receiptStmt.executeQuery()) {
                while (receiptRs.next()) {
                    long receiptId = receiptRs.getLong("receipt_id");
                    LocalDate dateBought = receiptRs.getDate("receipt_date").toLocalDate();
                    double totalAmount = receiptRs.getDouble("total_amount");

                    // Create a new Receipt object
                    Receipt receipt = new Receipt(totalAmount, new ArrayList<>(), null);
                    receipt.setReceiptId(receiptId);
                    receipt.setDate(dateBought);

                    // Fetch products for the receipt
                    try (PreparedStatement productStmt = connection.prepareStatement(productQuery)) {
                        productStmt.setLong(1, receiptId);

                        Map<Long, Product> productMap = new HashMap<>();
                        try (ResultSet productRs = productStmt.executeQuery()) {
                            while (productRs.next()) {
                                long productId = productRs.getLong("product_id");

                                Product product = productMap.getOrDefault(productId, new Product(
                                    productRs.getString("name"),
                                    productRs.getString("description"),
                                    productRs.getInt("amount"),
                                    productRs.getDouble("price")
                                ));
                                product.setProductId(productId);

                                // Add image if available
                                byte[] imageBytes = productRs.getBytes("image");
                                if (imageBytes != null) {
                                    product.getImages().add(imageBytes);
                                }

                                productMap.put(productId, product);
                            }
                        }

                        receipt.getProducts().addAll(productMap.values());
                    }

                    // Fetch payment method for the receipt
                    try (PreparedStatement paymentStmt = connection.prepareStatement(paymentQuery)) {
                        paymentStmt.setLong(1, receiptId);

                        try (ResultSet paymentRs = paymentStmt.executeQuery()) {
                            if (paymentRs.next()) {
                                Card card = new Card(
                                    paymentRs.getString("cvv"),
                                    paymentRs.getDate("expiry").toLocalDate(),
                                    paymentRs.getString("card_type"),
                                    paymentRs.getString("card_number"),
                                    paymentRs.getString("card_holder_name")
                                );
                                receipt.setPaymentMethod(card);
                            }
                        }
                    }

                    // Add receipt to the list
                    receipts.add(receipt);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return receipts;
    }



}
