<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="util.*" %>

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
<div class="marginLeft-Right">
    <%
        AuctionItem auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));
        out.print("<h1> Listing ID: " + auctionItem.getListingId() + "</h1>");
        out.print("<hr>");
        String productType = auctionItem.getType();
//        if (productType.equalsIgnoreCase("car")) {
//            Car car = new Car(auctionItem.getListingId());
//        } else if (productType.equalsIgnoreCase("boat")) {
//            Boat boat = new Boat(auctionItem.getListingId());
//        } else if (productType.equalsIgnoreCase("plane")) {
//            Aircraft aircraft = new Aircraft(auctionItem.getListingId());
//        }

        // Finding if the auction ended or is still open
        String auctionStatus = request.getParameter("status");
        if (auctionStatus.equals("completed")) {
            auctionStatus = "Auction Completed";
        } else if (auctionStatus.equals("open")) {
            auctionStatus = "Auction Open";
        }
        Account userProfile = new Account(auctionItem.getSeller());
    %>
</div>
<%--<form action="answerProcess.jsp?qid=<%out.println(questionId);%>" method="POST">--%>
<form>
    <div class="container">
        <h2>Product: <%
            out.println(auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel());%></h2>
        <h2>Product Type: <%out.println(productType);%></h2>
        <h2>Auction Status: <span class="font-green"><%out.println(auctionStatus);%></span></h2>
        <h3>Seller Information: <a href="userProfile.jsp?userProfile=<%out.println(userProfile.getUsername());%>"><%
            out.println(userProfile.getUsername());%></a></h3>
        <hr>
        <h3>Condition: <%out.println(auctionItem.getCondition());%></h3>
        <%if (productType.equalsIgnoreCase("car")) { %>
            <% Car car = new Car(auctionItem.getListingId());%>
            <h3>Mileage: <%out.println(car.getMileage());%></h3>
        <%} else if (productType.equalsIgnoreCase("boat")) {%>
            <%Boat boat = new Boat(auctionItem.getListingId());%>
            <h3>Engine Type: <%out.println(boat.getEngineType());%></h3>
        <%} else if (productType.equalsIgnoreCase("plane")) {%>
            <%Aircraft aircraft = new Aircraft(auctionItem.getListingId());%>
            <h3>Engine Hours: <%out.println(aircraft.getEngineHours());%></h3>
        <%}%>
        <div class="signin">
            <p><a href="auctionList.jsp">Go back to list of auctions</a>.</p>
        </div>
    </div>
</form>
<% } %>
</body>

</html>