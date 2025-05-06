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
  <link href="css/login.css" rel="stylesheet" />
  
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Pawfect Match - Animal Info</title>

  <!-- Include styles and fonts -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
  
  <style>
    /* Include the same custom styles */
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
    
    * {
	box-sizing: border-box;
}

body {
	font-family: "Open Sans", sans-serif;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	gap: 2rem;
	justify-content: center;
	align-items: center;
}

img {
	display: block;
	width: 100%;
}

h2 {
	margin: 0;
	font-size: 1.4rem;
}

@media (min-width: 50em) {
	h2 {
		font-size: 1.8rem;
	}
}

.cta {
	--shadowColor: 187 60% 40%;
	display: flex;
	flex-wrap: wrap;
	background: hsl(187 70% 85%);
	max-width: 50rem;
	width: 100%;
	box-shadow: 0.65rem 0.65rem 0 hsl(var(--shadowColor) / 1);
	border-radius: 0.8rem;
	overflow: hidden;
	border: 0.5rem solid;
}

.cta img {
	aspect-ratio: 3 / 2;
	object-fit: cover;
	flex: 1 1 300px;
	outline: 0.5rem solid;
}

.cta__text-column {
	padding: min(2rem, 5vw) min(2rem, 5vw) min(2.5rem, 5vw);
	flex: 1 0 50%;
}

.cta__text-column > * + * {
	margin: min(1.5rem, 2.5vw) 0 0 0;
}

.cta a {
	display: inline-block;
	color: black;
	padding: 0.5rem 1rem;
	text-decoration: none;
	background: hsl(187 75% 64%);
	border-radius: 0.6rem;
	font-weight: 700;
	border: 0.35rem solid;
}

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



 .footer {
            background-color: #343a40;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            margin-top: auto;
            width: 100%;
        }
  </style>
</head>

<body>
  <!-- Include the same navbar -->
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
                boolean admin = false;
                
                if(user != null){
                	if(user.getEmail().equals("marquezjulian09@gmail.com")){
                    	admin = true;
                    }
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
      
<style>
    .custom-carousel {
        position: relative;
        max-width: 100%;
        overflow: hidden;
        text-align: center;
    }

    .carousel-images {
        display: flex;
        transition: transform 0.5s ease-in-out;
    }

    .carousel-image {
        max-width: 100%;
        flex: 0 0 100%;
        object-fit: cover;
    }

    .prev-btn, .next-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background-color: rgba(0, 0, 0, 0.5);
        color: #fff;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        font-size: 1.5rem;
        border-radius: 5px;
    }

    .prev-btn {
        left: 10px;
    }

    .next-btn {
        right: 10px;
    }

    .prev-btn:hover, .next-btn:hover {
        background-color: rgba(0, 0, 0, 0.8);
    }
</style>

  <!-- Main Content -->
  <section>
    <div class="container">


      <% 
        Database database = new Database();
        Animal animal = (Animal) context.getAttribute("animal");
        if (animal != null) {
          String name = animal.getName();
          String breed = animal.getBreed();
          int age = animal.getAge();
          String description = animal.getDescription();
          byte[] picData = animal.getImages().get(0);
          LocalDate foundDate = animal.getDateFound();
          String animalPic = Base64.getEncoder().encodeToString(picData);
 		
      %>

      <article class="cta">
      
	 <div class="imgBx">
			        <% if (animal.getImages() != null && !animal.getImages().isEmpty()) { %>
			            <div class="custom-carousel">
			    <div class="carousel-images">
			        <% for (byte[] images : animal.getImages()) {
			            String base64Image = Base64.getEncoder().encodeToString(images);
			        %>
			            <img src="data:image/jpeg;base64,<%=base64Image%>" class="carousel-image" >
			        <% } %>
			    </div>
			    <% if(animal.getImages().size() > 1){ %>
			    <button class="prev-btn" onclick="moveSlide(-1)">❮</button>
			    <button class="next-btn" onclick="moveSlide(1)">❯</button>
			    <% } %>
			</div>

        <% } else { %>
            <p>No images available.</p>
        <% } %>
    </div>
	<div class="cta__text-column">
		<h5>Name: <%= name %></h5>
		<h2>Date Found: <%=foundDate %></h2>
          <p>Breed: <%= breed %></p>
          <p>Age: <%= age %> years</p>
          <p>Description: <%= description %></p>
          
          <%if(animal.getOwner() == null){ %>
          <form action="AnimalServlet" method="get">
		<button class="gradient-button" name="action" value="adopt">Adopt</button>
		<input type="hidden" name="animalId" value="<%=animal.getAnimalId()%>"></input>
		</form>
		<%}%>
		<%if(admin){
			%>
			<form action="handleAnimals" method="get">
			<button class="gradient-button" name="action" value="edit">Edit</button>
			<button class="gradient-button" name="action" value="delete">Delete</button>
			<input type="hidden" name="animalId" value="<%=animal.getAnimalId()%>"></input>
			
			</form>
		<% } %>
	</div>
</article>
      <% } else { %>
      <p class="text-center">Animal not found.</p>
      <% } %>
    </div>
  </section>
  



  <!-- Footer -->
  <footer class="footer">
    <p>&copy; 2025 Pawfect Match. All rights reserved.</p>
  </footer>

 <script>
    let currentSlide = 0;

    function showSlide(index) {
        const slides = document.querySelectorAll('.carousel-image');
        const totalSlides = slides.length;

        slides.forEach((slide, i) => {
            slide.style.display = i === index ? 'block' : 'none';
        });
    }

    function moveSlide(direction) {
        const slides = document.querySelectorAll('.carousel-image');
        currentSlide = (currentSlide + direction + slides.length) % slides.length;
        showSlide(currentSlide);
    }

    // Initialize the carousel
    document.addEventListener('DOMContentLoaded', () => {
        showSlide(currentSlide);
    });
</script>

</body>

</html>
