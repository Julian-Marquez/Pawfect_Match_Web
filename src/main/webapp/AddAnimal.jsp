<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

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
    <li><a href="AllAnimals.jsp" class="hover:text-gray-300">Adopt</a></li>
    <li><a href="profile.jsp" class="hover:text-gray-300">Profile</a></li>
  </ul>
</nav>

<!-- UI for Product Class Attributes -->
<div class="bg-gradient-to-tr from-fuchsia-300 to-sky-500 min-h-screen flex items-center justify-center">
  <section class="p-6 bg-white rounded shadow-lg max-w-md w-full">
    <h1 class="text-3xl font-bold mb-6 text-gray-900 text-center">Add a Animal</h1>
    <form action="handleAnimals" method="post" enctype="multipart/form-data" class="space-y-4">
      <!-- Product Name -->
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Animal Name</label>
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
        <label for="amount" class="block text-sm font-medium text-gray-700">Breed</label>
        <input type="text" id="amount" name="breed" required
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Price -->
      <div>
        <label for="age" class="block text-sm font-medium text-gray-700">Age</label>
        <input type="number" step="1.0" id="age" name="age" min="0" required 
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <div>
        <label for="date" class="block text-sm font-medium text-gray-700">Date found</label>
        <input type="date"  id="date" name="date" required 
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Product Image -->
      <div>
        <label for="productImage" class="block text-sm font-medium text-gray-700">Animal Image</label>
        <input type="file" id="productImage" name="animalImage" accept="image/*" required
          class="block w-full mt-1 px-3 py-2 border rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500">
      </div>
      
      <!-- Submit Button -->
      <button type="submit" 
        class="w-full py-2 px-4 bg-gradient-to-r from-pink-600 to-red-600 text-white font-bold rounded-md hover:shadow-lg hover:from-pink-500 hover:to-red-500">
        Add Animal
      </button>
    </form>
  </section>
</div>
</body>
</html>
