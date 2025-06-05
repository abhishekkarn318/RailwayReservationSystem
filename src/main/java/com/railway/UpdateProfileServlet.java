package com.railway;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.getWriter().write("Session expired. Please log in again.");
            return;
        }

        String userID = (String) session.getAttribute("id");
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");

            String sql = "UPDATE users SET name=?, username=?, address=?, email=?, phonenumber=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, username);
            stmt.setString(3, address);
            stmt.setString(4, email);
            stmt.setString(5, phonenumber);
            stmt.setString(6, userID);

            int rowsUpdated = stmt.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
                session.setAttribute("name", name);
                session.setAttribute("userEmail", email);
                response.getWriter().write("Profile updated successfully.");
            } else {
                response.getWriter().write("Failed to update profile.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
