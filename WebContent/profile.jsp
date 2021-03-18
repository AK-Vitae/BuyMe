<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
    <%@ include file = "navigationBar.jsp" %>
      <% if ((session.getAttribute("user")==null)) { %>
    <div class="marginLeft">
        <p>You are not logged in</p>
        <br/>
        <a href="login.jsp">Please Login</a>
    </div>
        <%} else { %>
            <div class="marginLeft">
        	    <h1>Welcome <%=session.getAttribute("user")%></h1>
        	    <hr>
                <a href='logout.jsp'>Log Out</a>
                <br>
                <a href='deleteAccount.jsp'>Delete Account</a>
            </div>
            <% } %>
    </body>

    </html>