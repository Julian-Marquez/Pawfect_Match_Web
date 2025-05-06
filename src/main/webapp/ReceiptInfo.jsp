<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %> <%@ page import="box.*" %> <%@ page import="java.text.*" %>
    <%
    ServletContext context =  getServletContext();
    User user = (User) context.getAttribute("loggedinUser");
    Receipt receipt = (Receipt) context.getAttribute("receipt");
    List<Product> products = new ArrayList<>();
	Card payment = receipt.getPaymentMethod();
	double subTotal = receipt.getSubTotal();
	double test = 0;
   // int amount = 0;
    int shipping_fee = 5;
    double tax = 0.07;
    double caculateTax = 0;
    String taxTotal = "";
    try{
    	products = receipt.getProducts();
    	
    }catch(IndexOutOfBoundsException e){
    	
    }catch(NullPointerException e){
    	
    }
    
    %>
<!DOCTYPE html>
<html lang="en">
 <head>
  <meta charset="UTF-8" />
  <meta name="viewport" co`ntent="width=device-width, initial-scale=1.0" />
  <title>Receipt Information</title>
  <link rel="stylesheet" href="css/ReceiptInfo.css" />
  <link
   rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"
   integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog=="
   crossorigin="anonymous"
  />
  <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js'></script>
  <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css'>
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
 </head>
 <nav class="custom-navbar">
    <div class="navbar-container">
        <a class="navbar-brand" href="index.jsp">
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

  
   .icon {
        margin-right: 8px;
    }
     
/* Navbar Container */
.custom-navbar {
    background-color: #28242c; /* Navy blue */
    color: #ffffff;
    padding: 10px 0; /* Padding for top and bottom */
    font-family: Arial, sans-serif;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    width: 100%; /* Full width of the page */
    position: relative;
    z-index: 10;
}

.navbar-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px; /* Centers the content */
    margin: 0 auto;
    padding: 0 20px; /* Horizontal padding inside the container */
    width: 100%; /* Ensures the navbar spans the page width */
}

/* Brand Logo */
.navbar-logo {
    height: 40px;
    width: auto;
    margin-right: 10px;
    border-radius: 50%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.navbar-brand {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: #ffffff;
    font-size: 1.5rem;
    font-weight: bold;
}

/* Navbar Menu */
.navbar-menu {
    display: flex;
    flex-direction: row;
}

.navbar-links {
    list-style: none;
    display: flex;
    gap: 15px;
    margin: 0;
    padding: 0;
}

/* Navbar Links */
.navbar-link {
    text-decoration: none;
    color: #ffffff;
    font-size: 1rem;
    transition: color 0.3s ease, background-color 0.3s ease;
    padding: 5px 10px;
    border-radius: 4px;
}

.navbar-link:hover {
    background-color: #ffffff;
    color: #004080;
}

/* Button Style */
.navbar-btn {
    background-color: #ffffff;
    color: #004080;
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 0.9rem;
    font-weight: bold;
    text-decoration: none;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.navbar-btn:hover {
    background-color: #004080;
    color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

/* Mobile View */
.navbar-toggler {
    display: none;
    background-color: #004080;
    color: #ffffff;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
}

/* Responsive Design */
@media (max-width: 768px) {
    .navbar-menu {
        display: none;
        flex-direction: column;
        position: absolute;
        top: 100%;
        right: 0;
        background-color: #004080;
        width: 100%;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .navbar-menu.active {
        display: flex;
    }

    .navbar-toggler {
        display: block;
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
        /* Cart Icon */
#cart-icon {
    font-size: 1.5rem; /* Adjust icon size */
    color: #ffffff; /* White color to match the navbar */
    transition: color 0.3s ease, transform 0.3s ease; /* Smooth transition */
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 5px 10px; /* Padding to give space around the icon */
    border-radius: 4px;
}

#cart-icon:hover {
    color: #004080; /* Change color when hovered */
    background-color: #ffffff; /* Add background on hover */
    transform: scale(1.1); /* Slightly enlarge the icon for a hover effect */
}

/* Ensure cart icon stays aligned with other navbar items */
.navbar-links {
    display: flex;
    gap: 15px;
    margin: 0;
    padding: 0;
    align-items: center; /* Ensures vertical centering */
}
        


</style>
 <body>
<form action="handleProducts" method="post">

<div class="event-schedule-area-two bg-color pad100">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title text-center">
                    <div class="title-text">
                        <h2><%=receipt.getName() %></h2>
                    </div>
                   
                </div>
            </div>
            <!-- /.col end-->
        </div>
        <!-- row end-->
        <div class="row">
            <div class="col-lg-12">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade active show" id="home" role="tabpanel">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th class="text-center" scope="col">Price</th>
                                        <th scope="col">Image</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Amount</th>
                                        <th class="text-center" scope="col">Buy Again</th>
                                    </tr>
                                </thead>
                         
                                <tbody>
                                       <%
                                       DecimalFormat df = new DecimalFormat("#,###.##");
                                       String endingNum = payment.getCardNumber().substring(12,16);
                                for(Product product : products){
                                	String productname = product.getName();
                                	int amount = product.getAmount();
                                	double price = product.getPrice();
                                	byte[] imgData = product.getImages().get(0);
                                	String img = Base64.getEncoder().encodeToString(imgData);
                                	double taxed = (price * tax);
                                    
                                    String taxformat = df.format(taxed);
                                    
                                    double priceTaxed = Double.parseDouble(taxformat);
                                     test += Double.parseDouble(df.format(price * amount));
                                    caculateTax += priceTaxed;
                                
                                %>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>$<%=price%></span>
                                               
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="data:image/jpeg;base64,<%=img%>"  alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#"><%=productname%></a></h3>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span><%=amount%></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                            <input name="view" value="view" type="hidden"></input>
                                                <button name="productId" value="<%=product.getProductId()%>"class="btn btn-primary" >Buy More</button>
                                            </div>
                                        </td>
                                    </tr>
                                           <%
                                }
                                
                                %>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>$5</span>
                                               
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="images/shipping.png"  alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Shipping Fee</a></h3>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                            
                                            </div>
                                        </td>
                                    </tr>
                                      <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                            <%
                                            taxTotal = df.format(caculateTax); %>
                                                <span>$<%=taxTotal%></span>
                                               
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="images/tax.png"  alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Tax</a></h3>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span></span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                            
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Date</th>
                                        <th scope="col">Speakers</th>
                                        <th scope="col">Session</th>
                                        <th scope="col">Venue</th>
                                        <th scope="col">Venue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Toni Duggan</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Harman Kardon</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box border-bottom-0">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Billal Hossain</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Date</th>
                                        <th scope="col">Speakers</th>
                                        <th scope="col">Session</th>
                                        <th scope="col">Venue</th>
                                        <th scope="col">Venue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Harman Kardon</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Billal Hossain</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box border-bottom-0">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Toni Duggan</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="sunday" role="tabpanel" aria-labelledby="sunday-tab">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Date</th>
                                        <th scope="col">Speakers</th>
                                        <th scope="col">Session</th>
                                        <th scope="col">Venue</th>
                                        <th scope="col">Venue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Toni Duggan</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Harman Kardon</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box border-bottom-0">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Billal Hossain</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="monday" role="tabpanel" aria-labelledby="monday-tab">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Date</th>
                                        <th scope="col">Speakers</th>
                                        <th scope="col">Session</th>
                                        <th scope="col">Venue</th>
                                        <th scope="col">Venue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>16</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Harman Kardon</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>18</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Toni Duggan</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="inner-box border-bottom-0">
                                        <th scope="row">
                                            <div class="event-date">
                                                <span>20</span>
                                                <p>Novembar</p>
                                            </div>
                                        </th>
                                        <td>
                                            <div class="event-img">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="" />
                                            </div>
                                        </td>
                                        <td>
                                            <div class="event-wrap">
                                                <h3><a href="#">Billal Hossain</a></h3>
                                                <div class="meta">
                                                    <div class="organizers">
                                                        <a href="#">Aslan Lingker</a>
                                                    </div>
                                                    <div class="categories">
                                                        <a href="#">Inspire</a>
                                                    </div>
                                                    <div class="time">
                                                        <span>05:35 AM - 08:00 AM 2h 25'</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="r-no">
                                                <span>Room B3</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="primary-btn">
                                                <a class="btn btn-primary" href="#">Read More</a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="primary-btn text-center">
                    <h2  class="btn btn-primary">Payment Date: <%=receipt.getDateBought()%></h2>
                </div>
                <div class="primary-btn text-center">
                    <a href="UserPayments.jsp"  class="btn btn-primary">Paid With Card Number Ending In: <%=endingNum %></a>
                    <a href="UserPayments.jsp"  class="btn btn-primary">SubTotal: $<%=subTotal %></a>
                </div>
            </div>
            <!-- /col end-->
        </div>
        <!-- /row end-->
    </div>
</div>
</form>
 </body>
  <footer class="footer bg-dark text-white">
    <div class="container-fluid"> <!-- Use container-fluid here -->
        <p class="text-center mb-0">&copy; 2025 Pawfect. All Rights Reserved.</p>
    </div>
</footer>
</html>
