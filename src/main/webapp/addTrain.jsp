<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>

<%
    HttpSession sessionObj = request.getSession(false); // Retrieve existing session without creating a new one
    String adminName = (sessionObj != null) ? (String) sessionObj.getAttribute("fullname") : null;

    if (sessionObj == null || adminName == null) {
%>
    <script>
        alert("Session Timed Out! Please Re-login.");
        window.location.href = "adminLogin.jsp";
    </script>
<%
        return; // Stop further execution
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Train - Railway Reservation System</title>
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
.add-train-container {
	margin: auto;
    width: max-content;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	color: black;
}

.add-train-container h1 {
	margin-top: 0;
    margin-bottom: 30px;
    color: #333;
    text-align:center;
}

.add-train-container label {
    display: block;
    margin: 10px 0 5px;
    font-weight: bold;
    text-align: left;
    
}

.add-train-container input {
    width: 95%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;


}

.add-train-container button {
    display: block;
    width: 50%;
    margin: 10px auto 0 auto; /* Centers the button */
    padding: 12px;
    font-size: 18px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.add-train-container button:hover {
    background-color: #0056b3;
}

.form-row {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px; /* Adjust spacing between fields */
    padding-bottom: 20px;

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
    	<div class="add-train-container">
        		<h1>Add Train</h1>
    	
        <form action="AddTrainServlet" method="post">
        <div class="form-row">
        	<div class="form-group">
            	<label for="trainNumber">Train Number:</label>
           		<input type="number" id="trainNumber" name="trainNumber" placeholder="Enter train number" required>
            </div>
			<div class="form-group">
				<label for="trainSource">Source:</label>
            	<input type="text" id="trainSource" name="trainSource" placeholder="Enter source station name" required>
           	</div>
           	<div class="form-group">
				<label for="departureTime">Departure Time:</label>
            	<input type="time" id="departureTime" name="departureTime" placeholder="Enter departure time" required>
           	</div>
           	<div class="form-group">
				<label for="sleeperSeats">Sleeper Seats:</label>
            	<input type="number" id="sleeperSeats" name="sleeperSeats" placeholder="Enter total seats in sleeper" required>
           	</div>
		</div>	
		
		<div class="form-row">
        	<div class="form-group">
            	<label for="trainName">Train Name:</label>
            	<input type="text" id="trainName" name="trainName" placeholder="Enter train name" required>
            </div>
			<div class="form-group">
            	<label for="trainDestination">Destination:</label>
            	<input type="text" id="trainDestination" name="trainDestination" placeholder="Enter destination station name" required>
            </div>
            <div class="form-group">
				<label for="arrivalTime">Arrival Time:</label>
            	<input type="time" id="arrivalTime" name="arrivalTime" placeholder="Enter arrival time" required>
           	</div>
           	<div class="form-group">
				<label for="sleeperAvailableSeats">Sleeper Available Seats:</label>
            	<input type="number" id="sleeperAvailableSeats" name="sleeperAvailableSeats" placeholder="Enter available seats in sleeper" required>
           	</div>
		</div>
		
		<div class="form-row">
        	<div class="form-group">
            	<label for="thirdACSeats">3AC Seats:</label>
            	<input type="number" id="thirdACSeats" name="thirdACSeats" placeholder="Enter total seats in 3AC" required>
            </div>
			<div class="form-group">
            	<label for="secondACSeats">2AC Seats:</label>
            	<input type="number" id="secondACSeats" name="secondACSeats" placeholder="Enter total seats in 2AC" required>
            </div>
            <div class="form-group">
            	<label for="firstACSeats">1AC Seats:</label>
            	<input type="number" id="firstACSeats" name="firstACSeats" placeholder="Enter total seats in 1AC" required>
            </div>
            <div class="form-group">
            	<label for="sleeperPrice">Sleeper Price:</label>
            	<input type="number" id="sleeperPrice" name="sleeperPrice" placeholder="Enter price for sleeper" required>
            </div>
		</div>
		<div class="form-row">
        	<div class="form-group">
            	<label for="thirdACAvailableSeats">3AC Available Seats:</label>
            	<input type="number" id="thirdACAvailableSeats" name="thirdACAvailableSeats" placeholder="Enter available seats in 3AC" required>
            </div>
			<div class="form-group">
            	<label for="secondACAvailableSeats">2AC Available Seats:</label>
            	<input type="number" id="secondACAvailableSeats" name="secondACAvailableSeats" placeholder="Enter available seats in 2AC" required>
            </div>
            <div class="form-group">
            	<label for="firstACAvailableSeats">1AC Available Seats:</label>
            	<input type="number" id="firstACAvailableSeats" name="firstACAvailableSeats" placeholder="Enter available seats in 1AC" required>
            </div>
            <div class="form-group">
            	<label for="thirdACPrice">3AC Price:</label>
            	<input type="number" id="thirdACPrice" name="thirdACPrice" placeholder="Enter price for 3AC" required>
            </div>
		</div>
		<div class="form-row">
        	<div class="form-group">
            	<label for="secondACPrice">2AC Price:</label>
            	<input type="number" id="secondACPrice" name="secondACPrice" placeholder="Enter price for 2AC" required>
            </div>
			<div class="form-group">
            	<label for="firstACPrice">1AC Price:</label>
            	<input type="number" id="firstACPrice" name="firstACPrice" placeholder="Enter price for 1AC" required>
            </div>
            <div class="form-group">
            	
            </div>
            <div class="form-group">
            	
            </div>
		</div>
		
		<div id="message" class="message"></div>
		
            <button type="submit">Add Train</button>
        </form>
    	</div>
    
    </div>

</div>
</body>
</html>
