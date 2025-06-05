<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*" %>
<%
    HttpSession sessionObj = request.getSession(false); // Get session without creating a new one
    String name = (sessionObj != null) ? (String) sessionObj.getAttribute("name") : null;

    if (name == null) {
%>
    <script>
        alert("Session Timed Out! Please Re-login."); // Show pop-up alert
        window.location.href = "login.html"; // Redirect to login page
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
    <title>My Booking History - Railway Reservation System</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
}

.contentcontainer h1 {
	margin-top: 0;
    margin-bottom: 30px;
    color: #333;
    text-align:center;
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

    </style>
    
    
    <script>
        $(document).ready(function() {
            $(".showMoreBtn").click(function() {
                const pnr = $(this).data("pnr");
                const detailsDiv = $("#details-" + pnr);

                if (detailsDiv.is(":visible")) {
                    detailsDiv.slideUp(); // Hide if already visible
                } else {
                    $.ajax({
                        type: "POST",
                        url: "fetchBookingDetails.jsp",
                        data: { pnr: pnr },
                        success: function(response) {
                            detailsDiv.html(response).slideDown();
                        },
                        error: function() {
                            detailsDiv.html("<p style='color:red;'>Error fetching details. Try again later.</p>").slideDown();
                        }
                    });
                }
            });
        });
    </script>
    <script>
    $(document).ready(function() {
        $(".cancelBtn").click(function() {
            const pnr = $(this).data("pnr");

            if (confirm("Are you sure you want to cancel this ticket?")) {
                $.ajax({
                    type: "POST",
                    url: "CancelTicketServlet", // Servlet that handles cancellation
                    data: { pnr: pnr },
                    success: function(response) {
                        alert(response.trim()); // Show success/error message
                        location.reload(); // Refresh booking history after cancellation
                    },
                    error: function() {
                        alert("Error canceling ticket. Please try again later.");
                    }
                });
            }
        });
    });
</script>
    
    
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
<h3>You're logged in as <%= name %> !</h3>
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
        <h1>My Booking History</h1>
<%
        String userEmail = (String) session.getAttribute("userEmail"); // Assuming user login session
        if (userEmail == null) {
            response.sendRedirect("userLogin.jsp"); // Redirect if not logged in
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");

            String query = "SELECT * FROM tickets WHERE email = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, userEmail);
            rs = ps.executeQuery();

            boolean found = false;
%>
    <table class="train-table">
        <tr>
            <th>PNR No</th>
            <th>Train No</th>
            <th>Train Name</th>
            <th>From</th>
            <th>To</th>
            <th>Journey Date</th>
            <th>Class</th>
            <th>Status</th>
            <th>Booking Time</th>
            <th>Action</th>
        </tr>

    <%
            while (rs.next()) {
                found = true;
    %>
        <tr>
            <td><%= rs.getInt("pnr_no") %></td>
            <td><%= rs.getInt("train_no") %></td>
            <td><%= rs.getString("train_name") %></td>
            <td><%= rs.getString("source_station") %></td>
            <td><%= rs.getString("destination_station") %></td>
            <td><%= rs.getDate("journey_date") %></td>
            <td><%= rs.getString("travel_class") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getTimestamp("booking_time") %></td>
            <td>
                <button class="showMoreBtn" data-pnr="<%= rs.getInt("pnr_no") %>">Show More</button>
                <button class="cancelBtn" data-pnr="<%= rs.getInt("pnr_no") %>">Cancel Ticket</button>
            </td>
        </tr>

        <tr>
            <td colspan="10">
                <div id="details-<%= rs.getInt("pnr_no") %>" style="display: none;"></div>
            </td>
        </tr>
    <%
            }

            if (!found) {
    %>
        <tr>
            <td colspan="10">No booking history found.</td>
        </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
        <p style="color: red;">Error: <%= e.getMessage() %></p>
    <%
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    %>
    </table>
    </div>
</div>
</div>
</body>
</html>
