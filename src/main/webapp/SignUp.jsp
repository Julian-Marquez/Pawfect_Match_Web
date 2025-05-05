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

  <title>Pawfect Match - SignUp</title>

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
 
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />
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
                <a href="#about.jsp">About</a>
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
                <h3>Sign Up</h3>
              </div>
 <div class="card-body">
<script>// JavaScript Password Validation
function validatePassword() {
    var password = document.getElementById("Password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    // Check if password length is at least 8 characters
    if (password.length < 8) {
      alert("Password must be at least 8 characters long");
      return false;
    }

    // Check if password contains at least one symbol
    if (!/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/.test(password)) {
      alert("Password must contain at least one symbol");
      return false;
    }

    // Check if password matches confirmed password
    if (password !== confirmPassword) {
      alert("Passwords do not match");
      return false;
    }

    // Password meets all requirements
    return true;
  }
</script>
                <form onsubmit="validatePassword()" action="Accounts" method="post" enctype="multipart/form-data"  >

                  <div class="form-group">

                    <label for="firstName">First Name</label>

                    <input type="text" class="form-control" id="firstName" name="Firstname" placeholder="Enter your first name">

                  </div>

                  <div class="form-group">

                    <label for="lastName">Last Name</label>

                    <input type="text" class="form-control" id="lastName" name="Lastname" placeholder="Enter your last name">

                  </div>

                  <div class="form-group">

                    <label for="email">Email Address</label>

                    <input type="email" class="form-control" id="email" name="Email" aria-describedby="emailHelp" placeholder="Enter email">

                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>

                  </div>

                  <div class="form-group">

                    <label for="password">Password</label>

                    <input type="password" class="form-control" id="Password" name="Password" placeholder="Enter password">

                  </div>

                  <div class="form-group">

                    <label for="confirmPassword">Confirm Password</label>

                    <input type="password" class="form-control" id="confirmPassword" name="ConfirmPassword" placeholder="Confirm password">

                  </div>

                  <div class="form-group">

                    <label for="file">Profile Picture (Optional)</label>

                    <input class="form-control-file" type="file" name="file"  accept="image/png, image/jpeg, image/jpg">

                  </div>

                  <button type="submit" class="btn btn-primary">Sign Up</button>

                </form>

              </div>
            </div>
          
          </div>
    </section>
    </div>

</body>

</html>