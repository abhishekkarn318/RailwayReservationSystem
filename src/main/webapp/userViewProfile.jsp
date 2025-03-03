<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String userName = (sessionObj != null) ? (String) sessionObj.getAttribute("name") : null;
    String userID = (sessionObj != null) ? (String) sessionObj.getAttribute("id") : null;
    String userEmail = "";
    String userPhone = "";
    String userUserName = "";
    String userAddress = "";

    if (sessionObj == null || userName == null) {
%>
    <script>
        alert("Session expired! Please log in again.");
        window.location.href = "login.html";
    </script>
<%
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");
        PreparedStatement ps = conn.prepareStatement("SELECT name, username, address, email, phonenumber FROM users WHERE id=?");
        ps.setString(1, userID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
        	userName = rs.getString("name");
        	userUserName = rs.getString("username");
        	userAddress = rs.getString("address");
        	userEmail = rs.getString("email");
        	userPhone = rs.getString("phonenumber");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Railway Reservation System</title>
    <script src="js/script.js" defer></script>
    
    <script>
        function toggleEditSave() {
            var nameField = document.getElementById("userName");
            var usernameField = document.getElementById("userUserName");
            var addressField = document.getElementById("address");
            var emailField = document.getElementById("email");
            var phoneField = document.getElementById("phonenumber");
            var button = document.getElementById("editSaveBtn");

            if (button.innerText === "Update Profile") {
                // Enable fields for editing
                nameField.removeAttribute("readonly");
                usernameField.removeAttribute("readonly");
                addressField.removeAttribute("readonly");
                emailField.removeAttribute("readonly");
                phoneField.removeAttribute("readonly");
                button.innerText = "Save";
                button.classList.remove("btn-primary");
                button.classList.add("btn-success");
            } else {
                // Save updated data
                saveProfile();
            }
        }

        function saveProfile() {
            var name = document.getElementById("name").value;
            var email = document.getElementById("email").value;
            var phone = document.getElementById("phone").value;
            var userID = "<%= session.getAttribute("id") %>";

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "UpdateProfileServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    alert(xhr.responseText);

                    // Disable fields after saving
                    document.getElementById("name").setAttribute("readonly", "true");
                    document.getElementById("email").setAttribute("readonly", "true");
                    document.getElementById("phone").setAttribute("readonly", "true");

                    // Change button back to "Update Profile"
                    var button = document.getElementById("editSaveBtn");
                    button.innerText = "Update Profile";
                    button.classList.remove("btn-success");
                    button.classList.add("btn-primary");
                }
            };
            xhr.send("id=" + userID + "&name=" + name + "&email=" + email + "&phone=" + phone);
        }
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

.btn {
            padding: 10px 15px;
            margin-top: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-primary {
            background: #007bff;
            color: white;
        }
        .btn-success {
            background: #28a745;
            color: white;
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
            <li><a href="adminDashboard.jsp">Dashboard</a></li>
            <li><a href="addTrain.jsp">Add Trains</a></li>
            <li><a href="updateTrain.jsp">Update Trains</a></li>
            <li><a href="removeTrain.jsp">Remove Trains</a></li>
            <li><a href="viewTrain.jsp">View Trains</a></li>
            <li><a href="contactMessages.jsp">Messages</a></li>
            <li><a href="userViewProfile.jsp">Profile Edit</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </div>
    
<div class="upper-container">
    <div class="contentcontainer">
        <h1>User Profile</h1>
    	<form>
    	<div class="form-row">
        	<div class="form-group">
        		<label>Id:</label>
        		<input type="text" id="id" value="<%= userID %>" readonly>
        	</div>
			<div class="form-group">
        		<label>Full Name:</label>
        		<input type="text" id="userUserName" value="<%= userName %>" readonly>
        	</div>
		</div>
		
		<div class="form-row">
        	<div class="form-group">
        		<label>Username:</label>
        		<input type="text" value="<%= userUserName %>" readonly>
        	</div>
			<div class="form-group">
        		<label>Address:</label>
        		<input type="text" value="<%= userAddress %>" readonly>
			</div>
		</div>
		
		<div class="form-row">
        	<div class="form-group">
        		<label>Email:</label>
        		<input type="email" value="<%= userEmail %>" readonly>
			</div>
			<div class="form-group">
        		<label>Phone:</label>
        		<input type="text" value="<%= userPhone %>" readonly>
        	</div>
		</div>
		<button type="button" id="editSaveBtn" class="btn btn-primary" onclick="toggleEditSave()">Update Profile</button>
    </form>
       
    </div>
</div>
</div>
</body>
</html>
