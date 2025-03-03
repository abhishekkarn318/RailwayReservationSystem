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

@WebServlet("/ContactMessagesServlet")
public class ContactMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String statusFilter = request.getParameter("status"); // Get status filter from request
        String jdbcURL = "jdbc:mysql://localhost:3306/railway_db";
        String dbUser = "root";
        String dbPassword = "admin"; 
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String sql = "SELECT * FROM contact_messages";
            
            if (statusFilter != null && (statusFilter.equals("solved") || statusFilter.equals("unsolved"))) {
                sql += " WHERE status = ?";
            }
            
            stmt = conn.prepareStatement(sql);
            if (statusFilter != null && (statusFilter.equals("solved") || statusFilter.equals("unsolved"))) {
                stmt.setString(1, statusFilter);
            }
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int messageId = rs.getInt("id");
                String status = rs.getString("status");
                String statusClass = status.equals("solved") ? "status-solved" : "status-unsolved";
                
                out.println("<tr>");
                out.println("<td>" + messageId + "</td>");
                out.println("<td>" + rs.getString("full_name") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("subject") + "</td>");
                out.println("<td>" + rs.getString("message") + "</td>");
                
                // Display button based on status
                out.println("<td class='" + statusClass + "'>");
                if (status.equals("solved")) {
                    out.println("<button class='action-button unsolve-btn' onclick='updateStatus(" + messageId + ", \"unsolved\")'>Mark as Unsolved</button>");
                } else {
                    out.println("<button class='action-button solve-btn' onclick='updateStatus(" + messageId + ", \"solved\")'>Mark as Solved</button>");
                }
                out.println("</td>");              
                out.println("</tr>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<tr><td colspan='6' style='color:red;'>Error fetching messages: " + e.getMessage() + "</td></tr>");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
