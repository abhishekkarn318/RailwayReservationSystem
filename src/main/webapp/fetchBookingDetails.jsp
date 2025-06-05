<%@ page import="java.sql.*" %>

<%
    String pnr = request.getParameter("pnr");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_db", "root", "admin");

        String query = "SELECT * FROM passengers WHERE pnr_no = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(pnr));

        rs = ps.executeQuery();
%>

<table class="train-table">
    <tr>
        <th>Name</th>
        <th>Age</th>
        <th>Gender</th>
        <th>Berth Preference</th>
    </tr>

<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getInt("age") %></td>
        <td><%= rs.getString("gender") %></td>
        <td><%= rs.getString("berth") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <p style="color: red;">Error fetching passenger details.</p>
<%
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
</table>
