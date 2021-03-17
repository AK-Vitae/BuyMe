<%@page import="database.Database"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoginProcess</title>
</head>

<body>
<%
	//Open DB Connection
	Database db = new Database();
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
    try {
    	//Get parameters
    	conn = db.getConnection();
        String username = request.getParameter("userNameDelete");
        String password = request.getParameter("pswDelete");
        
        // Generate and Execute Query
        st = conn.createStatement();
        int i = st.executeUpdate("DELETE FROM account WHERE username='" + username + "' AND password='" + password + "';");
        out.println("Account deleted successfully");
        session.invalidate();
        out.println("<a href='index.jsp'>Go to Homepage</a>");
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