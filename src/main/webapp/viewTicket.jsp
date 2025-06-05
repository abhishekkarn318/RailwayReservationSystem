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
    <title>My Booking - Railway Reservation System</title>
    <script src="js/script.js" defer></script>
    
    <script>
    function loadTrains() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "ViewTrainsServlet", true);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                document.getElementById("trainTableBody").innerHTML = xhr.responseText;

                // Count the number of <tr> rows inside the tbody
                var trainRows = document.querySelectorAll("#trainTableBody tr").length;

                // Update the train count
                document.getElementById("train-count").innerText = "Total Trains: " + trainRows;
            }
        };

        xhr.send();
    }

    // Load trains on page load
    window.onload = loadTrains;

    </script>

        
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
.view-train-container {
	margin: auto;
    width: fit-content;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	color: black;
}

.view-train-container h1 {
	margin-top: 0;
    margin-bottom: 30px;
    color: #333;
    text-align:center;
}


/* Table Styles */
.train-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    margin-bottom: 30px;
}

/* Table Headers */
.train-table th {
    background: #007bff;
    color: white;
    padding: 12px;
    border: 1px solid #ddd;
    
}

/* Table Rows */
.train-table td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: left;
    font-weight: normal;
}

/* Alternate Row Colors */
.train-table tr:nth-child(even) {
    background: #f9f9f9;
}

/* Hover Effect */
.train-table tr:hover {
    background: #f1f1f1;
}

/* Responsive Design */
@media screen and (max-width: 768px) {
    .container {
        width: 95%;
    }

    .train-table th, .train-table td {
        padding: 8px;
    }
}
.train-count {
    margin-top: 15px;
    font-size: 18px;
    text-align: right;
    color: #333;
    font-weight: bold;
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
    <div class="view-train-container">
        <h1>View Train</h1>
    	<table class="train-table">
        <thead>
            <tr>
                <th>Train Number</th>
                <th>Train Name</th>
                <th>Source</th>
                <th>Destination</th>
                <th>Departure</th>
                <th>Arrival</th>
            </tr>
        </thead>
        <tbody id="trainTableBody">
            <!-- Data will be loaded here -->
        </tbody>
    </table>
    
   <div id="train-count" class="train-count">Total Trains: 0</div>
   
	</div>
	</div>
</div>


</body>
</html>
