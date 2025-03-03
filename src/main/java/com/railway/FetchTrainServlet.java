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

@WebServlet("/FetchTrainServlet")
public class FetchTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String trainNumber = request.getParameter("trainNumber");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/railway_db";
        String dbUser = "root";
        String dbPassword = "admin"; // Change this to your actual MySQL password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Fetch train details
            String sql = "SELECT * FROM trains WHERE trainNumber=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, trainNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Train found, generate HTML form with pre-filled values
                out.println("<form action='UpdateTrainServlet' method='post'>");
                out.println("<input type='hidden' name='trainNumber' value='" + rs.getString("trainNumber") + "'>");
                
                out.println("<div class='form-row'>");
                out.println("<div class='form-group'>");
                out.println("<label>Train Name:</label>");
                out.println("<input type='text' name='trainName' value='" + rs.getString("trainName") + "' required>");
                out.println("</div>");
                out.println("</div>");
                
                out.println("<div class='form-row'>");
                out.println("<div class='form-group'>");
                out.println("<label>Source Station:</label>");
                out.println("<input type='text' name='trainSource' value='" + rs.getString("trainSource") + "' required>");
                out.println("</div>");
                
                out.println("<div class='form-group'>");
                out.println("<label>Destination Station:</label>");
                out.println("<input type='text' name='trainDestination' value='" + rs.getString("trainDestination") + "' required>");
                out.println("</div>");
                out.println("</div>");
                
                out.println("<div class='form-row'>");
                out.println("<div class='form-group'>");
                out.println("<label>Total Seats:</label>");
                out.println("<input type='number' name='seats' value='" + rs.getString("seats") + "' required>");
                out.println("</div>");
                
                out.println("<div class='form-group'>");
                out.println("<label>Fare (INR):</label>");
                out.println("<input type='number' name='fare' value='" + rs.getString("fare") + "' required>");
                out.println("</div>");
                out.println("</div>");
                
                out.println("<button type='submit'>Update Train</button>");
                out.println("</form>");
            } else {
                out.println("<script>alert('Train not found!');</script>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
        }
    }
}
