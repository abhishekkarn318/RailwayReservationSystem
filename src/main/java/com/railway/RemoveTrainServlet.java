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

@WebServlet("/RemoveTrainServlet")
public class RemoveTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        String trainNumber = request.getParameter("trainNumber");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/railway_db";
        String dbUser = "root";
        String dbPassword = "admin"; // Change this to your actual MySQL password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Delete train
            String sql = "DELETE FROM trains WHERE train_no=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, trainNumber);
            int rowsDeleted = stmt.executeUpdate();
            conn.close();

            // Response message
            if (rowsDeleted > 0) {
                out.println("Train removed successfully!");
            } else {
                out.println("Train not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
}
