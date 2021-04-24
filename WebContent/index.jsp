<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.Account" %>
<%@ page import="java.text.ParseException" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <h1> BuyMe</h1>
    <hr>
    <a href="login.jsp">Login into your account</a>
    <br>
    <a href="register.jsp">Create your BuyMe account</a>
</div>
<%} else { %>
<div class="marginLeft-Right">
    <h1> BuyMe</h1>
    <hr>
    <% if ((session.getAttribute("recentlyViewedAuctions") != null)) {%>
    <h3>Recently Viewed Auctions</h3>
    <ul id="myUL">
        <%
            ArrayList<AuctionItem> recentlyViewedAuctions = (ArrayList<AuctionItem>) session.getAttribute("recentlyViewedAuctions");

            for (int i = recentlyViewedAuctions.size() - 1; i >= 0; i--) {
                AuctionItem auctionItem = recentlyViewedAuctions.get(i);
                String type = auctionItem.getType();
                Account auctionItemSeller = new Account(auctionItem.getSeller());

                Date date = new Date();
                String currentDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(date);
                String closingDate = auctionItem.getClosingDate();
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");

                String completed = "<li><a href=\"auctionDetails.jsp?status=completed&listingId=" + auctionItem.getListingId() + "\">"
                        + "Status: <span class=\"font-red\">Auction Completed<br></span>"
                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                        + "<br>Product Type: " + type
                        + "<br>Seller: " + auctionItemSeller.getUsername()
                        + "</a></li>";

                String open = "<li><a href=\"auctionDetails.jsp?status=open&listingId=" + auctionItem.getListingId() + "\">"
                        + "Status: <span class=\"font-green\">Auction Open<br></span>"
                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                        + "<br>Product Type: " + type
                        + "<br>Seller: " + auctionItemSeller.getUsername()
                        + "</a></li>";
                try {
                    if (sdf.parse(closingDate).before(sdf.parse(currentDate))) {
                        out.println(completed);
                    } else {
                        out.println(open);
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        %>
    </ul>
    <%} else {%>
    <a href="auctionList.jsp">Check out the list of auctions</a>
    <br>
    <%}%>
</div>
<% } %>
</body>

</html>