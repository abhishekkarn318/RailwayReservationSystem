<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Railway Reservation System</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js" defer></script>
</head>
<body>
    <!-- Include Header & Navbar -->
    <div id="header-container"></div>
    
    <div class="container">
    <div class="login-container">
        <h2>Admin Login</h2>
        <form id="adminLogin" action="AdminLoginServlet" method="post">
            <label for="email">Email:</label>
            <input type="text" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            
            <span id="error-message" style="color: red;"></span>

            <button type="submit">Login</button>
        </form>
    </div>
    </div>
    
    <div id="footer-container"></div>
</body>
</html>
