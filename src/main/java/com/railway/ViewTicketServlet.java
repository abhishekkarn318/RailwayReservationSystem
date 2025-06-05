package com.railway;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewTicketServlet")
public class ViewTicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/railway_db";
        String dbUser = "root";
        String dbPassword = "admin"; // Change this to your actual MySQL password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Fetch train details
            String sql = "SELECT * FROM trains";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("train_no") + "</td>");
                out.println("<td>" + rs.getString("train_name") + "</td>");
                out.println("<td>" + rs.getString("source_station") + "</td>");
                out.println("<td>" + rs.getString("destination_station") + "</td>");
                out.println("<td>" + rs.getTime("departure_time") + "</td>");
                out.println("<td>" + rs.getTime("arrival_time") + "</td>");
                out.println("</tr>");
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
        }
    }
}
