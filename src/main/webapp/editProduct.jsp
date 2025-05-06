<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %><%@ page import="box.*" %>

<!doctype html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
<!-- Original Navigation Bar -->
<nav class="bg-gray-800 p-4 text-white flex justify-between items-center">
  <div class="flex items-center">
    <a href="index.jsp" class="text-2xl font-bold">Pawfect</a>
  </div>
  <ul class="flex space-x-6">
    <li><a href="products.jsp" class="hover:text-gray-300">Products</a></li>
    <li><a href="categories.jsp" class="hover:text-gray-300">Categories</a></li>
    <li><a href="profile.jsp" class="hover:text-gray-300">Profile</a></li>
    <li><a href="logout.jsp" class="hover:text-gray-300">Logout</a></li>
  </ul>
</nav>

<%
ServletContext context = request.getServletContext();

Product product = (Product) context.getAttribute("product");




%>

<!-- UI for Product Class Attributes -->
<div class="bg-gradient-to-tr from-fuchsia-300 to-sky-500 min-h-screen flex items-center justify-center">
  <section class="p-6 bg-white rounded shadow-lg max-w-md w-full">
    <h1 class="text-3xl font-bold mb-6 text-gray-900 text-center">Editing "<%=product.getName() %>"</h1>
    <form action="EditProduct" method="POST" enctype="multipart/form-data" class="space-y-4">
      <!-- Product Name -->
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Product Name</label>
        <input type="text" id="name" name="name" placeholder="<%=product.getName() %>"
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Description -->
      <div>
        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
        <textarea id="description" name="description" rows="4" placeholder="<%=product.getDescription() %>"
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500"></textarea>
      </div>
      
      <!-- Amount -->
      <div>
        <label for="amount" class="block text-sm font-medium text-gray-700">Amount</label>
        <input type="number" id="amount" name="amount" placeholder="<%=product.getAmount() %>"
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Price -->
      <div>
        <label for="price" class="block text-sm font-medium text-gray-700">Price</label>
        <input type="number" step="0.01" id="price" name="price" placeholder="<%=product.getPrice() %>"
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Product Image -->
      <div>
        <label for="productImage" class="block text-sm font-medium text-gray-700">Change Cover Image</label>
        <input type="file" id="productImage" name="productImage" accept="image/*" 
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <div>
        <label for="productImage" class="block text-sm font-medium text-gray-700">Add Image</label>
        <input type="file" id="productImage2" name="productImage2" accept="image/*" 
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Submit Button -->
      <button type="submit" 
        class="w-full py-2 px-4 bg-gradient-to-r from-pink-600 to-red-600 text-white font-bold rounded-md hover:shadow-lg hover:from-pink-500 hover:to-red-500">
        Confirm Edit
      </button>
    </form>
  </section>
</div>
</body>
</html>
