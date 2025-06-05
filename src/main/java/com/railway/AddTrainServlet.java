package com.railway;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddTrainServlet")
public class AddTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String train_no = request.getParameter("trainNumber");
        String train_name = request.getParameter("trainName");
        String source_station = request.getParameter("trainSource");
        String destination_station = request.getParameter("trainDestination");
        String departure_time = request.getParameter("departureTime");
        String arrival_time = request.getParameter("arrivalTime");
        String sleeper_seats = request.getParameter("sleeperSeats");
        String sleeper_available_seats = request.getParameter("sleeperAvailableSeats");
        String third_ac_seats = request.getParameter("thirdACSeats");
        String third_ac_available_seats = request.getParameter("thirdACAvailableSeats");
        String second_ac_seats = request.getParameter("secondACSeats");
        String second_ac_available_seats = request.getParameter("secondACAvailableSeats");
        String first_ac_seats = request.getParameter("firstACSeats");
        String first_ac_available_seats = request.getParameter("firstACAvailableSeats");
        String sleeper_price = request.getParameter("sleeperPrice");
        String third_ac_price = request.getParameter("thirdACPrice");
        String second_ac_price = request.getParameter("secondACPrice");
        String first_ac_price = request.getParameter("firstACPrice");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/railway_db";
        String dbUser = "root";
        String dbPassword = "admin"; // Change this to your actual MySQL password

        String sql = "INSERT INTO trains (train_no, train_name, source_station, destination_station, departure_time, arrival_time, sleeper_seats, sleeper_available_seats, third_ac_seats, third_ac_available_seats, second_ac_seats, second_ac_available_seats, first_ac_seats, first_ac_available_seats, sleeper_price, third_ac_price, second_ac_price, first_ac_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Prepare statement
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, train_no);
            stmt.setString(2, train_name);
            stmt.setString(3, source_station);
            stmt.setString(4, destination_station);
            stmt.setString(5, departure_time);
            stmt.setString(6, arrival_time);
            stmt.setString(7, sleeper_seats);
            stmt.setString(8, sleeper_available_seats);
            stmt.setString(9, third_ac_seats);
            stmt.setString(10, third_ac_available_seats);
            stmt.setString(11, second_ac_seats);
            stmt.setString(12, second_ac_available_seats);
            stmt.setString(13, first_ac_seats);
            stmt.setString(14, first_ac_available_seats);
            stmt.setString(15, sleeper_price);
            stmt.setString(16, third_ac_price);
            stmt.setString(17, second_ac_price);
            stmt.setString(18, first_ac_price);

            // Execute update
            int rowsInserted = stmt.executeUpdate();
            conn.close();

            if (rowsInserted > 0) {
                out.println("<script>alert('Train added successfully!'); window.location='addTrain.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to add train!'); window.location='addTrain.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage().replace("'", "\\'").replace("\"", "\\\"");
            out.println("<script>alert('Error: " + errorMessage + "'); window.location='addTrain.jsp';</script>");
        }
    }
}
