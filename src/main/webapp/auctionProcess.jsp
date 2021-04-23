<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.Account" %>
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
    PreparedStatement ps = null;
    Account userAccount = (Account) session.getAttribute("userAccount");
    String productId = request.getParameter("productID");
    String type = request.getParameter("type");
    double listPrice = Double.parseDouble(request.getParameter("listPrice"));
    double minSellPrice = Double.parseDouble(request.getParameter("minSellPrice"));
    String exteriorColor = request.getParameter("exteriorColor");
    String interiorColor = request.getParameter("interiorColor");
    String model = request.getParameter("model");
    String manufacturer = request.getParameter("manufacturer");
    String condition = request.getParameter("condition");
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    String closingDate = request.getParameter("closingDate")+" "+request.getParameter("closingTime");
    int year = Integer.parseInt(request.getParameter("year"));
    int seller = userAccount.getAccountNumber();

    try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        // Build the SQL query with placeholders for parameters

        String query = "INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,now(),?);";
        ps = conn.prepareStatement(query);

        // Add parameters to query
        ps.setString(1, productId);
        ps.setString(2, type);
        ps.setDouble(3, listPrice);
        ps.setDouble(4, minSellPrice);
        ps.setString(5, exteriorColor);
        ps.setString(6, interiorColor);
        ps.setString(7, model);
        ps.setString(8, manufacturer);
        ps.setString(9, condition);
        ps.setInt(10, capacity);
        ps.setString(11, closingDate);
        ps.setInt(12, year);
        ps.setInt(13, seller);

        int resultAuction;
        int resultAuctionCar;
        int resultAuctionBoat;
        int resultAuctionAircraft;
        resultAuction = ps.executeUpdate();

        if (type.equalsIgnoreCase("car")) {
            String fuelType = request.getParameter("fuelType");
            int mileage = Integer.parseInt(request.getParameter("mileage"));
            String driveType = request.getParameter("driveType");
            String bodyType = request.getParameter("bodyType");
            String transmission = request.getParameter("transmission");

            String queryCar = "INSERT INTO car (listingID, fuelType, mileage, driveType, bodyType, transmission) VALUES (LAST_INSERT_ID(),?,?,?,?,?);";
            ps = conn.prepareStatement(queryCar);

            ps.setString(1, fuelType);
            ps.setInt(2, mileage);
            ps.setString(3, driveType);
            ps.setString(4, bodyType);
            ps.setString(5, transmission);

            resultAuctionCar = ps.executeUpdate();
            if (resultAuctionCar < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem creating your Car auction <br><a href=\"auction.jsp\">Try Again</a>.</p> </div>");
            }
        } else if (type.equalsIgnoreCase("boat")) {
            String engineType = request.getParameter("engineType");
            String boatType = request.getParameter("boatType");
            String hullMaterial = request.getParameter("hullMaterial");
            String primaryFuelType = request.getParameter("primaryFuelType");

            String queryBoat = "INSERT INTO boat (listingID, engineType, boatType, hullMaterial, primaryFuelType) VALUES (LAST_INSERT_ID(),?,?,?,?);";
            ps = conn.prepareStatement(queryBoat);

            ps.setString(1, engineType);
            ps.setString(2, boatType);
            ps.setString(3, hullMaterial);
            ps.setString(4, primaryFuelType);

            resultAuctionBoat = ps.executeUpdate();
            if (resultAuctionBoat < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem creating your Boat auction <br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
            }
        } else if (type.equalsIgnoreCase("aircraft")) {
            String airCategory = request.getParameter("airCategory");
            int engineHours = Integer.parseInt(request.getParameter("engineHours"));
            String avionics = request.getParameter("avionics");

            String queryAircraft = "INSERT INTO aircraft (listingID, airCategory, engineHours, avionics) VALUES (LAST_INSERT_ID(),?,?,?);";
            ps = conn.prepareStatement(queryAircraft);

            ps.setString(1, airCategory);
            ps.setInt(2, engineHours);
            ps.setString(3, avionics);

            resultAuctionAircraft = ps.executeUpdate();
            if (resultAuctionAircraft < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem creating your Aircraft auction <br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
            }
        }

        if (resultAuction < 1) {
            out.println("<div class=\"container signin\"><p>There was a problem creating your auction <br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
        } else {
            out.println("<div class=\"container signin\"><p>Your auction was created <br><a href=\" auctionList.jsp\">Go back to the list of auctions</a>.</p> </div>");
        }
    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
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