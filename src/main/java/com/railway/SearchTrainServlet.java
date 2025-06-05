package com.railway;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchTrainServlet")
public class SearchTrainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fromStation = request.getParameter("fromStation");
        String toStation = request.getParameter("toStation");
        String journeyDate = request.getParameter("journeyDate");

        List<Map<String, Object>> trains = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");

            String sql = "SELECT * FROM trains WHERE source_station=? AND destination_station=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fromStation);
            ps.setString(2, toStation);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> train = new HashMap<>();
                train.put("trainNo", rs.getInt("train_no"));
                train.put("trainName", rs.getString("train_name"));
                train.put("departureTime", rs.getTime("departure_time"));
                train.put("arrivalTime", rs.getTime("arrival_time"));
                train.put("sleeper_available_seats", rs.getInt("sleeper_available_seats"));
                train.put("sleeper_price", rs.getInt("sleeper_price"));
                train.put("third_ac_available_seats", rs.getInt("third_ac_available_seats"));
                train.put("third_ac_price", rs.getInt("third_ac_price"));
                train.put("second_ac_available_seats", rs.getInt("second_ac_available_seats"));
                train.put("second_ac_price", rs.getInt("second_ac_price"));
                train.put("first_ac_available_seats", rs.getInt("first_ac_available_seats"));
                train.put("first_ac_price", rs.getInt("first_ac_price"));
                trains.add(train);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("trains", trains);
        request.setAttribute("fromStation", fromStation);
        request.setAttribute("toStation", toStation);
        request.setAttribute("journeyDate", journeyDate);
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
}
