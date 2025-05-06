<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %> <%@ page import="java.util.List" %> <%@ page import="box.*" %>

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
  <link href="css/Profile.css" rel="stylesheet"/>
  
  <link href="css/responsive.css" rel="stylesheet" />
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
                <a href="index.jsp">Home</a>
                <a href="about.jsp">About</a>
                <a href="product.jsp">Fund Us</a>
                <a href="AllAnimals.jsp">Adopt An Animal</a>
              </div>
            </div>
          </div>
        </nav>
      </div>
    </header>
    <section class="login-section">
        <div class="row justify-content-center">
            <div class="card">
              <div class="card-header">
                <h3>Login</h3>
              </div>
              <div class="card-body">
                <form action="Login" method="post">  <div class="form-group">
                    <label for="username">Email</label>
                    <input type="email" class="form-control" id="username" name="Email" placeholder="Enter email">
                  </div>
                  <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="Password" placeholder="Enter password">
                  </div>
                  <div class="form-group form-check">
                    <input type="checkbox" class="form-check-input" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember Me</label>
                  </div>
                  <button type="submit" class="button-29">Login</button>
                  <a href="Recover.jsp" class="forgot-password">Forgot password?</a>
                  <div class="form-group form-check">
                  <Label for="SignUp" class="form-check-label">New user? Make an an account</Label>
                  <a id="SignUp" href="SignUp.jsp" class="forgot-password">Sign Up</a>
                  </div>
                </form>
              </div>
            </div>
          
          </div>
    </section>
    </div>

</body>
  <script>
    function openNav() {
      document.getElementById("myNav").classList.toggle("menu_width")
      document.querySelector(".custom_menu-btn").classList.toggle("menu_btn-style")
    }
  </script>
</html>