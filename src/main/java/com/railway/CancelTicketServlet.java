package com.railway;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/CancelTicketServlet")
public class CancelTicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pnr = Integer.parseInt(request.getParameter("pnr"));
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");

            // Step 1: Retrieve Ticket Details
            String getTicketQuery = "SELECT * FROM tickets WHERE pnr_no = ?";
            PreparedStatement ps = con.prepareStatement(getTicketQuery);
            ps.setInt(1, pnr);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int trainNo = rs.getInt("train_no");
                String travelClass = rs.getString("travel_class");
                String status = rs.getString("status");

                // Step 2: Count number of passengers for this PNR
                String countPassengersQuery = "SELECT COUNT(*) AS passengerCount FROM passengers WHERE pnr_no = ?";
                PreparedStatement pstCount = con.prepareStatement(countPassengersQuery);
                pstCount.setInt(1, pnr);
                ResultSet countRs = pstCount.executeQuery();

                int passengerCount = 0;
                if (countRs.next()) {
                    passengerCount = countRs.getInt("passengerCount");
                }

                // Step 3: Delete Ticket and Passengers
                PreparedStatement deletePassengers = con.prepareStatement("DELETE FROM passengers WHERE pnr_no = ?");
                deletePassengers.setInt(1, pnr);
                deletePassengers.executeUpdate();

                PreparedStatement deleteTicket = con.prepareStatement("DELETE FROM tickets WHERE pnr_no = ?");
                deleteTicket.setInt(1, pnr);
                deleteTicket.executeUpdate();

                // Step 4: Update Seat Availability
                String seatColumn = "";
                switch (travelClass) {
                    case "sleeper": seatColumn = "sleeper_available_seats"; break;
                    case "third_ac": seatColumn = "third_ac_available_seats"; break;
                    case "second_ac": seatColumn = "second_ac_available_seats"; break;
                    case "first_ac": seatColumn = "first_ac_available_seats"; break;
                    default: 
                        response.getWriter().write("Error: Invalid Travel Class Found.");
                        return;
                }

                String updateSeatsQuery = "UPDATE trains SET " + seatColumn + " = " + seatColumn + " + ? WHERE train_no = ?";
                PreparedStatement updateSeats = con.prepareStatement(updateSeatsQuery);
                updateSeats.setInt(1, passengerCount);  // Adding multiple passengers
                updateSeats.setInt(2, trainNo);
                updateSeats.executeUpdate();

                // Step 5: Promote First Waitlisted Ticket to Confirmed
                if ("Confirmed".equalsIgnoreCase(status)) {
                    String getWaitlistedTicket = 
                        "SELECT * FROM tickets WHERE train_no = ? AND status = 'Waitlisted' ORDER BY booking_time LIMIT ?";
                    PreparedStatement getWaitlistedPs = con.prepareStatement(getWaitlistedTicket);
                    getWaitlistedPs.setInt(1, trainNo);
                    getWaitlistedPs.setInt(2, passengerCount); // Promote same number of seats
                    ResultSet waitlistedRs = getWaitlistedPs.executeQuery();

                    while (waitlistedRs.next()) {
                        int waitlistedPnr = waitlistedRs.getInt("pnr_no");

                        String updateWaitlistedQuery = "UPDATE tickets SET status = 'Confirmed' WHERE pnr_no = ?";
                        PreparedStatement updateWaitlistedPs = con.prepareStatement(updateWaitlistedQuery);
                        updateWaitlistedPs.setInt(1, waitlistedPnr);
                        updateWaitlistedPs.executeUpdate();
                    }
                }

                response.getWriter().write("Ticket successfully canceled and seats updated.");
            } else {
                response.getWriter().write("No ticket found with the given PNR.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
