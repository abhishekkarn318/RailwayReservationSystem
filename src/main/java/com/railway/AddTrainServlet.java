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
        String trainNumber = request.getParameter("trainNumber");
        String trainName = request.getParameter("trainName");
        String trainSource = request.getParameter("trainSource");
        String trainDestination = request.getParameter("trainDestination");
        String seats = request.getParameter("seats");
        String fare = request.getParameter("fare");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/railway_db";
        String dbUser = "root";
        String dbPassword = "admin"; // Change this to your actual MySQL password

        String sql = "INSERT INTO trains (trainNumber, trainName, trainSource, trainDestination, seats, fare) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Prepare statement
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, trainNumber);
            stmt.setString(2, trainName);
            stmt.setString(3, trainSource);
            stmt.setString(4, trainDestination);
            stmt.setString(5, seats);
            stmt.setString(6, fare);

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
