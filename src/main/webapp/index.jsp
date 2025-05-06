<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %> <%@ page import="java.util.*" %>  <%@ page import="box.*" %>
<%@ page import="java.util.Base64" %>

<%
ServletContext context = request.getServletContext();

User user = (User) context.getAttribute("loggedinUser");

Accounts account = new Accounts();
Database connect = new Database();
try{
	if(user == null){
	
	

	List<User> users = connect.getAllUsers();
	for(User test : users){
	System.out.print(test.getFirstname());
	}
	}

}catch(IndexOutOfBoundsException e){
	
}

%>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   
   <link href="css/buttons.css" rel="stylesheet" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />

  <title>Pawfect Match</title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />
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
            <div id="myNav" class="overlay">
              <div class="overlay-content">
                <a href="index.jsp"><button class="glass-btn">Home</button></a>
                <a href="about.jsp"><button class="glass-btn">About</button></a>
                <a href="Products.jsp"><button class="glass-btn">Fund Us</button></a>
                <a href="AllAnimals.jsp"><button class="glass-btn">Adopt An Animal</button></a>
                
                <% 
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
      
      <style>

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
  font-size: auto;
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

</style>
    </header>
    <!-- end header section -->
    
    <!-- slider section -->
    <section class="slider_section">
      <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
          <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="container-fluid">
              <div class="row">
                <div class="col-md-5 offset-md-1">
                  <div class="detail-box">
                    <div class="number">
                     
                    </div>
                    <h1>
                      Pawfect Match <br>
                      <span>
                        Pet And Animal
                      </span>
                    </h1>
                    <p>
                      Save a life, change your own—adopt and experience unconditional love.
                    </p>
                    <div class="btn-box">
                         <a  style="width:auto; padding: 10px;" href="AllAnimals.jsp" class="btn-1">
                        Find Your Pawfect Match
                      </a>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="img-box">
                    <img src="images/dog1.jpg" alt="" style="max-height: 570px; width: auto;">
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
                    <h1>
                      Pawfect Match <br>
                      <span>
                        Support and treat your Pet
                      </span>
                    </h1>
                    <p>
                      Every purchase helps feed, shelter, and care for animals in need—shop with purpose!
                    </p>
                    <div class="btn-box">
                      <a style="width:auto; padding: 10px;" href="Products.jsp" class="btn-2">
                        Fund The animals
                      </a>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="img-box">
                    <img src="images/background-image.png" alt="" style="max-height: 570px; width: auto;">
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
                    <h1>
                      Be Pawfect <br>
                      <span>
                        Pet And Animal
                      </span>
                    </h1>
                    <p>
                      Give a loving pet a second chance—adopt today and gain a best friend for life!
                    </p>
                    <div class="btn-box">
                      <a  style="width:auto; padding: 10px;" href="AllAnimals.jsp" class="btn-1">
                        Start Adopting Today
                      </a>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="img-box">
                    <img src="images/dog2.jpg" alt="" style="max-height: 570px; width: auto;">
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
                    <h1>
                      Supportive <br>
                      <span>
                        Support the Loving Animals
                      </span>
                    </h1>
                    <p>
                      Your support gives homeless pets a chance to find loving families.
                    </p>
                    <div class="btn-box">
                      <a  style="width:auto; padding: 10px;" href="AllProducts.jsp" class="btn-2">
                        Fund The animals
                      </a>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="img-box">
                    <img src="images/cat1.jpg" alt="">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </section>
    <!-- end slider section -->
  </div>

  <!-- about section -->

  <section class="about_section layout_padding">
    <div class="container">
      <div class="detail-box">
        <div class="heading_container">
          <img src="images/heading-img.png" alt="">
          <h2>
            About Us
          </h2>
        </div>
        <p>
          It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters,
        </p>
        <div class="btn-box">
          <a href="">
            <span>
              Read More
            </span>
            <img src="images/link-arrow.png" alt="">
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- end about section -->

  <!-- animal section -->

  <section class="animal_section layout_padding">
    <div class="container">
      <div class="animal_container">
        <div class="box b1">
          <div class="img-box">
            <img src="images/dog.jpg" alt="">
          </div>
          <div class="detail-box">
            <h5>
              Loyal Protector
            </h5>
            <p>
              A symbol of trust and companionship, embodying loyalty and unconditional love. The perfect addition to any family.
            </p>
          </div>
        </div>
        <div class="box b2">
          <div class="img-box">
            <img src="images/bird.jpg" alt="">
          </div>
          <div class="detail-box">
            <h5>
              A Free Spirit
            </h5>
            <p>
              Graceful and full of life, representing freedom and joy. A reminder of nature’s beauty and the power of exploration.
            </p>
          </div>
        </div>
        <div class="box b1">
          <div class="img-box">
            <img src="images/rabbit.png" alt="">
          </div>
          <div class="detail-box">
            <h5>
              Gentle Hopper
            </h5>
            <p>
              Soft, playful, and full of charm, bringing joy and warmth wherever it goes. A symbol of kindness and quiet curiosity.
            </p>            
          </div>
        </div>
        <div class="box b2">
          <div class="img-box">
            <img src="images/cat.jpg" alt="">
          </div>
          <div class="detail-box">
            <h5>
              The Independent Spirit
            </h5>
            <p>
              Playful yet mysterious, embodying resilience and curiosity. A reminder that adventure is always just around the corner.
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>


  <!-- end animal section -->

  <!-- pet section -->

  <section class="pet_section layout_padding">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <div class="img-box">
            <img src="images/cared_pet.png" alt="">
          </div>
        </div>
        <div class="col-md-6">
          <div class="detail-box">
            <div class="heading_container">
              <img src="images/heading-img.png" alt="">
              <h2>
                Caring for your pets
              </h2>
            </div>
            <p>
           When choosing your pet its also a bout your pet choosing you. Here at the Pawfect Match we ensure that every pet has a nic eloving home and that every Family has an incredible pet. </p>
            <div class="btn-box">
              <a href="">
                <span>
                  Read More
                </span>
                <img src="images/link-arrow.png" alt="">
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- end pet section -->

  <!-- us section -->

  <section class="us_section layout_padding-bottom">
    <div class="container">
      <div class="heading_container">
        <img src="images/heading-img.png" alt="">
        <h2>
          Why Choose Us
        </h2>
        <p>
          It is a long established fact that a reader will be distracted by the readable content of a
        </p>
      </div>
      <div class="us_container">
        <div class="box">
          <div class="img1-box">
            <img src="images/sample_dog1.png" alt="">
          </div>
          <div class="img2-box">
            <img src="images/omega.png" alt="">
          </div>
          <div class="detail-box">
            <h6>
              PET NUTRITIONISTS
            </h6>
          </div>
        </div>
        <div class="box">
          <div class="img1-box">
            <img src="images/sample_cat1.png" alt="">
          </div>
          <div class="img2-box">
            <img src="images/dog.png" alt="">
          </div>
          <div class="detail-box">
            <h6>
              STANDARDS
            </h6>
          </div>
        </div>
        <div class="box">
          <div class="img1-box">
            <img src="images/pet2.png" alt="">
          </div>
          <div class="img2-box">
            <img src="images/shield.png" alt="">
          </div>
          <div class="detail-box">
            <h6>
              QUALITY & SAFETY
            </h6>
          </div>
        </div>
      </div>
      <div class="btn-box">
       
          <img src="images/link-arrow.png" alt="">
       
      </div>
    </div>
  </section>

  <!-- end us section -->

  <!-- food section -->
  
  <%
  
      List<String> images = new ArrayList<>();
      images.add("images/f1.png");
      images.add("images/f2.png");
      images.add("images/f3.png");
      
      Product product1 = null;
      Product product2 = null;
      Product product3 = null;
      List<Product> products = null;
      boolean Empty = true;
     try{
    	 
    	  products = connect.getAllProducts();
    	 if(products != null){
    		product1 = products.get(0);
    		product2 = products.get(1);
    		product3 = products.get(2);
    		 
    		String image1 = Base64.getEncoder().encodeToString(product1.getImages().get(0));
    		String image2 = Base64.getEncoder().encodeToString(product2.getImages().get(0));
    		String image3 = Base64.getEncoder().encodeToString(product3.getImages().get(0));
    		 
    		Empty = false;
    		
    		 images.clear();
    		 images.add(image1);
    		 images.add(image2);
    		 images.add(image3);
    		 
    	 }
    	 
    	 
     }catch(NullPointerException e){
    	 
    	 
     }catch(IndexOutOfBoundsException e){
		 
	 }
                		
  %>

  <section class="food_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <img src="images/heading-img.png" alt="">
        <h2>
          Product Profits help Our Our Cause
        </h2>
        <p>
          When you choose to buy from us, you choose to help the cause of abandon animals
        </p>
      </div>
      <%
      if(products == null){
    	  %>
      
      
      <div class="food_container">
        <div class="box">
          <div class="img-box">
            <img src="images/f1.png" alt="">
          </div>
          <div class="detail-box">
            <h6>
              Basic
            </h6>
            <h3>
              <span>$</span>100
            </h3>
            <a href="">
              Buy Now
            </a>
          </div>
        </div>
        <div class="box">
          <div class="img-box">
            <img src="images/f2.png" alt="">
          </div>
          <div class="detail-box">
            <h6>
              Medium
            </h6>
            <h3>
              <span>$</span>200
            </h3>
            <a href="">
              Buy Now
            </a>
          </div>
        </div>
        <div class="box">
          <div class="img-box">
            <img src="images/f3.png" alt="">
          </div>
          <div class="detail-box">
            <h6>
              Standard
            </h6>
            <h3>
              <span>$</span>300
            </h3>
            <a href="">
              Buy Now
            </a>
          </div>
        </div>
      </div>
    <%   }
      else{
    	  
    	  %>
    	  <form action="handleProducts" method="post">
    	        <div class="food_container">
        <div class="box">
          <div class="img-box">
            <img  src="data:image/jpeg;base64, <%=images.get(0) %>" alt="">
          </div>
          <div class="detail-box">
            <h6>
             <%=product1.getName()%>
            </h6>
            <h3>
              <span>$</span><%= product1.getPrice()%>
            </h3>
           <button class="gradient-button" type="submit" name="productId" value="<%=product1.getProductId()%>" >
              View Now
            </button>
            <input type="hidden" name="view" value="view" >
           
          </div>
        </div>
        <div class="box">
          <div class="img-box">
            <img  src="data:image/jpeg;base64, <%=images.get(1) %>" alt="">
          </div>
          <div class="detail-box">
            <h6>
              <%= product2.getName()%>
            </h6>
            <h3>
              <span>$</span><%= product2.getPrice()%>
            </h3>
          <button class="gradient-button" type="submit" name="productId" value="<%=product2.getProductId()%>" >
              View Now
            </button>
          </div>
        </div>
        <div class="box">
          <div class="img-box">
            <img  src="data:image/jpeg;base64, <%=images.get(2) %>" alt="">
          </div>
          <div class="detail-box">
            <h6>
              <%= product3.getName()%>
            </h6>
            <h3>
              <span>$</span><%= product3.getPrice()%>
            </h3>
            <button class="gradient-button" type="submit" name="productId" value="<%=product3.getProductId()%>" >
              View Now
            </button>
          </div>
        </div>
      </div>
      </form>
  <%    }
       %>
    </div>
  </section>


  <!-- client section -->

  <section class="client_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <img src="images/heading-img.png" alt="">
        <h2>
          What Says Our Customer
        </h2>
        <p>
          It is a long established fact that a reader will be distracted by the
        </p>
      </div>
      <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="box">
              <div class="img-box">
                <img src="images/client.png" alt="">
              </div>
              <div class="detail-box">
                <h4>
                  Jack Mengo
                </h4>
                <p>
                  It is a long established fact that a reader will be distracted by the readable cIt is a long established fact that a reader will be distracted by the readable c
                </p>
                <img src="images/quote.png" alt="">
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <div class="box">
              <div class="img-box">
                <img src="images/client.png" alt="">
              </div>
              <div class="detail-box">
                <h4>
                  Jack Mengo
                </h4>
                <p>
                  It is a long established fact that a reader will be distracted by the readable cIt is a long established fact that a reader will be distracted by the readable c
                </p>
                <img src="images/quote.png" alt="">
              </div>
            </div>
          </div>
          <div class="carousel-item">
            <div class="box">
              <div class="img-box">
                <img src="images/client.png" alt="">
              </div>
              <div class="detail-box">
                <h4>
                  Jack Mengo
                </h4>
                <p>
                  It is a long established fact that a reader will be distracted by the readable cIt is a long established fact that a reader will be distracted by the readable c
                </p>
                <img src="images/quote.png" alt="">
              </div>
            </div>
          </div>
        </div>
        <div class="carousel_btn-box">
          <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="sr-only">Next</span>
          </a>
        </div>
      </div>
    </div>
  </section>

  <!-- end client section -->

  <!-- contact section -->

  <section class="contact_section layout_padding-top">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-5 offset-md-1">
          <div class="form_container">
            <div class="heading_container">
              <img src="images/heading-img.png" alt="">
              <h2>
                Request A Call Back
              </h2>
              <p>
                It is a long established fact that a reader will be distracted by the
              </p>
            </div>
            <form action="">
              <div>
                <input type="text" placeholder="Full Name " />
              </div>
              <div>
                <input type="text" placeholder="Phone number" />
              </div>
              <div>
                <input type="email" placeholder="Email" />
              </div>
              <div>
                <input type="text" class="message-box" placeholder="Message" />
              </div>
              <div class="d-flex ">
                <button>
                  SEND
                </button>
              </div>
            </form>
          </div>
        </div>
        <div class="col-md-6 px-0">
          <div class="map_container">
            <div class="map-responsive">
              <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyA0s1a7phLN0iaD6-UE7m4qP-z21pH0eSc&q=Eiffel+Tower+Paris+France" width="600" height="300" frameborder="0" style="border:0; width: 100%; height:100%" allowfullscreen></iframe>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- end contact section -->


  <!-- info section -->
  <section class="info_section ">
    <div class="container">
      <div class="row">
        <div class="col-md-6 col-lg-3">
          <div class="info_contact">
            <h5>
              CONTACT INFO
            </h5>
            <div>
              <img src="images/mail.png" alt="" />
              <p>
                PawFect_Team@gmail.com
              </p>
            </div>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="info_time">
            <h5>
              Opening Hours Shop
            </h5>
            <div>
              <p>
                Monday to Friday
              </p>
            </div>
            <div>
              <p>
                07:00 am to 04:00 pm
              </p>
            </div>
          </div>
        </div>

        
        <div class="col-md-6 col-lg-3">
          <div class="info_form pl-lg-4">
            <h5>
              Newsletter
            </h5>
            <form action="">
              <input type="text" placeholder="Enter Your Email" />
              <button type="submit">
                Subscribe
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="container-fluid footer_section ">
    <p>
      &copy; Pawfect Match 2025 All Rights Reserved
    </p>
  </section>
  <!-- end  footer section -->


  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <script>
    function openNav() {
      document.getElementById("myNav").classList.toggle("menu_width")
      document.querySelector(".custom_menu-btn").classList.toggle("menu_btn-style")
    }
  </script>
   
</body>

</html>