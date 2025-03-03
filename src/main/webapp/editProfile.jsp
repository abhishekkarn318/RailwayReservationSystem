<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String adminName = (sessionObj != null) ? (String) sessionObj.getAttribute("fullname") : null;
    String adminEmail = "";
    String adminPhone = "";
    String adminPassword = "";

    if (sessionObj == null || adminName == null) {
%>
    <script>
        alert("Session expired! Please log in again.");
        window.location.href = "adminLogin.jsp";
    </script>
<%
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");
        PreparedStatement ps = conn.prepareStatement("SELECT email, phone, password FROM admin WHERE fullname=?");
        ps.setString(1, adminName);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            adminEmail = rs.getString("email");
            adminPhone = rs.getString("phone");
            adminPassword = rs.getString("password");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
    <script>alert("Profile updated successfully!");</script>
<% } else if ("error".equals(status)) { %>
    <script>alert("Error updating profile. Please try again!");</script>
<% } %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Railway Reservation System</title>
    <script src="js/script.js" defer></script>    
    <style>
    	html, body {
    margin: 0; /* Remove any default margins */
    padding: 0; /* Remove any default padding */
    height: 100%; /* Set the body height to the viewport height */  
    background-image: url('images/background.jpg'); /* Path to your background image */
    background-size: cover; /* Scale the image proportionally to cover the entire area */
    background-repeat: no-repeat; /* Prevent image repetition */
    background-position: center; /* Center the image */
    overflow-y: auto; /* Enables vertical scrolling */
    overflow-x: hidden; /* Hides horizontal scrolling */
    scroll-behavior: smooth; /* Smooth scrolling */
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* Full height of the viewport */
    
    /* Header Styling */
.header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	position: sticky;
	background: rgba(0, 0, 0, 0.85); /* Adjust transparency */
    color: white; /* White text */
    text-align: center;
    padding: 10px 10px; /* Vertical padding */
    min-height: 150px;
    width: 100%;
    font-family: Arial, sans-serif;
    border-bottom: 5px solid #ffcc00;
}


.logo img{
	margin-left: 50px;
	width: 150px;
	height:auto;
}

.title {
    flex-grow: 1; /* Ensures it takes available space */
    text-align: center; /* Centers text */
}

.header h1 {
    margin: 0;
    font-size: 28px;
}

.header p {
    margin: 5px 0;
    font-size: 16px;
}

.separator {
    width: 100%;
    position: sticky;
    top: 170px;
    height: 5px; /* Adjust thickness */
    background: linear-gradient(to right, #ffcc00, #ff9900); /* Gradient effect */
    border: none;
    margin: 0;
}

.next-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	position: sticky;
	background: rgba(0, 0, 0, 0.85); /* Adjust transparency */
    color: white; /* White text */
    text-align: center;
    min-height: 40px;
    width: 100%;
    font-size: 25px;
    font-weight: bold;
    border-bottom: 5px solid #ffcc00;
}

.panel{
	width:280px;	
	border-right: 5px solid #ffcc00;
}
.msg {
    flex-grow: 1; /* Ensures it takes available space */
    text-align: center; /* Centers text */
    padding-left: 50px;

}
.panel h3{
    margin-top: 10px;
	margin-bottom: 10px;
}
.msg h3{
    margin-top: 0;
	margin-bottom: 0;
}

.cnt{
	display: flex;
	position: sticky;
    color: white; /* White text */
    text-align: center;
    width: 100%;
    height: 100%;
    font-size: 20px;
    font-weight: bold;
}

.sidebar{
	width: 280px;
    color: #fff;
    position: sticky;  /* Keep it fixed */
    background: rgba(0, 0, 0, 0.85); /* Adjust transparency */
    border-right: 5px solid #ffcc00; /* Add an underline separator */
    display: flex;
    flex-direction: column;
    justify-content: center;
}
.sidebar ul {
    list-style-type: none;
    padding: 0;
}
.sidebar ul li {
    padding: 15px;
    margin-bottom: inherit;
    text-align: center;
}

.sidebar ul li a {
	font-size: 25px;
    color: #fff;
    text-decoration: none;
    display: block;
}

.sidebar ul li a:hover {
    color: #ffcc00;
}

.upper-container{
	flex-grow: 1;
	margin-top: 30px;
}

.edit-profile-container {
	margin: auto;
    width: 30%;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	color: black;
	text-align: left;
}

.edit-profile-container h1 {
	margin-top: 0;
    margin-bottom: 30px;
    color: #333;
    text-align:center;
}

.edit-profile-container label {
    display: block;
    margin: 10px 0 5px;
    font-weight: bold;
    text-align: left;
    
}

.edit-profile-container input {
    width: 95%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
	margin-bottom: 10px;

}

.edit-profile-container button {
    display: block;
    width: 50%;
    margin: 20px auto; /* Centers the button */
    padding: 12px;
    font-size: 18px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.edit-profile-container button:hover {
    background-color: #0056b3;
}

.form-row {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px; /* Adjust spacing between fields */
    padding-bottom: 30px;

}

.form-group {
    flex: 1; /* Ensures both fields take equal width */
    display: flex;
    flex-direction: column;
    
}

.form-control {
    width: 100%; /* Ensures full width inside the form-group */
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}


input[type="time"] {
    background: #fff;
    min-width: 150px;
}

input[type="time"]:invalid:before {
    content: 'HH:MM AM/PM';
    color: #9d9d9d;
    position: absolute;
    background: #fff;
}

input[type="time"]:focus:before {
    width: 0;
    content: '';
}

    </style>
    
</head>
<body>
<header class="header">
	<div class="logo">
		<img src = "images/logo.png" alt="Railway Logo">
	</div>
	<div class="title">
        <h1>Railway Reservation System</h1>
        <p>Your trusted railway booking platform</p>
    </div>
</header>



<div class="next-header">
<div class="panel">
<h3>Admin Panel</h3>
</div>
<div class="msg">
<h3>You're logged in as <%= adminName %> !</h3>
</div>
</div>


<div class="cnt">
    <div class="sidebar">   
        <ul>
            <li><a href="adminDashboard.jsp">Dashboard</a></li>
            <li><a href="addTrain.jsp">Add Trains</a></li>
            <li><a href="updateTrain.jsp">Update Trains</a></li>
            <li><a href="removeTrain.jsp">Remove Trains</a></li>
            <li><a href="viewTrain.jsp">View Trains</a></li>
            <li><a href="contactMessages.jsp">Messages</a></li>
            <li><a href="editProfile.jsp">Profile Edit</a></li>
            <li><a href="AdminLogoutServlet">Logout</a></li>
        </ul>
    </div>
    
<div class="upper-container">
    	<div class="edit-profile-container">
        		<h1>Edit Profile</h1>
    	
        <form action="UpdateProfileServlet" method="post">
            <label>Full Name:</label>
            <input type="text" name="fullname" value="<%= adminName %>" readonly>

            <label>Email:</label>
            <input type="email" name="email" value="<%= adminEmail %>" required>

            <label>Phone:</label>
            <input type="text" name="phone" value="<%= adminPhone %>" required>
            
            <label>Password:</label>
            <input type="password" name="password" value="<%= adminPassword %>" required>

            <button type="submit">Update Profile</button>
        </form>
    	</div>
    
    </div>

</div>
</body>
</html>
