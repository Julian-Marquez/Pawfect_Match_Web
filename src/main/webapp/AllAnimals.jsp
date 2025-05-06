<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.*" %>
<%@ page import="box.*" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <link href="css/buttons.css" rel="stylesheet" />
  <link href="css/login.css" rel="stylesheet" />  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Pawfect Match - Login</title>

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />

  <title>Pawfect Match - Adopt an Animal</title>

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/gradient-btn.css" rel="stylesheet" />
      
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="css/responsive.css" rel="stylesheet" />
   <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  
  <%
  ServletContext context = getServletContext();
  
  User user = (User) context.getAttribute("loggedinUser");
  
  %>

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
</head>

<body>
  <div class="hero_area ">
    <!-- header section strats -->
    <header class="header_section">
      <div class="container-fluid">
        <nav class="navbar navbar-expand-lg custom_nav-container">
  		<a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" alt="">
          </a>
          <div class="" id="">
            <div class="User_option">
              <form class="form-inline my-2  mb-3 mb-lg-0">
                <input type="search" placeholder="Search">
                <button class="btn   my-sm-0 nav_search-btn" type="submit"></button>
              </form>
            </div>

            <div class="custom_menu-btn">
              <button onclick="openNav()">
                <span class="s-1">

                </span>
                <span class="s-2">

                </span>
                <span class="s-3">

                </span>
              </button>
            </div>
            <div  id="myNav" class="overlay">
              <div class="overlay-content">
                <a href="index.jsp">Home</a>
                <a href="#about.jsp">About</a>
                <a href="Products.jsp">Fund Us</a>
                <a href="AllAnimals.jsp">Adopt An Animal</a>
                
                <% 
                if(user != null){
                	%>
                	<a  href="Profile.jsp"><button class="glass-btn">Profile</button></a>
                	<% 
                }else{
                %>
                <a href="Login.jsp"><button class="glass-btn">Login</button></a>
                <%} %>
              </div>
            </div>
          </div>
        </nav>
      </div>
      <!-- Bootstrap JavaScript and dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
      
    </header>
    <!-- end header section -->
    
    <!-- slider section -->
    <section class="slider_section">
  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
    
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
      <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
      <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></li>
      <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3"></li>
    </ol>

    <!-- Carousel Items -->
    <div class="carousel-inner">
      <div class="carousel-item active">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-5 offset-md-1">
              <div class="detail-box">
                <div class="number">
                  
                </div>
                <h1>Matching Up!<br><span>Thank You</span></h1>
                <p>We Give Special Thanks to every person that contributes the organization.</p>
                
              </div>
            </div>
            <div class="col-md-6">
              <div class="img-box">
                <img src="images/adoptPage4.jpg" class="img-fluid" alt="" style="max-height: 570px; width: auto;">
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-5 offset-md-1">
              <div class="detail-box">
                <div class="number">
                </div>
                <h1>Treats<br><span>Adopt and Fund</span></h1>
                <p>Shop, donate, rescue—turn your kindness into action!</p>
                <div class="btn-box">
                  <a  style="width:auto; padding: 10px;" href="AllProducts.jsp" class="btn-2">Gift your pet</a>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="img-box">
                <img src="images/adoptPage1.jpg" class="img-fluid" alt="" style="max-height: 570px; width: auto;">
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-5 offset-md-1">
              <div class="detail-box">
                <div class="number">
                </div>
                <h1>Adding Up!<br><span>Every dollar counts.</span></h1>
                <p>Help provide a brighter future for homeless pets!"</p>
                <div class="btn-box">
                  <a style="width: auto; padding: 10px;"href="AllProducts.jsp" class="btn-2">Add to the Cause</a>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="img-box">
                <img src="images/adoptPage2.jpg" class="img-fluid" alt="" style="max-height: 570px; width: auto;">
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item">
        <div class="container-fluid">
          <div class="row">
            <div class="col-md-5 offset-md-1">
              <div class="detail-box">
                <div class="number">
                </div>
                <h1>Giving Back<br><span>Pay It Forward</span></h1>
                <p>Give back while you shop—your purchase provides food, shelter, and care!</p>
                <div class="btn-box">
					<a style="width: auto; padding: 10px;"href="AllProducts.jsp" class="btn-2">Give Back</a>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="img-box">
                <img src="images/adoptPage3.jpg" class="img-fluid" alt="" style="max-height: 570px; width: auto;">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Navigation Buttons -->
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>

  </div>
</section>

<!-- Include Bootstrap JavaScript -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- end slider section -->
  </div>
    <!-- Main Content -->
    <form action="AnimalServlet" method="post">
<section>
  <div class="container">
    <h1 class="text-center my-4">Adopt an Animal</h1>

      <% 
        Accounts account = new Accounts();
        Database database = new Database();
        List<Animal> allAnimals = database.getAllAnimals();
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
            
            try{
            	User owner = animal.getOwner();
            	System.out.println(" " + owner.getFirstname() + " ");
            	
            }catch(NullPointerException e){
            	
            }
            
            if (count % 3 == 0) { %>
                  <div class="row my-4">
            <% } %>
            <div class="col-md-4">
              <div class="animal-card">
                <img src="data:image/jpeg;base64,<%= animalPic %>" alt="<%= name %>">
                <div class="card-body">
                  <h5 class="animal_h5"><%= name %></h5>
                  <p>Breed: <%= breed %></p>
                  <p>Age: <%= age %> years</p>
                  <p>Date Found: <%= date.toString() %></p>
                  <% if (animal.getOwner() != null) { %>
                    <span><h3>Taken</h3></span>
                  <% } else { %>
                    <span><h3 class="animal_h3">Ready For Adoption</h3></span>
                  <% } %>
                </div>
                <p style="padding-left:10px;"><%= description %></p>
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
        <p class="text-center">No animals available for adoption at the moment.</p>
      <% } %>
</section>
</form>
    
    <!-- Footer -->
    <footer class="footer">
      <p>&copy; 2025 Pawfect Match. All rights reserved.</p>
    </footer>
  

  <script>
    function openNav() {
      document.getElementById("myNav").classList.toggle("menu_width");
      document.querySelector(".custom_menu-btn").classList.toggle("menu_btn-style");
    }
  </script>
</body>

</html>
