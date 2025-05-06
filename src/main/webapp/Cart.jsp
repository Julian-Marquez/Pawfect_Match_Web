<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="box.*" %> <%@ page import="java.util.*" %><%@ page import="java.text.*" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link href="css/Cart.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" rel="stylesheet">
      <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"></script>
<script src="https://unpkg.com/tippy.js@6/dist/tippy-bundle.umd.js"></script>
  <link rel="stylesheet" href="tailwind.css">
   <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
      integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm"
      crossorigin="anonymous"
    />
</head>

<style>
    .des {
        max-height: 80px; 
        max-width: 160px; 
        overflow: hidden; 
        text-overflow: ellipsis; 
        word-wrap: break-word; 
    }
    
    .img-button {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        width: 100%; /* Make button span across */
        border: none;
        background: #fff; /* White background for a clean look */
        padding: 10px;
        margin: 10px 0;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        border-radius: 5px; /* Rounded corners */
        text-align: left;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .img-button:hover {
        transform: scale(1.02); /* Slight zoom effect on hover */
        box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15); /* Enhanced shadow on hover */
    }

    .img-button img {
        max-width: 180px; /* Limit the image width */
        height: auto; /* Maintain aspect ratio */
        border-radius: 5px; /* Match button corners */
        margin-right: 15px; /* Space between image and text */
    }

    .img-button .content {
        flex-grow: 1; /* Allow content to grow and fill space */
    }

    .img-button .content .product-name {
        font-weight: bold;
        margin-bottom: 5px;
        font-size: 1rem;
    }

    .img-button .content .product-description {
        font-size: 0.9rem;
        color: #555; /* Subtle text color */
    }

    .img-button .content .price {
        font-weight: bold;
        color: #000;
    }
    
    .cart-img{
            max-width: 180px; /* Limit the image width */
        height: auto; /* Maintain aspect ratio */
        border-radius: 5px; /* Match button corners */
        margin-right: 15px; /* Space between image and text */
    
    
    }
    
/* General button styling */
.cart-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    margin: 0 5px;
    border: none;
    border-radius: 50%; /* Makes the button round */
    background-color: #e4cb58; /* Preferred background color */
    color: #fff; /* White icon color */
    font-size: 1.2rem;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

/* Hover effect */
.cart-button:hover {
    background-color: #c4a73e; /* Darker shade on hover */
    transform: scale(1.1); /* Slightly enlarge button on hover */
}

/* Active (pressed) effect */
.cart-button:active {
    background-color: #a4882e; /* Even darker shade when active */
    transform: scale(1); /* Reset scale when active */
}


/* Specific styles for each button */
.cart-button.plus::before {
    content: '\f067'; /* Font Awesome plus icon */
}

.cart-button.minus::before {
    content: '\f068'; /* Font Awesome minus icon */
}

