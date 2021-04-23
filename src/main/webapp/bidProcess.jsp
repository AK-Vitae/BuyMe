<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="util.*" %>

<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.Account" %>
<%@ page import="util.Bid" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>

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
<%
    Database db = new Database();
    Connection conn = null;
    Connection conn2 = null;
    PreparedStatement ps = null;
   // PreparedStatement ps2 = null;
    ResultSet rs = null;
    Statement st = null;
	boolean sendA= false;
    //out.println("in bidProcess");
    Account userAccount = (Account) session.getAttribute("userAccount");
   // AuctionItem auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));

    //Bid bid = new Bid(Integer.parseInt(request.getParameter("listingId")), Double.parseDouble(request.getParameter("bid")));
       
    //AuctionItem item = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));
    //out.println("listingID:   "+ listingID);
    //int listingID= item.getListingId(); 
    String auctionStatus= request.getParameter("status");
    //out.println("Auction Status:   "+ auctionStatus);
    double bidValue = Double.parseDouble(request.getParameter("bid"));
    //out.println("	bid:   "+ bidValue);
    
    int bidder = userAccount.getAccountNumber();
	double maxBid = 0;
    int listingID = Integer.parseInt(request.getParameter("listingId"));
    //out.println("	ID:   "+ listingID);
    try {
    	conn = db.getConnection();
        st = conn.createStatement();
    	//out.println("in Try");

        rs = st.executeQuery("SELECT MAX(bidValue) FROM bid WHERE listingID =" + listingID + ";");
        //out.println("sent query");
        rs.next();
        maxBid = rs.getDouble("MAX(bidValue)");
    	//out.println("\n    Max bid:" + maxBid);
    	//rs.close();
/*
        if (!rs.next()) {
            out.print("<h2>No bids placed for this auction</h2>");
        } else {
            maxBid = rs.getDouble("MAX(bidValue)");
        	out.println("\n    Max bid:" + maxBid);

        }
   */     
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
    //out.println("We past the try1 :)");

    try {
    	//out.println("in Try2");
    	conn2 = db.getConnection();
        //st2 = conn2.createStatement();
    	//out.println("connected \n");

        
        if (maxBid >= bidValue){
        	//out.println("too low");
        	%><form>
            <input type="hidden" id="status" name="status" value="<%out.print("open");%>"> 
			<input type="hidden" id="listingId" name="listingId" value="<%out.print(listingID);%>">                    
			<button type="submit" class="loginbtn" formaction="auctionDetails.jsp">Bid was too low. Go back to  Item</button>
             <!-- <p><a href="bidProcess.jsp?bid=bid&listingId=<%//out.print(auctionItem.getListingId());%>">Place Bid</a></p>-->

            </form><%
        	
        	//out.println("<div><p>Bid Amount Too Low<br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
        	
        }else{
        	
	        String query2 = "INSERT INTO bid (listingID, bidder, bidValue, bidDate) VALUES (?, ?, ?, now());";
	    	//out.println("inserted");

	        ps = conn2.prepareStatement(query2);
	        ps.setInt(1, listingID);
	        ps.setInt(2, bidder);
	        ps.setDouble(3, bidValue);
	        //out.println("values        ");
	        int resultBid= ps.executeUpdate();
	        //out.println("    executed       ");
	        if (resultBid < 1) {
	        	out.println("failed");
	        	out.println("<div class=\"container signin\"><p>There was a problem submitting your bid<br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");

	        
	        
	        } 
	        else {
	        	//out.println("succeeded");
	            out.println("<div class=\"container signin\"><p>Your Bid of $"+ bidValue +" has been submitted <br><a href=\" auctionList.jsp\">Go back to the list of auctions</a>.</p> </div>");
	            //sendA = true;
	            %><%@ include file="sendAlert.jsp" %><%
	        }
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
            if (conn2 != null) db.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //out.println("We past the try2 :)");
	
%>
</body>

</html>