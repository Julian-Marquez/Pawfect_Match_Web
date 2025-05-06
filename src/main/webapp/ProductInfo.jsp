<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="box.*" %>
    <%@ page import="java.util.Base64" %> <%@ page import="java.lang.StringBuilder" %>
    <%@ page import="java.util.stream.Collectors" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Product Card UI Design</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    

    <!-- Vendor Script -->
    <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script>
  
  <style>
  
  @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,800&display=swap');

body {
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    background: #000;
}

.container {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    width: 900px;
    height: 600px;
    background: #fff;
    margin: 20px;
}

.container .imgBx {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50%;
    height: 100%;
    background: #212121;
    transition: .3s linear;
}

.container .imgBx:before {
    content: 'Nike';
    position: absolute;
    top: 0px;
    left: 24px;
    color: #000;
    opacity: 0.2;
    font-size: 8em;
    font-weight: 800;
}

.container .imgBx img {
    position: relative;
    width: 100%; /* Makes the image responsive to container size */
    left: 0; /* Reset the horizontal position */
    transition: .9s linear;
}


.container .details {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50%;
    height: 100%;
    box-sizing: border-box;
    padding: 40px;
}

.container .details h2{
    margin: 0;
    padding: 0;
    font-size: 2.4em;
    line-height: 1em;
    color: #444;
}

.container .details h2 span {
    font-size: 0.4em;
    text-transform: uppercase;
    letter-spacing: 2px;
    color: #999;
}

.container .details p {
    max-width: 85%;
    margin-left: 15%;
    color: #333;
    font-size: 15px;
    margin-bottom: 36px;
}

.container .details h3 {
    margin: 0;
    padding: 0;
    font-size: 2.5em;
    color: #a2a2a2;
    float: left;
}
.container .details button {
    background: #000;
    color: #fff;
    border: none;
    outline: none;
    padding: 15px 20px;
    margin-top: 5px;
    font-size: 16px;
    letter-spacing: 1px;
    text-transform: uppercase;
    font-weight: 600;
    border-radius: 40px;
    float: right;
}

.product-colors span {
    width: 26px;
    height: 26px;
    top: 7px;
    margin-right: 12px;
    left: 10px;
    border-radius: 50%;
    position: relative;
    cursor: pointer;
    display: inline-block;
}

.black {
    background: #000;
}

.red {
    background: #D5212E;
}

.orange {
    background: #F18557;
}

.product-colors .active:after{
    content: "";
    width: 36px;
    height: 36px;
    border: 2px solid #000;
    position: absolute;
    border-radius: 50%;
    box-sizing: border-box;
    left: -5px;
    top: -5px;
}

/* responsive */
@media (max-width: 1080px) {
    .container {
        height: auto;
    }
    .container .imgBx {
        padding: 40px;
        box-sizing: border-box;
        width: 100% !important;
        height: auto;
        text-align: center;
        overflow: hidden;
    }
    .container .imgBx img {
        left: initial;
        max-width: 100%;
        transform: rotate(0deg);
    }
    .details {
        width: 100% !important;
        height: auto;
        padding: 20px;
    }
    .container .details p {
        margin-left: 0;
        max-width: 100%;
    }
}

footer {
    position: fixed;
    right: 16px;
    bottom: 12px;
}

footer a {
    color: #fff;
    text-decoration: none;
    font-size: 12px;
}
/* ---------- Useful Button styling ---------- */

.mybutton{
  position: relative;
  background-color: black;
  border-radius: 4em;
  font-size: 16px;
  color: white;
  padding: 0.8em 1.8em;
  cursor:pointer;
  user-select:none;
  text-align: center;
  text-decoration: none;
  cursor: pointer;
  transition-duration: 0.4s;
  -webkit-transition-duration: 0.4s; /* Safari */
}

.mybutton:hover {
  transition-duration: 0.1s;
  background-color: #3A3A3A;
}

.mybutton:after {
  content: "";
  display: block;
  position: absolute;
  border-radius: 4em;
  left: 0;
  top:0;
  width: 100%;
  height: 100%;
  opacity: 0;
  transition: all 0.5s;
  box-shadow: 0 0 10px 40px white;
}

