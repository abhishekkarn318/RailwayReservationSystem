<%@ page import="java.sql.*" %>

<%
    String source = request.getParameter("source");
    String destination = request.getParameter("destination");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");

        String query = "SELECT train_no, train_name, source_station, destination_station, " +
                       "departure_time, arrival_time, " +
                       "sleeper_available_seats, third_ac_available_seats, " +
                       "second_ac_available_seats, first_ac_available_seats " +
                       "FROM trains WHERE source_station = ? AND destination_station = ?";

        ps = con.prepareStatement(query);
        ps.setString(1, source);
        ps.setString(2, destination);

        rs = ps.executeQuery();
%>

<table class="train-table">
    <tr>
        <th>Train No</th>
        <th>Train Name</th>
        <th>Source</th>
        <th>Destination</th>
        <th>Departure Time</th>
        <th>Arrival Time</th>
        <th>Sleeper Seats</th>
        <th>3A Seats</th>
        <th>2A Seats</th>
        <th>1A Seats</th>
    </tr>

<%
    boolean found = false;
    while (rs.next()) {
        found = true;
%>
    <tr>
        <td><%= rs.getInt("train_no") %></td>
        <td><%= rs.getString("train_name") %></td>
        <td><%= rs.getString("source_station") %></td>
        <td><%= rs.getString("destination_station") %></td>
        <td><%= rs.getString("departure_time") %></td>
        <td><%= rs.getString("arrival_time") %></td>
        <td><%= rs.getInt("sleeper_available_seats") %></td>
        <td><%= rs.getInt("third_ac_available_seats") %></td>
        <td><%= rs.getInt("second_ac_available_seats") %></td>
        <td><%= rs.getInt("first_ac_available_seats") %></td>
        
    </tr>
<%
    }

    if (!found) {
%>
    <tr>
        <td colspan="11">No trains available for the selected criteria.</td>
    </tr>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
%>
    <p style="color: red;">Error: <%= e.getMessage() %></p>
<%
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (con != null) con.close();
}
%>
</table>
