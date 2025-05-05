<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="css/Profile.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/nav.css"/>
</head>
<body>
<!-- Original Navigation Bar -->
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



<!-- UI for Product Class Attributes -->
<div class="bg-gradient-to-tr from-fuchsia-300 to-sky-500 min-h-screen flex items-center justify-center">
  <section class="p-6 bg-white rounded shadow-lg max-w-md w-full">
    <h1 class="text-3xl font-bold mb-6 text-gray-900 text-center">Add a Product</h1>
    <form action="AddProduct" method="POST" enctype="multipart/form-data" class="space-y-4">
      <!-- Product Name -->
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Product Name</label>
        <input type="text" id="name" name="name" required
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Description -->
      <div>
        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
        <textarea id="description" name="description" rows="4" required
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500"></textarea>
      </div>
      
      <!-- Amount -->
      <div>
        <label for="amount" class="block text-sm font-medium text-gray-700">Amount</label>
        <input type="number" id="amount" name="amount" required
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Price -->
      <div>
        <label for="price" class="block text-sm font-medium text-gray-700">Price</label>
        <input type="number" step="0.01" id="price" name="price" required
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Product Image -->
      <div>
        <label for="productImage" class="block text-sm font-medium text-gray-700">Product Image</label>
       	<a class="button-29"><input type="file" id="productImage" name="productImage" accept="image/*" required 
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500"></a>
      </div>
      
      <!-- Submit Button -->
      <button type="submit" 
        class="w-full py-2 px-4 bg-gradient-to-r from-pink-600 to-red-600 text-white font-bold rounded-md hover:shadow-lg hover:from-pink-500 hover:to-red-500">
        Add Product
      </button>
    </form>
  </section>
</div>
</body>
</html>
