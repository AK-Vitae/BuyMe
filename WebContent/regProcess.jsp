<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%
    Database db = new Database();
    Connection conn = null;
    Statement st;
    ResultSet rs = null;
    PreparedStatement ps = null;
    try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String password = request.getParameter("psw");
        String email = request.getParameter("email");
        int accessLevel = 3;

        st = conn.createStatement();
        // Create query for login validation
        rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "';");
        if (rs.next()) {
            out.println("<div class=\"container signin\"><p>Username Taken <br><a href=\"register.jsp\">Try Again</a>.</p> </div>");
        } else {
            // Build the SQL query with placeholders for parameters
            String query = "INSERT INTO account (first_name, last_name, username, password, email, access_level, is_active) VALUES (?, ?, ?, ?, ?, ?, ?);";
            ps = conn.prepareStatement(query);

            // Add parameters to query
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, email);
            ps.setInt(6, accessLevel);
            ps.setBoolean(7, true); // isActive = true

            int result;
            result = ps.executeUpdate();
            if (result < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem registering your account <br><a href=\"register.jsp\">Try Again</a>.</p> </div>");
            } else {
                out.println("<div class=\"container signin\"><p>Thank you for registering <br><a href=\"login.jsp\">Please Login</a>.</p> </div>");
            }
        }
    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (ps != null) ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) db.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>

</html>