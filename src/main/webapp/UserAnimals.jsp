<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
      
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="css/responsive.css" rel="stylesheet" />
   <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">

  <style>
  $borderWidth: 5px;

@mixin buttonLayer {
  content: "";
  position: absolute;
  top: -$borderWidth;
  left: -$borderWidth;
  width: 100%;
 	height: 100%;
  margin: auto;
	border: $borderWidth solid transparent;
  opacity: 0;
  pointer-events: none;
 	border-image-slice: 1;
}
.gradient-button {
  display: block;
  margin: 10px auto; 
	height: 2.5rem;
	width: 8rem;
	background: transparent linear-gradient(to top left, rgba(249,208,129,.2) 0%, rgba(227,2,62,.2) 40%, rgba(49,128,135,.2) 100%);
	border: $borderWidth solid transparent;
	border-image-source: linear-gradient(to top left, rgba(249,208,129,1) 0%, rgba(227,2,62,1) 40%, rgba(49,128,135,1) 100%);
	border-image-slice: 1;
  transition: transform .25s;
  letter-spacing: .2rem;
  font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
  font-size: 1.25rem;
  font-weight: 300;
  text-align: center;
  text-decoration: none;
  text-transform: uppercase;
  color: #333;
  
    &::after {
    @include buttonLayer;
   
  	background: transparent linear-gradient(to bottom left, rgba(249,208,129,.25) 10%, rgba(227,2,62,.25) 30%, rgba(49,128,135,.25) 90%);
    border-image-source: linear-gradient(to bottom left, rgba(249,208,129,1) 10%, rgba(227,2,62,1) 30%, rgba(49,128,135,1) 90%);
    transition: opacity 1s;
  }

  &:active {
    transform: scale(.96);

    &::before {
      opacity: 1;
    }
  }

  &::before {
    @include buttonLayer;
    z-index: 0;
    border-image-source: linear-gradient(to bottom left, rgba(249,208,129,1) 20%, rgba(227,2,62,1) 40%, rgba(49,128,135,1) 70%);
    transition: opacity .5s;
  }

  &:hover::after {
    opacity: 1;
  }
}
  
  
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
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
    }

    .animal-card .card-body p {
      font-size: 14px;
      margin-bottom: 10px;
    }

    .animal-card .btn {
      background-color: #5cb85c;
      color: #fff;
      text-align: center;
      display: block;
      padding: 10px;
      border-radius: 5px;
      text-decoration: none;
    }

    .animal-card .btn:hover {
      background-color: #4cae4c;
      color: white;
    }
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
  <div class="hero_area">
    <header class="header_section">
      <div class="container-fluid">
        <nav class="navbar navbar-expand-lg custom_nav-container">
          <a class="navbar-brand" href="index.html">
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
            <div id="myNav" class="overlay">
              <div class="overlay-content">
                <a href="index.jsp">Home</a>
                <a href="#about.jsp">About</a>
                <a href="Products.jsp">Fund Us</a>
                <a href="AllAnimals.jsp">Adopt An Animal</a>
                
                <% 
                ServletContext context = getServletContext();
                User user = (User) context.getAttribute("loggedinUser");
                if(user != null){
                	%>
                	<a href="Profile.jsp"><button class="glass-btn">Profile</button></a>
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
      </header>
      </div>
    

    <!-- Main Content -->
    <form action="AnimalServlet" method="post">
<section>
  <div class="container">
    <h1 class="text-center my-4">Adopt an Animal</h1>

      <% 
        Accounts account = new Accounts();
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
                <p><%= description %></p>
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