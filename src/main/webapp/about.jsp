<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>About Us - Pawfect Match</title>
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
</head>

<body>
  <div class="hero_area">
    <header class="header_section">
      <div class="container-fluid">
        <nav class="navbar navbar-expand-lg custom_nav-container">
          <a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" alt="Pawfect Match Logo">
          </a>
          <div class="custom_menu-btn">
            <button onclick="openNav()">
              <span class="s-1"></span>
              <span class="s-2"></span>
              <span class="s-3"></span>
            </button>
          </div>
          <div id="myNav" class="overlay">
            <div class="overlay-content">
              <a href="index.jsp">Home</a>
              <a href="about.jsp">About</a>
              <a href="Products.jsp">Fund Us</a>
              <a href="AllAnimals.jsp">Adopt An Animal</a>
              <a href="Login.jsp"><button class="glass-btn">Login</button></a>
            </div>
          </div>
        </nav>
      </div>
    </header>
    
    <section class="about_section layout_padding">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <div class="detail-box">
              <h2>About Pawfect Match</h2>
              <p>
                Pawfect Match is dedicated to connecting loving homes with pets in need. Our mission is to promote animal 
                adoption, provide care, and create a community that values the well-being of every animal. Whether you're 
                looking to adopt, support, or learn more about responsible pet ownership, we are here to help!
              </p>
              <p>
                Join us in making a difference—one paw at a time!
              </p>
              <a href="AllAnimals.jsp" class="btn-1">Find Your Pawfect Match</a>
            </div>
          </div>
          <div class="col-md-6">
            <div class="img-box">
              <img src="images/about-image.png" alt="About Us Image" style="max-height: 520px; width: auto; border-radius: 10px;">
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <footer class="footer_section">
      <div class="container">
        <p>&copy; 2024 Pawfect Match. All Rights Reserved.</p>
      </div>
    </footer>
  </div>
</body>
  <script>
    function openNav() {
      document.getElementById("myNav").classList.toggle("menu_width")
      document.querySelector(".custom_menu-btn").classList.toggle("menu_btn-style")
    }
  </script>
  <link href="css/buttons.css" rel="stylesheet" />
</html>
