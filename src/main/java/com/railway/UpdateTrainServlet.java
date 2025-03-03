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

@WebServlet("/UpdateTrainServlet")
public class UpdateTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String sql = "UPDATE trains SET trainName=?, trainSource=?, trainDestination=?, seats=?, fare=? WHERE trainNumber=?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, trainName);
            stmt.setString(2, trainSource);
            stmt.setString(3, trainDestination);
            stmt.setString(4, seats);
            stmt.setString(5, fare);
            stmt.setString(6, trainNumber);

            int rowsUpdated = stmt.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
                out.println("<script>alert('Train updated successfully!'); window.location='updateTrain.jsp';</script>");
            } else {
                out.println("<script>alert('Train update failed!'); window.location='updateTrain.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = e.getMessage().replace("'", "\\'").replace("\"", "\\\"");
            out.println("<script>alert('Error: " + errorMessage + "'); window.location='updateTrain.jsp';</script>");
        }
    }
}
