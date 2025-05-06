<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> <%@ page import="java.util.List" %> <%@ page import="box.*"%> 
<%@ page import="java.util.Base64" %> <%@ page import="java.lang.StringBuilder" %><%@ page import="java.time.*" %>

<%
ServletContext context = request.getServletContext();

User user = (User) context.getAttribute("loggedinUser");

Accounts account = new Accounts();

String profilePic = "";

Animal Favanimal = null;
try{
 Favanimal = user.getFavoritePets().get(0);
}catch(IndexOutOfBoundsException e){
}catch(NullPointerException e){
}

StringBuilder build = new StringBuilder();

try{
//	System.out.println(user.getProfilePic().toString());
	profilePic = Base64.getEncoder().encodeToString(user.getProfilePic());
	//System.out.println(profilePic);
	
	
	
	for(int i =0; i < user.getPassword().length();i++){
		build.append("*");
	}
	
	
	
	//profilePic = "images/StaticPro1.jpeg";
	
}catch(NullPointerException e){
	
}

%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  
  <link href="css/Profile.css" rel="stylesheet" /> 
  <link href="css/gradient-btn.css" rel="stylesheet" />
  <link href="css/buttons.css" rel="stylesheet" />

  <link href="css/style.css" rel="stylesheet" />  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Pawfect Match - Profile</title>

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
</head>

<body>
  <div class="hero_area">
    <header class="header_section">
      <div class="container-fluid">
        <nav class="navbar navbar-expand-lg custom_nav-container">
          <a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" alt="">
          </a>

          <div class="" id="">
            <div class="custom_menu-btn">
              <button onclick="openNav()">
                <span class="s-1"></span>
                <span class="s-2"></span>
                <span class="s-3"></span>
              </button>
            </div>
            <div id="myNav" class="overlay">
              <div class="overlay-content">
                <a href="index.jsp"><button class="glass-btn">Home</button></a>
                <a href="about.jsp"><button class="glass-btn">About</button></a>
                <a href="Products.jsp"><button class="glass-btn">Fund Us</button></a>
                <a href="AllAnimals.jsp"><button class="glass-btn">Adopt An Animal</button></a>
              </div>
            </div>
          </div>
        </nav>
      </div>
    </header>
    
    
    
   <section class="profile-section">
  <div class="container">
    <div class="row">
      <div class="col-md-4 profile-picture">
      <div class="profile-image">
        <img 
          src="data:image/jpeg;base64,<%=profilePic %>" 
          alt="Profile Picture" 
          class="profile-image">
          </div>
        <h3><%= user.getFirstname() %>  <%= user.getLastname() %></h3>
        <ul class="profile-info">
          <li><i class="fas fa-envelope"></i>Email: <%=user.getEmail() %></li>
          <li><i class="fas fa-envelope"></i>Password: <%= build %></li>
          </ul>
      </div>
      <div class="col-md-8 profile-actions">
        <div class="card-deck">
         
       
		<h2>My Actions</h2>
		<div class="actions-container">
		    <% if (user.getEmail().equals("marquezjulian09@gmail.com")) { %>
		        <a href="AddProduct.jsp" class="button-29">Add a Product</a>
		        <a href="AddAnimal.jsp" class="button-29">Add Pet For Adoption</a>
		    <% } %>
		    <a href="AllAnimals.jsp" class="button-29">Adopt an Animal</a>
		    <a href="UserPayments.jsp" class="button-29">Your Payments</a>
		    <a href="PurchaseHistory.jsp" class="button-29">Your Purchases</a>
		    <a href="Products.jsp" class="button-29">Products</a>
		    <a href="EditProfile.jsp" class="button-29-edit">Edit Profile</a>
		
		    <form method="get" action="Accounts">
		        <button class="button-29-danger">Log Out</button>
		    </form>
		</div>

    </div>
  </div>
  </div>
</section>
    </div>
    

