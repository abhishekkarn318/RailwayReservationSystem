package com.railway;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookTicketServlet")
public class BookTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/railway_db";
        String user = "root";
        String password = "admin";

        // Retrieve data from the form
        int trainNo = request.getParameter("trainNo") != null ? Integer.parseInt(request.getParameter("trainNo")) : 0;
        String trainName = request.getParameter("trainName") != null ? request.getParameter("trainName") : "";
        String journeyDate = request.getParameter("journeyDate");
        String travelClass = request.getParameter("travelClass");
        String fromStation = request.getParameter("fromStation");
        String toStation = request.getParameter("toStation");

        String[] passengerNames = request.getParameterValues("passengerName");
        String[] ages = request.getParameterValues("age");
        String[] genders = request.getParameterValues("gender");
        String[] berthPreferences = request.getParameterValues("berthPreference");

        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        
        String payment_method = request.getParameter("paymentMethod");
        String price = request.getParameter("totalAmount");
        String reference_no = request.getParameter("paymentRef");

        Connection con = null;
        PreparedStatement psTicket = null;
        PreparedStatement psPassenger = null;
        PreparedStatement psUpdateSeats = null;
        ResultSet rs = null;

        try {
            // Establish Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            // Generate Unique PNR Number
            int pnrNumber = 100000 + (int) (Math.random() * 900000);

            // Insert Data into `tickets` Table
            String insertTicketSQL = "INSERT INTO tickets (pnr_no, train_no, train_name, journey_date, travel_class, status, phone_no, email, source_station, destination_station, price, payment_method, reference_no) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            psTicket = con.prepareStatement(insertTicketSQL);
            psTicket.setInt(1, pnrNumber);
            psTicket.setInt(2, trainNo);
            psTicket.setString(3, trainName);
            psTicket.setString(4, journeyDate);
            psTicket.setString(5, travelClass);

            psTicket.setString(7, phoneNumber);
            psTicket.setString(8, email);
            psTicket.setString(9, fromStation);
            psTicket.setString(10, toStation);
            psTicket.setString(11, price);
            psTicket.setString(12, payment_method);
            psTicket.setString(13, reference_no);

            // Check available seats
            String checkSeatsSQL = "SELECT " + travelClass.toLowerCase() + "_available_seats FROM trains WHERE train_no = ?";
            PreparedStatement psCheckSeats = con.prepareStatement(checkSeatsSQL);
            psCheckSeats.setInt(1, trainNo);
            rs = psCheckSeats.executeQuery();

            int availableSeats = 0;
            if (rs.next()) {
                availableSeats = rs.getInt(1);
            }

            if (availableSeats >= passengerNames.length) {
                psTicket.setString(6, "Confirmed");
                psTicket.executeUpdate();

                // Insert Data into `passengers` Table
                String insertPassengerSQL = "INSERT INTO passengers (pnr_no, name, age, gender, berth) VALUES (?, ?, ?, ?, ?)";
                psPassenger = con.prepareStatement(insertPassengerSQL);

                for (int i = 0; i < passengerNames.length; i++) {
                    psPassenger.setInt(1, pnrNumber);
                    psPassenger.setString(2, passengerNames[i]);
                    psPassenger.setInt(3, Integer.parseInt(ages[i]));
                    psPassenger.setString(4, genders[i]);
                    psPassenger.setString(5, berthPreferences[i]);
                    psPassenger.executeUpdate();
                }

                // Update Available Seats in `trains` Table
                String updateSeatsSQL = "UPDATE trains SET " + travelClass.toLowerCase() + "_available_seats = ? WHERE train_no = ?";
                psUpdateSeats = con.prepareStatement(updateSeatsSQL);
                psUpdateSeats.setInt(1, availableSeats - passengerNames.length);
                psUpdateSeats.setInt(2, trainNo);
                psUpdateSeats.executeUpdate();

                // Show Success Alert
                out.println("<script>");
                out.println("alert('Ticket booked successfully! Your PNR Number is: " + pnrNumber + "');");
                out.println("window.location.href = 'searchTrain.jsp';");
                out.println("</script>");

            } else {
                psTicket.setString(6, "Waitlisted");
                psTicket.executeUpdate();

                // Insert Data into `passengers` Table
                String insertPassengerSQL = "INSERT INTO passengers (pnr_no, name, age, gender, berth) VALUES (?, ?, ?, ?, ?)";
                psPassenger = con.prepareStatement(insertPassengerSQL);

                for (int i = 0; i < passengerNames.length; i++) {
                    psPassenger.setInt(1, pnrNumber);
                    psPassenger.setString(2, passengerNames[i]);
                    psPassenger.setInt(3, Integer.parseInt(ages[i]));
                    psPassenger.setString(4, genders[i]);
                    psPassenger.setString(5, berthPreferences[i]);
                    psPassenger.executeUpdate();
                }

                // Show Waitlist Alert
                out.println("<script>");
                out.println("alert('All seats are full. Your ticket is on the waitlist. PNR Number is: " + pnrNumber + "');");
                out.println("window.location.href = 'searchTrain.jsp';");
                out.println("</script>");
            }

        } catch (Exception e) {
            out.println("<script>");
            out.println("alert('Error booking ticket: " + e.getMessage() + "');");
            out.println("window.location.href = 'searchTrain.jsp';");
            out.println("</script>");
        } finally {
            try {
                if (psTicket != null) psTicket.close();
                if (psPassenger != null) psPassenger.close();
                if (psUpdateSeats != null) psUpdateSeats.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}