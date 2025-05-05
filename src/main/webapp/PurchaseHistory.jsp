<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %> <%@ page import="box.*" %>
    <%
    ServletContext context =  getServletContext();
    User user = (User) context.getAttribute("loggedinUser");
    
   // Receipt receipt = (Receipt) context.getAttribute("receipt");
    List<Receipt> receipts = new ArrayList<>();
    try{
    	
    	receipts = user.getAllReceipts();
    	
    }catch(IndexOutOfBoundsException e){
    	
    }catch(NullPointerException e){
    	
    }
    
    %>
<!DOCTYPE html>
<html lang="en">
 <head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Purchase History</title>
  <link rel="stylesheet" href="css/history.css" />
  <link rel="stylesheet" href="css/nav.css"/>
  <link
   rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"
   integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog=="
   crossorigin="anonymous"
  />
 </head>
  <style>
  

    </style>
<!-- navbar.jsp -->


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



 <body>
 
 <form action="handleReceipts" method="post">
 <%
 if(!receipts.isEmpty()){
	 for(Receipt receipt: receipts){
		 String purchaseDate = receipt.getDateBought().toString();
		 Card payment = receipt.getPaymentMethod();
		 List<Product> products = receipt.getProducts();
		 double subTotal = receipt.getSubTotal();
		 int totalAmount = 0;
		 StringBuilder build = new StringBuilder();
		 
		 
		 for(Product p : products){
			 totalAmount += p.getAmount();
			 build.append(" " + p.getName()+",");
		 }
		  
		 Product product = products.get(0);
			 String productName = product.getName();
			 int amount = product.getAmount();
			 double price = product.getPrice();
			 String des = product.getDescription();
			String productImg =  Base64.getEncoder().encodeToString(product.getImages().get(0));
		 
			
		 %>
		 

  <div class="container">
  <div class="container__content">
   <img
    src="data:image/jpeg;base64,<%=productImg%>" 
    alt="Pancake"
   />
   <%if(products.size() > 2){ 
	   Product product2 = products.get(1);
		String productImg2 =  Base64.getEncoder().encodeToString(product2.getImages().get(0));
		Product product3 = products.get(2);
		String productImg3 =  Base64.getEncoder().encodeToString(product3.getImages().get(0));
   %>
	   
   <img
    src="data:image/jpeg;base64,<%=productImg2%>" 
    alt="Pancake"
   />
   <img
    src="data:image/jpeg;base64,<%=productImg3%>" 
    alt="Pancake"
   />
   <% }   %>
   </div>
   <div class="container__text">
    <h1><i class="fa fa-calendar icon"></i>Purchase Date: <%=purchaseDate %></h1>

      <h2><i class="fa fa-box icon"></i>Items Purchased: <%= build%></h2>
      
      <div class="container__text__timing">
        <div class="container__text__timing_time">
          <h2><i class="fa fa-cogs icon"></i>Item count: <%=totalAmount %></h2>
        </div>
        <div class="container__text__timing_time">
          <h2><i class="fa fa-dollar-sign icon"></i>SubTotal: $<%=subTotal %></h2>
        </div>
    </div>
    <button name="receiptId" value="<%=receipt.getReceiptId()%>" class="btn">view receipt <i class="fa fa-arrow-right"></i></button>
   </div>
  </div>
  <% 	
		 }
		 

 }
 %>
 </form>
 </body>
 <footer class="footer bg-dark text-white">
    <div class="container-fluid"> <!-- Use container-fluid here -->
        <p style="text-size:20px;" >&copy; 2025 Pawfect. All Rights Reserved.</p>
    </div>
</footer>
</html>
