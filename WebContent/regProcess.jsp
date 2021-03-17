<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="database.Database"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RegistrationProcess</title>
</head>

<body>
<%
	Database db = new Database();
	Connection conn = null;
	Statement st = null;
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
        	out.println("Username Taken");
            out.println("<a href='register.jsp'>Please use a different Username</a>");
        } else {
        	// Build the SQL query with placeholders for parameters
            String query = "INSERT INTO account (first_name, last_name, username, password, email, access_level) VALUES (?, ?, ?, ?, ?, ?);";
            ps = conn.prepareStatement(query);

            // Add parameters to query
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, email);
            ps.setInt(6, accessLevel);

            int result = 0;
            result = ps.executeUpdate();
            if (result < 1) {
                out.println("Error: Registration failed.");
            } else {
                out.println("Thank you for registering");
                out.println("<a href='login.jsp'>Please Login</a>");
            }
        }
    } catch (Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
    	// Close
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (ps != null) ps.close(); } catch (Exception e) {};
        try { if (conn != null) db.closeConnection(conn); } catch (Exception e) {};
    }
%>
</body>

</html>