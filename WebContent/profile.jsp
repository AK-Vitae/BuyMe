<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.Account" %>
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
<%@ include file="navigationBar.jsp" %>
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
</div>
<%} else { %>
<%
    Account userAccount = (Account) session.getAttribute("userAccount");
%>

<div class="marginLeft-Right">
    <h1>Welcome <%out.println(userAccount.getFirstName());%></h1>
    <h2>Access Level: <%out.println(userAccount.getAccessLevel());%></h2>
    <hr>
    <a href='editAccountInformation.jsp'>Edit Account Information</a>
    <br>
    <a href='deactivateAccount.jsp'>Deactivate Account</a>
    <%if (userAccount.getAccessLevel() == 1) {%>
    <br>
    <a href='createCustomerRepAccount.jsp'>Create a Customer Representative Account</a>
    <br>
    <a href='#'>Generate Sales Report</a>
    <%} %>
</div>
<% } %>
</body>

</html>