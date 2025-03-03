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
    <title>Messages - Railway Reservation System</title>
    <script src="js/script.js" defer></script>
    
    <script>
        function loadMessages(status = "") {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "ContactMessagesServlet?status=" + status, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    document.getElementById("messagesTableBody").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        function updateStatus(messageId, newStatus) {
            fetch('UpdateMessageStatusServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'id=' + messageId + '&status=' + newStatus
            })
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    location.reload(); // Reload page to reflect changes
                } else {
                    alert("Error updating status!");
                }
            })
            .catch(error => console.error('Error:', error));
        }
        
        function searchMessages() {
            let searchQuery = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("#messagesTableBody tr");

            rows.forEach(row => {
                let messageText = row.innerText.toLowerCase();
                row.style.display = messageText.includes(searchQuery) ? "" : "none";
            });
        }



        window.onload = function () {
            loadMessages();
        };
        
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
	margin-bottom: 30px;
	width: min-content;
}
.view-messages-container {
	margin: auto;
    width: 85%;
    padding: 30px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	color: black;
}

.view-messages-container h1 {
	margin-top: 0;
    margin-bottom: 30px;
    color: #333;
    text-align:center;
}

.filter-buttons {
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
}

button {
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    cursor: pointer;
    margin: 5px;
    border-radius: 5px;
    transition: 0.3s ease-in-out;
}

button:hover {
    opacity: 0.8;
}


/* General Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
}

th {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}

td {
    background-color: #f8f9fa;
}

/* Status Styling */
.status-solved {
    color: green;
    font-weight: bold;
}

.status-unsolved {
    color: red;
    font-weight: bold;
}

/* Buttons */
.action-button {
    padding: 8px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s ease-in-out;
}

.all-btn {
    background-color: #007bff;
    color: white;
}

.solve-btn {
    background-color: #28a745;
    color: white;
}

.unsolve-btn {
    background-color: #dc3545;
    color: white;
}

.action-button:hover {
    opacity: 0.8;
}

#searchInput {
    padding: 8px;
    font-size: 16px;
    margin: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 300px;
    text-align: center;
}

.butt{
	flex-grow: 1;
	display: flex;
	justify-content: start;
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
    <div class="view-messages-container">
        <h1>View Messages</h1>
    	
<div class="filter-buttons">
	<div class="butt">
        <button class='action-button all-btn' onclick="loadMessages('')">Show All</button>
        <button class='action-button solve-btn' onclick="loadMessages('solved')">Show Solved</button>
        <button class='action-button unsolve-btn' onclick="loadMessages('unsolved')">Show Unsolved</button>
    </div>
    <div class = "srh-box">
    	<input type="text" id="searchInput" placeholder="Search messages..." onkeyup="searchMessages()" />
    </div>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Subject</th>
                <th>Message</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody id="messagesTableBody">
            <!-- Data will be loaded here -->
        </tbody>
    </table>

   
	</div>
</div>
</div>


</body>
</html>