.cart-button.remove::before {
    content: '\f00d'; /* Font Awesome times (×) icon */
}
.cart-button.clear {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: auto;
    height: 40px;
    margin: 0 5px;
        border: none;
    border-radius: 4px; /* Slightly rounded corners (optional) */
    background-color: #e45a58; /* Preferred background color for Clear Cart */
    color: #fff; /* White icon color */
    font-size: 1.2rem;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

/* Hover effect */
.cart-button.clear:hover {
    background-color: #c43e3e; /* Darker shade on hover */
    transform: scale(1.1); /* Slightly enlarge button on hover */
}

/* Active (pressed) effect */
.cart-button.clear:active {
    background-color: #a42e2e; /* Even darker shade when active */
    transform: scale(1); /* Reset scale when active */
}

/* Clear Cart icon */
.cart-button.clear::before {
    content: '\f2ed'; /* Font Awesome trash icon */
    font-family: "Font Awesome 5 Free"; /* Ensure Font Awesome is loaded */
    font-weight: 900; /* Use solid icon weight */
}

    .footer {
    padding: 1rem 0;
    text-align: center;
}
    .navbar-nav .nav-link {
    display: block;
    padding: 0.5rem 1rem;
}
    
    
</style>

<nav class="navbar navbar-dark bg-dark flex-column align-items-start">
   
    <ul class="navbar-nav">
     <a class="navbar-brand" href="Products.jsp">Pawfect Shop</a>
        <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="AllAnimals.jsp">Adopt</a></li>
        <li class="nav-item"><a class="nav-link" href="Products.jsp">Products</a></li>
        <li class="nav-item"><a class="nav-link" href="Profile.jsp">Profile</a></li>
        <li class="nav-item"><a class="nav-link" href="Cart.jsp" id="cart-icon">🛒</a></li>
    </ul>
</nav>

<body>
    <div class="card">
        <div class="row">
            <div class="col-md-8 cart">
                <div class="title">
                    <div class="row">
                        <div class="col"><h4><b>Shopping Cart</b></h4></div>
                    </div>
                </div>
                <%
                DecimalFormat df = new DecimalFormat("#,###.##");
                ServletContext context = getServletContext();
                User user = (User) context.getAttribute("loggedinUser");
                int amount = 0;
                int shipping_fee = 5;
                double tax = 0.07;
                double total_price = 0;
                String formedPrice = "";
                
                try{
                
                Collection<Product> userProducts = user.getAllProducts();
                for (Product product : userProducts) {
                    int productAmount = product.getAmount();
                    amount += productAmount;
                    double price = product.getPrice();
                    
                    double taxed = (price * tax) + price;
                    
                    String taxformat = df.format(taxed);
                    
                    double priceTaxed = Double.parseDouble(taxformat);
                    
                    double totalProductPrice = productAmount * price * (1 + tax);
                   

                    String formattedPrice = df.format(totalProductPrice);
                    double reformat = Double.parseDouble(formattedPrice);
                    total_price += reformat;
                    
                     formedPrice = df.format(total_price);
                    
                    byte[] productBytes = product.getImages().get(0);
                    String base64Image = Base64.getEncoder().encodeToString(productBytes);
                %>
                

                <form action="handleProducts" method="post">
                
                <div class="row main align-items-center">
               <button class="img-button" name="view" value="view">
				    <img class="cart-img" src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
				    <div class="content">
				        <div class="product-name"><%= product.getName() %></div>
				        <div class="product-description des"><%= product.getDescription() %></div>
				        <div class="price">$<%= product.getPrice() %></div>
				    </div>
				    <input type="hidden" name="productId" value="<%=product.getProductId()%>">
				</button>
				 </form>
                    <div class="col">
                    <form action="Cart" method="post">
                    <input type="hidden" name="productId" value="<%=product.getProductId()%>">
                           <button type="submit" name="remove1" value="remove1" class="cart-button"> <i class="fa fa-minus"></i></button>
			    <span class="quantity-display"><%=productAmount %></span>
			    <button type="submit" name="add1" value="add1" class="cart-button"> <i class="fa fa-plus"></i></button>
                    </div>
                    <div class="col">$ <%= priceTaxed %><button type="submit" name="removeall" value="removeall" class="cart-button"> <i class="fa fa-times"></i></button></div>
               </form>
                </div>
               
                <% } 
                
                }catch(IndexOutOfBoundsException e){ %>
                	  <div class="row">
                      <div class="col"><h4><b>Shopping Cart</b></h4></div>
                  </div>
            <%     }%>
            <form action="Cart" method="post">
            <button type="submit" name="clear" value="clear" class="cart-button clear">Clear Cart</button>
                <div class="back-to-shop"><a href="Products.jsp">&leftarrow;</a><span class="text-muted">Back to shop</span></div>   
                </form>            
            </div>
            <div class="col-md-4 summary">
                <div><h5><b>Summary</b></h5></div>
                <hr>
                <div class="row">
                    <div class="col" style="padding-left:0;">Total Items: <%=amount %></div>
                    <%
                String showTotal = df.format(total_price + shipping_fee);
                    
                    
                    
                    if(showTotal.equals("5")){
                    	showTotal = "0";
                    }
                 //   long SubTotal = Long.parseLong(showTotal);
                %>
                    <div class="col text-right">$<%=showTotal%></div>
                </div>
                <form action="CheckOut" method="post">
                <div class="row">
                <div class="col" style="padding-left:0;">Shipping Fee</div>
                    <div class="col text-right" >$<%=shipping_fee %></div>
                </div>
                <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                
                    <div class="col">TOTAL PRICE</div>
                    
                    <div class="col text-right">$<%=showTotal  %></div>
                </div>
                <input type="hidden" name="subTotal" value="<%=showTotal%>">
                <button name="checkOut" value="checkOut" class="btn">CHECKOUT</button>
                </form> 
            </div>
        </div>
    </div>
</body>
<footer class="footer bg-dark text-white">
    <div class="container d-flex flex-column align-items-center">
        <p class="mb-0">&copy; 2025 Pawfect. All Rights Reserved.</p>
    </div>
</footer>

</html>