<form action="AnimalServlet" method="post">
<section class="animal-section">
<h3 class="text-center my-4">Adopted Pets</h3>
  <div class="container">

      <% 
        List<Animal> allAnimals = user.getAdoptionPets();
        if (allAnimals != null && !allAnimals.isEmpty()) {
          int count = 0;
          for (Animal animal : allAnimals) {
            String name = animal.getName();
            String breed = animal.getBreed();
            int age = animal.getAge();
            String description = animal.getDescription();
            LocalDate date = animal.getDateFound();
            byte[] picData = animal.getImages().get(0);
            String animalPic = Base64.getEncoder().encodeToString(picData);
            long id = animal.getAnimalId();
            if (count % 3 == 0) { %>
                  <div class="row my-4">
            <% } %>
            <div class="col-md-4">
              <div class="animal-card">
                <img src="data:image/jpeg;base64,<%= animalPic %>" alt="<%= name %>">
                <div class="card-body">
                  <h5><%= name %></h5>
                  <p>Breed: <%= breed %></p>
                  <p>Age: <%= age %> years</p>
                  <p>Date Found: <%= date.toString() %></p>
                  <% if (animal.getOwner() != null) { %>
                    <span><h3>Taken</h3></span>
                  <% } else { %>
                    <span><h3>Ready For Adoption</h3></span>
                  <% } %>
                </div>
                <p style=" padding-left:10px;"><%= description %></p>
                <button class="gradient-button" value="<%=id%>" name="animalId">View</button>
              </div>
              
            </div>
            <% 
              count++;
              if (count % 3 == 0) { %>
              </div>
            <% }
          } 
          if (count % 3 != 0) { %>
            </div>
          <% } 
        } else { 
      %>
        <p class="text-center">No adopted Animals yet.</p>
        
      <% } %>
</section>
</form>
</body>
    
    <!-- Footer -->
    <footer class="footer">
      <p style="color:#ffff;">&copy; 2025 Pawfect Match. All rights reserved.</p>
    </footer>
  

  <script>
    function openNav() {
      document.getElementById("myNav").classList.toggle("menu_width");
      document.querySelector(".custom_menu-btn").classList.toggle("menu_btn-style");
    }
  </script>
  
   <style>
  
  .row {
  margin-top: 20px;
  margin-bottom: 20px;
}
  
  
    .animal-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 20px;
      margin: 20px;
    }

    .animal-card {
      border: 1px solid #ccc;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      background-color: #fff;
      
    }

    .animal-card img {
      width: 100%;
      height: 200px;
      object-fit: cover;
    }

    .animal-card .card-body {
      padding: 15px;
    }

    .animal-card .card-body h5 {
      font-size: 22px;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .animal-card .card-body h3 {
      font-weight: bold;
      margin-bottom: 10px;
      color: #e7d619;
    }

    .animal-card .card-body p {
      font-family: 'Times New Roman', Times, serif;
      font-size: 17px;
      margin-bottom: 10px;
    }

 .animal-card:hover{
background-color: #ffff;
transform: scale(1.05);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);

 }
 .animal-card 

            body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .navbar {
    width: 100%; /* Ensures full-width navbar */
    background-color: #343a40;
    margin-bottom: 20px;
}

.card-text {
    display: -webkit-box;
    -webkit-line-clamp: 3; /* Limits the description to 3 lines */
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 0.9rem; /* Optional: make the text a little smaller */
    line-height: 1.4;   /* Optional: adjusts line height for readability */
    color: #555;        /* Optional: a subtle text color */
}


        .navbar-brand, .nav-link {
            color: #fff !important;
        }
        .footer {
            background-color: #343a40;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            margin-top: auto;
            width: 100%;
        }
    .product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Cards are smaller */
    gap: 15px; /* Less space between cards */
}

.card {
    transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    max-width: 100%; /* Ensure cards don't exceed the container width */
}

.card-img-top {
    max-height: 100%; /* Adjust the image height */
    object-fit: cover;
    border-radius: 0.5rem;
}


        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }
        .product-img {
        max-height: 350px;
            height: 100%;
            object-fit: cover;
            border-radius: 0.5rem;
        }
  </style>

</html>