<%@page import="database.Database"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

        if(username.equals(session.getAttribute("user").toString())) {
            int i = st.executeUpdate("DELETE FROM account WHERE username='" + username + "' AND password='" + password + "';");
            if (i < 1) {
                out.println("<div class=\"container signin\"><p>Account was not deleted: Invalid credentials <br> <a href=\"deleteAccount.jsp\">Try Again</a>.</p></div>");
            } else {
                session.invalidate();
                out.println("<div class=\"container signin\"><p>Account deleted successfully <br> <a href=\"deleteAccount.jsp\">Go to Homepage</a>.</p></div>");
            }
        } else {
            out.println("<div class=\"container signin\"><p>Account was not deleted: Invalid credentials <br> <a href=\"deleteAccount.jsp\">Try Again</a>.</p></div>");
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