.mybutton:active:after {

  box-shadow: 0 0 0 0 yellow;
  position: absolute;
  border-radius: 4em;
  left: 0;
  top:0;
  opacity: 1;
  transition: 0s;
}

.mybutton:active {
  top: 1px;
}

.input {
	
	// needs to be relative so the :focus span is positioned correctly
	position:relative;
	
	// bigger font size for demo purposes
	font-size: 1.5em;
	
	// the border gradient
	background: linear-gradient(21deg, #10abff, #1beabd);
	
	// the width of the input border
	padding: 3px;
	
	// we want inline fields by default
	display: inline-block;
	
	// we want rounded corners no matter the size of the field
	border-radius: 9999em;
	
	// style of the actual input field
	*:not(span) {
		position: relative;
		display: inherit;
		border-radius: inherit;
		margin: 0;
		border: none;
		outline: none;
		padding: 0 .325em;
		z-index: 1; // needs to be above the :focus span
		
		// summon fancy shadow styles when focussed
		&:focus + span {
			opacity: 1;
			transform: scale(1);
		}
	}
	
	// we don't animate box-shadow directly as that can't be done on the GPU, only animate opacity and transform for high performance animations.
	span {
		
		transform: scale(.993, .94); // scale it down just a little bit
		transition: transform .5s, opacity .25s;
		opacity: 0; // is hidden by default
		
		position:absolute;
		z-index: 0; // needs to be below the field (would block input otherwise)
		margin:4px; // a bit bigger than .input padding, this prevents background color pixels shining through
		left:0;
		top:0;
		right:0;
		bottom:0;
		border-radius: inherit;
		pointer-events: none; // this allows the user to click through this element, as the shadow is rather wide it might overlap with other fields and we don't want to block those.
		
		// fancy shadow styles
		box-shadow: inset 0 0 0 3px #fff,
			0 0 0 4px #fff,
			3px -3px 30px #1beabd, 
			-3px 3px 30px #10abff;
	}
	
}

html {
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
	line-height:1.5;
	font-size:1em;
}

body {
	text-align: center;
	display:flex;
	align-items: center;
	justify-content: center;
}
.description {
    min-height: 100px; /* Ensures a minimum height */
    max-height: auto;  /* Allows for dynamic resizing */
}



.input {
	
	// needs to be relative so the :focus span is positioned correctly
	position:relative;
	
	// bigger font size for demo purposes
	font-size: 1.5em;
	
	// the border gradient
	background: linear-gradient(21deg, #10abff, #1beabd);
	
	// the width of the input border
	padding: 3px;
	
	// we want inline fields by default
	display: inline-block;
	
	// we want rounded corners no matter the size of the field
	border-radius: 9999em;
	
	// style of the actual input field
	*:not(span) {
		position: relative;
		display: inherit;
		border-radius: inherit;
		margin: 0;
		border: none;
		outline: none;
		padding: 0 .325em;
		z-index: 1; // needs to be above the :focus span
		
		// summon fancy shadow styles when focussed
		&:focus + span {
			opacity: 1;
			transform: scale(1);
		}
	}
	
	// we don't animate box-shadow directly as that can't be done on the GPU, only animate opacity and transform for high performance animations.
	span {
		
		transform: scale(.993, .94); // scale it down just a little bit
		transition: transform .5s, opacity .25s;
		opacity: 0; // is hidden by default
		
		position:absolute;
		z-index: 0; // needs to be below the field (would block input otherwise)
		margin:4px; // a bit bigger than .input padding, this prevents background color pixels shining through
		left:0;
		top:0;
		right:0;
		bottom:0;
		border-radius: inherit;
		pointer-events: none; // this allows the user to click through this element, as the shadow is rather wide it might overlap with other fields and we don't want to block those.
		
		// fancy shadow styles
		box-shadow: inset 0 0 0 3px #fff,
			0 0 0 4px #fff,
			3px -3px 30px #1beabd, 
			-3px 3px 30px #10abff;
	}
	
}

html {
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
	line-height:1.5;
	font-size:1em;
}

body {
	text-align: center;
	display:flex;
	align-items: center;
	justify-content: center;
}

html, body {
	height:100%;
}

input {
	font-family: inherit;
	line-height:inherit;
	color:#2e3750;
	min-width:12em;
}

::placeholder {
	color:#cbd0d5;
}

html::after {
	content:'';
	background: linear-gradient(21deg, #10abff, #1beabd);
	height:3px;
	width:100%;
	position:absolute;
	left:0;
	top:0;
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
  </style>

</head>


<body>

<%

ServletContext context = request.getServletContext();

Product product = (Product) context.getAttribute("product");



%>

  <div class="container">
    <div class="imgBx">
        <% if (product.getImages() != null && !product.getImages().isEmpty()) { %>
            <div class="custom-carousel">
                <% for (byte[] images : product.getImages()) {
                    String base64Image = Base64.getEncoder().encodeToString(images);
                %>
                    <img src="data:image/jpeg;base64,<%= base64Image %>" class="carousel-image">
                <% } %>
                 <button class="prev-btn" onclick="moveSlide(-1)">
                    <i class="fas fa-chevron-left"></i> <!-- Font Awesome Icon -->
                </button>
                <button class="next-btn" onclick="moveSlide(1)">
                    <i class="fas fa-chevron-right"></i> <!-- Font Awesome Icon -->
                </button>
            </div>
        <% } else { %>
            <p>No images available.</p>
        <% } %>
    </div>
    <div class="details">
        <div class="content">
            <h2 style="font-size: 32px;" ><%= product.getName() %></h2>
            <p class="description"><%= product.getDescription() %></p>
            <form action="handleProducts" method="post">
                <p>
                    <label for="amount">Amount:</label>
                    <input type="number" id="amount" name="amount" min="1" value="1" class="amount-input" style="width: 50px;">
                </p>
                <h3>Price: $<%= product.getPrice() %></h3>
                <button name="addtocart" value="addtocart" class="mybutton">Add to Cart</button>
                <input type="hidden" name="productId" value="<%=product.getProductId()%>">
                <button name="addtocart" class="mybutton">Buy Now</button>
            </form>
            <% 
            try {
                User admin = (User) context.getAttribute("loggedinUser");
                if (admin != null && admin.getEmail().equalsIgnoreCase("marquezjulian09@gmail.com")) { 
            %>
                <form action="handleProducts" method="get">
                    <input name="productId" type="hidden" value="<%=product.getProductId()%>">
                    <button name="edit" value="edit" class="mybutton">Edit Product</button>
                    <button name="delete" value="delete" class="mybutton">Delete Product</button>
                </form>
            <% 
                }
            } catch (Exception e) {
                // Handle exception
            }
            %>
        </div>
    </div>
</div>

<script>
    let currentIndex = 0;
    const images = document.querySelectorAll('.carousel-image');

    function showSlide(index) {
        images.forEach((img, i) => {
            img.style.display = i === index ? 'block' : 'none';
        });
    }

    function moveSlide(step) {
        currentIndex = (currentIndex + step + images.length) % images.length;
        showSlide(currentIndex);
    }

    if (images.length > 0) {
        showSlide(currentIndex);
    }
</script>

    <!-- Footer -->
    <footer>
    </footer>
    
    <style>
    .custom-carousel {
    position: relative;
    width: 100%;
    overflow: hidden;
}
.image-container {
    display: flex;
    transition: transform 0.5s ease-in-out;
}
.carousel-image {
    min-width: 100%;
}
.prev-btn, .next-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    cursor: pointer;
    height: 60px;
    width: 43px;
}
.prev-btn {
    left: 10px;
}
.next-btn {
    right: 10px;
}
    
    </style>


    
    
    <%
    if(product.getImages().size() > 1){
    	
    %>
     <script>
        
        var currentIndex = 0;
        var images = <%= product.getImages().stream().map(image -> "'data:image/jpeg;base64," + Base64.getEncoder().encodeToString(image) + "'").collect(Collectors.toList()) %>;
        var productImage = document.getElementById('product-image');

        function showImage(index) {
            productImage.src = images[index];
        }

        document.getElementById('next-arrow').onclick = function() {
            currentIndex = (currentIndex + 1) % images.length;
            showImage(currentIndex);
        };

        document.getElementById('prev-arrow').onclick = function() {
            currentIndex = (currentIndex - 1 + images.length) % images.length;
            showImage(currentIndex);
        };
    </script>
<%} %>
</body>

</html>