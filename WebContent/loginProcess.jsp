<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="database.Database"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>
<%
	Database db = new Database();
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
    try {
    	// Open DB Connection and get parameters
    	conn = db.getConnection();
        String username = request.getParameter("username");
        String password = request.getParameter("psw");
        st = conn.createStatement();

        // Create query for login validation
        rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "' AND password='" + password + "';");
        if (rs.next()) {
            session.setAttribute("user", username);
            response.sendRedirect("success.jsp");
        } else {
        	out.println("<div class=\"container signin\"><p>Invalid Credentials <br><a href=\"login.jsp\">Try Again</a>.</p> </div>");
        }
    } catch (Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
    	// Close
        try { if (rs != null) rs.close(); } catch (Exception e) {};
        try { if (st != null) st.close(); } catch (Exception e) {};
        try { if (conn != null) db.closeConnection(conn); } catch (Exception e) {};
    }
%>
</body>

</html>