<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("name") : null;
    String userID = (sessionObj != null) ? (String) sessionObj.getAttribute("id") : null;
    if (sessionObj == null || userName == null) {
%>
    <script>
        alert("Session expired! Please log in again.");
        window.location.href = "login.html";
    </script>
<%
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Trains - Railway Reservation System</title>
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
    padding: 13px;
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

.contentcontainer {
	margin: auto;
    width: fit-content;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	color: black;
	text-align: left;
}

.contentcontainer h1 {
	margin-top: 0;
    margin-bottom: 30px;
    color: #333;
    text-align:center;
}

.contentcontainer label {
    display: block;
    margin: 10px 0 5px;
    font-weight: bold;
    text-align: left;
    
}

.contentcontainer input {
    width: 95%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
	margin-bottom: 10px;

}

.form-row {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px; /* Adjust spacing between fields */

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

.contentcontainer button {
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

.contentcontainer button:hover {
    background-color: #0056b3;
}

select {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
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
<h3>User Panel</h3>
</div>
<div class="msg">
<h3>You're logged in as <%= userName %> !</h3>
</div>
</div>


<div class="cnt">
    <div class="sidebar">   
        <ul>
            <li><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="availabilitySearch.jsp">Seat Availability</a></li>
           <li><a href="checkPrice.jsp">Check Price</a></li>
            <li><a href="searchTrain.jsp">Book Ticket</a></li>
            <li><a href="myBookingHistory.jsp">Booking History</a></li>
            <li><a href="userViewProfile.jsp">Profile</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </div>
    
<div class="upper-container">
    <div class="contentcontainer">
        <h1>Search Your Train</h1>
    	<form action="SearchTrainServlet" method="post">
    <label>From Station:</label>
    <input type="text" id="fromStation" name="fromStation" required>

    <label>To Station:</label>
    <input type="text" id ="toStation" name="toStation" required>

    <label>Journey Date:</label>
    <input type="date" id = "journeyDate" name="journeyDate" required>

    <button type="submit">Search</button>
</form>
    	
       
    </div>
</div>
</div>
</body>
</html>
