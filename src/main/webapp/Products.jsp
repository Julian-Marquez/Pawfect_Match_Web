<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="box.*" %>
<%@ page import="java.util.Base64" %>
<%
    Database connect = null;
    List<Product> products = null;
    ServletContext context = getServletContext();
    boolean loggedin = false;
    try {
    	User user = (User) context.getAttribute("loggedinUser");
    	if(user != null){
    		loggedin = true;
    	}
        connect = new Database();
        products = connect.getAllProducts();
    } catch (Exception e) {
        products = new ArrayList<>();
        out.println("Error retrieving products: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pawfect Shop</title>
    
    <link href="css/products.css" rel="stylesheet">
    <link href="css/nav.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
<!-- Navbar -->
<nav class="custom-navbar">
    <div class="navbar-container">
        <a class="navbar-brand" href="#">
            <img src="images/logo.png" alt="Logo" class="navbar-logo">
            <span>Pawfect</span>
        </a>
        <button class="navbar-toggler" aria-label="Toggle navigation">
            ☰
        </button>
        <div class="navbar-menu">
            <ul class="navbar-links">
                <li><a href="index.jsp" class="navbar-link">Home</a></li>
                <li><a href="Products.jsp" class="navbar-link">Products</a></li>
                <li><a href="#" class="navbar-link">About Us</a></li>
                <li><a href="#" class="navbar-link">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="Cart.jsp" id="cart-icon">🛒</a></li>
                <li><a href="Profile.jsp" class="navbar-btn">Profile</a></li>
            </ul>
        </div>
    </div>
</nav>
<style>

  .pulse {
            border: 2px solid black;
            background-color: #b8860b;
            color: white;
            padding: 0.5em 1em;
            font-size: 14px;
            cursor: pointer;
            transition: box-shadow 0.3s ease, background-color 0.3s ease;
        }
        .pulse:hover {
            animation: pulse 1s ease-in-out;
            background-color: blue;
            box-shadow: 0 0 0 2em rgba(255, 255, 0, 0.6);
        }
        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(255, 255, 0, 0.6);
            }
            100% {
                box-shadow: 0 0 0 20px rgba(255, 255, 0, 0);
            }
        }

</style>

    <!-- Banner -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="p-5 text-center bg-light rounded-3">
                    <h1 class="display-5 fw-bold">The Pawfect Shop</h1>
                    <p class="lead">Find the best product for your pet and help fund our organization.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Grid -->
    
    <div class="container mt-5">
        <h2>Our Products</h2>
        <div class="product-grid">
            <% 
            if (products != null && !products.isEmpty()) {
                for (Product product : products) {
                    byte[] productBytes = product.getImages().get(0);
                    String base64Image = Base64.getEncoder().encodeToString(productBytes);
            %>
            <form action="handleProducts" method="post">
            <div class="card">
                <img src="data:image/jpeg;base64,<%= base64Image %>" class="card-img-top product-img" alt="<%= product.getName() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= product.getName() %></h5>
                    <p class="card-text">$<%= product.getPrice() %></p>
                    <p class="card-text"><%= product.getDescription() %></p>
                    <button type="submit" name="addtocart" value="addtocart" onclick="addToCart(this)" class="pulse">Add to Cart</button>
                    <input type="hidden" name="productId" value="<%=product.getProductId()%>" ></input>
                    <span></span>
                    <button name="view" value="view" class="pulse">View Item</button>
                </div>
            </div>
            </form>
            <% 
                }
            } else {
            %>
            <p>No products available at the moment.</p>
            <% } %>
        </div>
    </div>
    <script src="js/animation.js"></script>

<footer class="footer bg-dark text-white">
    <div class="container-fluid"> <!-- Use container-fluid here -->
        <p class="text-center mb-0">&copy; 2025 Pawfect. All Rights Reserved.</p>
    </div>
</footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
