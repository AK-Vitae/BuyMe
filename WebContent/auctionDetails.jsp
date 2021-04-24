<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="util.*" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.Account" %>
<%@ page import="util.Bid" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>
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
    <%
        AuctionItem auctionItem;
        auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));
        ArrayList<AuctionItem> recentlyViewedAuctions;
        if ((session.getAttribute("recentlyViewedAuctions") != null)) {
            recentlyViewedAuctions = (ArrayList<AuctionItem>) session.getAttribute("recentlyViewedAuctions");
        } else {
            recentlyViewedAuctions = new ArrayList<>();
        }
        recentlyViewedAuctions.add(auctionItem);
        session.setAttribute("recentlyViewedAuctions", recentlyViewedAuctions);
        out.print("<h1> Listing ID: " + auctionItem.getListingId() + "</h1>");
        out.print("<h1> Auction created on " + auctionItem.getListDate() + "</h1>");
        out.print("<hr>");
        String productType = auctionItem.getType();
        // Finding if the auction ended or is still open
        boolean isCompleted = false;
        String auctionStatus;
        auctionStatus = request.getParameter("status");
        String auctionStatusColor = null;
        String closingDateHeader = null;
        if (auctionStatus.equals("completed")) {
            isCompleted = true;
            auctionStatus = "Auction Completed";
            auctionStatusColor = "font-red";
            closingDateHeader = "Auction completed on " + auctionItem.getClosingDate();
        } else if (auctionStatus.equals("open")) {
            auctionStatus = "Auction Open";
            auctionStatusColor = "font-green";
            closingDateHeader = "Auction Closing Date: " + auctionItem.getClosingDate();
        }
        Account userProfile = new Account(auctionItem.getSeller());
        //Get Most Recent Bid
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        Locale locale = new Locale("en", "US");
        NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
        double bidValue = 0;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();
            int listingId = auctionItem.getListingId();
            rs = st.executeQuery("SELECT * FROM bid WHERE listingID='" + listingId + "' ORDER BY bidDate DESC LIMIT 1;");
            if (!rs.next()) {
//                out.print("<h2>No bids placed for this auction</h2>");
            } else {
                bidValue = rs.getDouble("bidValue");
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
                if (st != null) st.close();
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
</div>
<form>
    <div class="container">
        <h2>Auction Status: <span class=<%out.println(auctionStatusColor);%>><%out.println(auctionStatus);%></span></h2>
        <h2>Product(<%out.print(productType);%>): <%
            out.println(auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel());%></h2>
        <h2><%out.println(closingDateHeader);%></h2>
        <h3>Seller Information: <a href="userProfile.jsp?userProfile=<%out.println(userProfile.getUsername());%>"><%
            out.println(userProfile.getUsername());%></a></h3>
        <hr>

        <div class="flex-container">

            <div class="flex-child">
                <h3>Product Details</h3>
                <ul>
                    <li><h4><span class="strong">Condition</span>: <%out.println(auctionItem.getCondition());%></h4>
                    </li>
                    <li><h4><span class="strong">Product ID (VIN#, HIN#, Tail#, etc)</span>: <%
                        out.println(auctionItem.getProductId());%></h4></li>
                    <li><h4><span class="strong">Exterior Color</span>: <%out.println(auctionItem.getExteriorColor());%>
                    </h4></li>
                    <li><h4><span class="strong">Interior Color</span>: <%out.println(auctionItem.getInteriorColor());%>
                    </h4></li>
                    <li><h4><span class="strong">Capacity</span>: <%out.println(auctionItem.getCapacity());%></h4></li>
                    <%if (productType.equalsIgnoreCase("car")) { %>
                    <% Car car = new Car(auctionItem.getListingId());%>
                    <li><h4><span class="strong">Fuel Type</span>: <%out.println(car.getFuelType());%></h4></li>
                    <li><h4><span class="strong">Mileage</span>: <%out.println(car.getMileage());%></h4></li>
                    <li><h4><span class="strong">Drive Type</span>: <%out.println(car.getDriveType());%></h4></li>
                    <li><h4><span class="strong">Body Type</span>: <%out.println(car.getBodyType());%></h4></li>
                    <li><h4><span class="strong">Transmission</span>: <%out.println(car.getTransmission());%></h4></li>
                    <%} else if (productType.equalsIgnoreCase("boat")) {%>
                    <%Boat boat = new Boat(auctionItem.getListingId());%>
                    <li><h4><span class="strong">Engine Type</span>: <%out.println(boat.getEngineType());%></h4></li>
                    <li><h4><span class="strong">Boat Type</span>: <%out.println(boat.getBoatType());%></h4></li>
                    <li><h4><span class="strong">Hull Material</span>: <%out.println(boat.getHullMaterial());%></h4>
                    </li>
                    <li><h4><span class="strong">Primary Fuel Type</span>: <%out.println(boat.getPrimaryFuelType());%>
                    </h4></li>
                    <%} else if (productType.equalsIgnoreCase("aircraft")) {%>
                    <%Aircraft aircraft = new Aircraft(auctionItem.getListingId());%>
                    <li><h4><span class="strong">Air Category</span>: <%out.println(aircraft.getAirCategory());%></h4>
                    </li>
                    <li><h4><span class="strong">Engine Hours</span>: <%out.println(aircraft.getEngineHours());%></h4>
                    </li>
                    <li><h4><span class="strong">Avionics</span>: <%out.println(aircraft.getAvionics());%></h4></li>
                    <%}%>
                </ul>
            </div>

            <div class="flex-child" style="text-align: center;">
                <form>
                    <p>Current bid:<span style="font-weight:bold; font-size: 30px;"><%out.print(currency.format(bidValue));%></span></p>
                    <p>[<a href="bidHistory.jsp?listingId=<%out.print(auctionItem.getListingId());%>">View Bid History</a>]</p>
                    <%if (userAccount.getAccessLevel() == 3 && !userAccount.getUsername().equals(userProfile.getUsername())) {%>
                        <label for="bid">Enter your bid</label>
                        <%if (isCompleted) {%>
                        <input type="text" id="bid" name="bid" placeholder="Auction is Completed" disabled>
                        <%} else {%>
                        <input type="number" id="bid" name="bid" placeholder="Enter a Bid That is $<%out.print(bidValue+1.00);%> or Higher" min="<%out.print(bidValue+1.00);%>" step="0.01" required>
                        <input type="hidden" id="status" name="status" value="<%out.print(auctionStatus);%>">
                        <input type="hidden" id="listingId" name="listingId" value="<%out.print(auctionItem.getListingId());%>">
                        <button type="submit" class="loginbtn" formaction="bidProcess.jsp">Place Bid</button>
                        <%}%>
                    <%}%>
                </form>

                <%if (userAccount.getAccessLevel() == 3) {%>
                    <button class="wishlistbtn" onclick="location.href='index.jsp'" type="button">Add to Wishlist</button>
                <%}%>
            </div>


        </div>
        <%if (userAccount.getAccessLevel() == 2) {%>
        <button onclick="deleteAuction('<%out.print(auctionItem.getListingId());%>')" type="button"
                class="deactivatebtn">Delete this Auction
        </button>
        <%} else { %>

        <%} %>
        <br>
        <div class="signin">
            <p><a href="auctionList.jsp">Go back to list of auctions</a>.</p>
        </div>
    </div>
</form>
<% } %>
</body>

</html>