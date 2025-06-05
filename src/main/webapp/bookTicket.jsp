<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List, java.util.Map" %>

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
    <title>Book Ticket - Railway Reservation System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

.passengerDetails {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px; /* Adjust spacing between fields */
}

.passenger {
    display: flex;
    flex-direction: column;
}
.contactDetails {
    display: flex;

    align-items: center;
    gap: 50px; /* Adjust spacing between fields */
}

.contact {
    display: flex;
    flex-direction: column;
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
.totalAmount{
	text-align: right;
}
.payment {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 50px; /* Adjust spacing between fields */

}

.paymentArea{
    flex: 1; /* Ensures both fields take equal width */
    display: flex;
    flex-direction: column;
    
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
            <li><a href="">View Trains</a></li>
            <li><a href="">Seat Availability</a></li>
            <li><a href="">Check Fare</a></li>
            <li><a href="searchTrain.jsp">Book Ticket</a></li>
            <li><a href="">Booking History</a></li>
            <li><a href="userViewProfile.jsp">Profile</a></li>
            <li><a href="LogoutServlet">Logout</a></li>
        </ul>
    </div>
    
<div class="upper-container">
    <div class="contentcontainer">
        <h1>Book Your Train Ticket</h1>
        <div class="form-row">
        	<div class="form-group">
        		<h3><%= request.getParameter("trainName") %> (<%= request.getParameter("trainNo") %>) -- <%= request.getParameter("journeyDate") %></h3>
        	</div> 
        </div>
        <div class="form-row">
        	<div class="form-group">
        		<label style="text-align:center; margin:0"><%= request.getParameter("fromStation") %></label>
        		<label style="text-align:center; margin:0"><%= request.getParameter("departureTime") %></label>
        	</div>
        	<div class="form-group">
        		<label style="text-align:center; margin:0"><%= request.getParameter("travelClass") %></label>
        	</div>
        	<div class="form-group">
        		<label style="text-align:center; margin:0"><%= request.getParameter("toStation") %></label>
        		<label style="text-align:center; margin:0"><%= request.getParameter("arrivalTime") %></label>
        	</div>
        </div>
        <br>
    	<form action="BookTicketServlet" method="post">
    	<div id="passengerDetailsContainer">
    	<div class="passengerDetails">
        	<div class="passenger" style="width:300px">
            	<label>Passenger Name:</label>
            	<input type="text" name="passengerName" placeholder="Enter passenger name" required>
            </div>
			<div class="passenger" style="width:100px">
				<label>Age:</label>
            	<input type="number" name="age" placeholder="Enter age" required>
            </div>
            <div class="passenger" style="width:100px">
				<label>Gender:</label>
            	<select name="gender" required>
            		<option value="" selected disabled>- Select -</option>
                	<option value="Male">Male</option>
                	<option value="Female">Female</option>
                	<option value="Other">Other</option>
            	</select>
            </div>
            <div class="passenger" style="width:155px">
				<label>Berth Preference:</label>
            	<select name="berthPreference">
            		<option value="" selected disabled>- Select -</option>
                	<option value="Lower">Lower</option>
                	<option value="Middle">Middle</option>
                	<option value="Upper">Upper</option>
                	<option value="Side Lower">Side Lower</option>
                	<option value="Side Upper">Side Upper</option>
            	</select>
            </div>
            <div class="passenger" style="width:100px; text-align:center;">
                
            </div>
		</div>
		</div>
		<button type="button" onclick="addPassenger()">+ Add Passenger</button>
        <div class="contactDetails">
        	<div class="contact" style="width:300px">
            	<label>Phone No.:</label>
            	<input type="number" name="phoneNumber" placeholder="Enter passenger's phone number" required>
			</div>
			<div class="contact" style="width:300px">
            	<label>E-mail:</label>
            	<input type="email" name="email" placeholder="Enter passenger's e-mail address" required>
			</div>
		</div>
			<div class = "totalAmount">
				<p>Total Amount: Rs. <span id="totalAmount"><%= request.getParameter("classPrice") %></span></p>
			</div>
			
			<h3>Payment Details</h3>
			<label>Choose Payment Method:</label>
			<select id="paymentMethod" onchange="generatePaymentRef()" required>
    			<option value="" selected disabled>- Select Payment Method -</option>
    			<option value="Credit Card">Credit Card</option>
    			<option value="Debit Card">Debit Card</option>
    			<option value="UPI">UPI</option>
			</select>

			<div id="paymentSection" style="display:none;">
    			<label>Payment Reference Number:</label>
    			<input type="text" id="paymentRef" name="paymentRef" readonly>
			</div>

			<button type="button" onclick="validatePayment()">Proceed to Pay &amp; Book</button>

			
			
            
            
            <input type="hidden" name="trainNo" value="<%= request.getParameter("trainNo") %>">
			<input type="hidden" name="trainName" value="<%= request.getParameter("trainName") %>">
			<input type="hidden" name="journeyDate" value="<%= request.getParameter("journeyDate") %>">
			<input type="hidden" name="fromStation" value="<%= request.getParameter("fromStation") %>">
			<input type="hidden" name="toStation" value="<%= request.getParameter("toStation") %>">
			<input type="hidden" name="travelClass" value="<%= request.getParameter("travelClass") %>">
			<input type="hidden" name="totalAmount" id="hiddenTotalAmount">
			<input type="hidden" name="paymentMethod" id="hiddenPaymentMethod">
			<input type="hidden" name="paymentRef" id="paymentRef">
            
        </form>
       
       <script>
    // Calculate total amount dynamically
    function updateTotalAmount() {
    const basePrice = parseInt("<%= request.getParameter("classPrice") %>");
    const passengerCount = document.querySelectorAll('.passengerDetails').length;
    const totalAmount = basePrice * passengerCount;

    // Display the updated total amount
    document.getElementById("totalAmount").textContent = totalAmount;

    // Assign the calculated amount to the hidden field for form submission
    document.getElementById("hiddenTotalAmount").value = totalAmount;
}


    // Add Passenger and Update Amount
    function addPassenger() {
        const passengerContainer = document.getElementById("passengerDetailsContainer");

        const newPassenger = document.createElement("div");
        newPassenger.className = "passengerDetails";
        newPassenger.innerHTML = `
        	<div class="passenger" style="width:300px">
        	<label>Passenger Name:</label>
        	<input type="text" name="passengerName" placeholder="Enter passenger name" required>
        </div>
		<div class="passenger" style="width:100px">
			<label>Age:</label>
        	<input type="number" name="age" placeholder="Enter age" required>
        </div>
        <div class="passenger" style="width:100px">
			<label>Gender:</label>
        	<select name="gender" required>
        		<option value="" selected disabled>- Select -</option>
            	<option value="Male">Male</option>
            	<option value="Female">Female</option>
            	<option value="Other">Other</option>
        	</select>
        </div>
        <div class="passenger" style="width:155px">
			<label>Berth Preference:</label>
        	<select name="berthPreference">
        		<option value="" selected disabled>- Select -</option>
            	<option value="Lower">Lower</option>
            	<option value="Middle">Middle</option>
            	<option value="Upper">Upper</option>
            	<option value="Side Lower">Side Lower</option>
            	<option value="Side Upper">Side Upper</option>
        	</select>
        </div>
        <div class="passenger" style="width:100px; text-align:center;">
            <button type="button" onclick="removePassenger(this)" 
                style="background-color:#dc3545; color:white; padding:5px 10px; border:none; border-radius: 5px; margin: 0;">
                <i class="fa fa-trash-o" style="font-size:25px"></i>
            </button>
        </div>`;

        passengerContainer.appendChild(newPassenger);

        // Update total amount
        updateTotalAmount();
    }

    // Remove Passenger and Update Amount
    function removePassenger(button) {
        const passengerContainer = document.getElementById("passengerDetailsContainer");
        passengerContainer.removeChild(button.parentElement.parentElement);

        // Update total amount
        updateTotalAmount();
    }

    // Initialize total amount calculation on page load
    window.onload = updateTotalAmount;
    
 // Generate a random 12-digit payment reference number
    function generatePaymentRef() {
        const paymentMethod = document.getElementById("paymentMethod").value;
        const paymentSection = document.getElementById("paymentSection");
        const paymentRefInput = document.getElementById("paymentRef");

        if (paymentMethod) {
            const randomRef = "PAY" + Math.floor(100000000000 + Math.random() * 900000000000);
            paymentRefInput.value = randomRef;
            paymentSection.style.display = "block";
        } else {
            paymentSection.style.display = "none";
            paymentRefInput.value = "";
        }
    }

    function validatePayment() {
        const paymentMethod = document.getElementById("paymentMethod").value;
        const paymentRef = document.getElementById("paymentRef").value;

        if (!paymentMethod) {
            alert("Please select a payment method.");
            return;
        }

        if (!paymentRef) {
            alert("Payment reference number is missing.");
            return;
        }
        document.getElementById("paymentMethod").value = paymentMethod;
        document.getElementById("hiddenPaymentMethod").value = paymentMethod;
        document.getElementById("paymentRef").value = paymentRef;
        
        alert("Payment successful! Proceeding with booking...");
        document.querySelector("form").submit();
    }


</script>


       
    </div>
</div>
</div>
</body>
</html>
