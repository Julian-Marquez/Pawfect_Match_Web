<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="box.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>

<%
    ServletContext context = getServletContext();
    User user = (User) context.getAttribute("loggedinUser");
    List<Card> userPayments = user != null ? user.getAllPayments() : new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Methods</title>

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/responsive.css" rel="stylesheet" />

  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet" />
  <link href="css/gradient-btn.css" rel="stylesheet" />
      
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="css/responsive.css" rel="stylesheet" />
   <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
  
  <link href="https://fonts.googleapis.com/css?family=Open+Sans|Poppins:400,700&display=swap" rel="stylesheet">
    <link href="css/UserPayments.css" rel="stylesheet" />
    <style>
        @charset "UTF-8";
   

        body {
         margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: consolas;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: #1d061a;
        }
      
/* Center the Add Payment button */
.add-payment-container {
    text-align: center;
    margin-bottom: 20px;
}
.add-button-container {
    display: flex;
    justify-content: center; 
    margin-bottom: 0px; 
    margin-left: 158px;
    width: 13%; /* Ensure full width for proper centering */
}

.button-group {
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
}

/* Adjust the main container layout */
.container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); /* Responsive grid */
    gap: 20px;
    max-width: 1200px; /* Prevents excessive stretching */
    margin: 0 auto; /* Centers the content */
}

/* Adjust individual card size */
.container .box {
    width: 350px; /* Slightly larger for better readability */
    height: 420px;
    margin: 20px;
}


        .container .box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50px;
            width: 50%;
            height: 100%;
            background: #fff;
            border-radius: 8px;
            transform: skewX(15deg);
            transition: 0.5s;
        }

        .container .box::after {
            content: '';
            position: absolute;
            top: 0;
            left: 50px;
            width: 50%;
            height: 100%;
            background: #fff;
            border-radius: 8px;
            transform: skewX(15deg);
            transition: 0.5s;
            filter: blur(30px);
        }

        .container .box:hover:before,
        .container .box:hover:after {
            transform: skewX(0deg);
            left: 20px;
            width: calc(100% - 90px);
        }

        .container .box:nth-child(1):before,
        .container .box:nth-child(1):after {
            background: linear-gradient(315deg, #ffbc00, #ff0058);
        }

        .container .box span {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 5;
            pointer-events: none;
        }

        .container .box .content {
            position: relative;
            left: 0;
            padding: 20px 40px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            z-index: 1;
            color: #fff;
        }

        .container .box .content h2 {
            font-size: 2em;
            color: #fff;
            margin-bottom: 10px;
        }

        .card {
            width: 300px;
            height: 180px;
            background-color: #333;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-top {
            display: flex;
            align-items: center;
        }

        .card-top img {
            margin-right: 10px;
        }

        .card-number,
        .card-holder,
        .expiry-date {
            font-size: 14px;
            color: #fff;
            margin-bottom: 5px;
        }
        
        .add-payment-container {
    text-align: center;
    margin-bottom: 20px;
}
        

.cool-button {
    display: inline-block;
    padding: 12px 25px;
    font-size: 16px;
    color: white;
    background: linear-gradient(135deg, #ff7eb3, #ff758c);
    border: none;
    border-radius: 50px;
    cursor: pointer;
    text-transform: uppercase;
    font-weight: bold;
    letter-spacing: 1.5px;
    position: relative; /* Necessary for ::after positioning */
    z-index: 1; /* Keeps the button above the pseudo-element */
    box-shadow: 0 4px 10px rgba(255, 118, 165, 0.4);
    transition: all 0.3s ease;
    overflow: hidden; /* Prevents ::after glow from spilling out */
}

.cool-button:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 15px rgba(255, 118, 165, 0.6);
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
}

.cool-button:active {
    transform: translateY(2px);
    box-shadow: 0 3px 8px rgba(255, 118, 165, 0.4);
}

/* Glowing Animation */
.cool-button::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    border-radius: 50px;
    background: linear-gradient(135deg, rgba(255, 118, 165, 0.5), rgba(255, 126, 179, 0.5));
    filter: blur(15px);
    opacity: 0;
    z-index: -1; /* Ensures the glow stays behind the button */
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.cool-button:hover::after {
    opacity: 1;
    transform: scale(1.2); /* Subtle expansion for dynamic glow */
}
</style>


</head>
   
<body>


    <div class="add-button-container">
        <a href="AddPayment.jsp" class="cool-button">Add Payment</a>
    </div>

    <div class="container">
        <% for (Card payment : userPayments) { 
            try {
                String number = payment.getCardNumber();
                String name = payment.getCardHolderName();
                LocalDate expDate = payment.getExpiry();
                String expiry = expDate.getMonthValue() + "/" + expDate.getYear();
                String cardType = payment.getCardType();
                String fullNumber = number.replaceAll(".{4}(?!$)", "$0 ");
                String imgPath = "images/visa.png";
                if(cardType.equalsIgnoreCase("mastercard")){
                    imgPath = "images/MasterCard.png";
                } else if(cardType.equalsIgnoreCase("rupay")){
                    imgPath = "images/RuPay.png";
                }
        %>
        <div class="box">
            <div class="content">
                <div class="card">
                    <div class="card-top">
                        <img src="<%= imgPath %>" alt="Card Logo">
                        <img src="images/chip.png" alt="Chip" style="margin-left: auto;">
                    </div>
                    <div class="card-number"><p><%= fullNumber %></p></div>
                    <div class="card-holder"><p><%= name %></p></div>
                    <div class="expiry-date"><p>Expires: <%= expiry %></p></div>

                    <!-- Button Group -->
                    <div class="button-group">
                        <form action="handleCard" method="post">
                            <input type="hidden" name="cardNumber" value="<%=number%>">
                            <button type="submit" name="action" value="remove" class="cool-button">Remove</button>
                        </form>

                        <form action="handleCard" method="get">
                            <input type="hidden" name="cardNumber" value="<%=number%>">
                            <button type="submit" name="action" value="change" class="cool-button">Set Payment</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% 
            } catch (Exception e) {
                System.err.println("Error processing payment: " + e.getMessage());
            }
        } %>
    </div>
</body>




</html>
