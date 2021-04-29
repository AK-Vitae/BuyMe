# BuyMe
![buyme](https://raw.githubusercontent.com/AK-Vitae/ak-website/main/images/BuyMe.png)
## Project Description

BuyMe is a relational database system with a corresponding front-end that has the functionality of an online auction system. This is a Full Stack application developed with Java (JSP, JDBC), SQL (MySQL), and HTML/CSS/JavaScript(jQuery). BuyMe started as a simple ER diagram but was quickly translated into a DB schema in MySQL and was ultimately implemented as a dynamic web project using IntelliJ/Eclipse.

Future optimizations would be the inclusions of JSTL tags and Servlets or converting the whole project into a React/Spring context.

## Features

- Allows users to create, edit, and deactivate accounts
- Sellers can create auctions and posts items for sale
- A buyer can manually or auto-bid on a product and is informed when someone bids higher than them or wins the auction.
- Users can browse through items (filtered search using a search bar) and see the status of the current bidding
- Users can the transaction history of other users and set up alerts for when a product they are interested in becomes available
- The admin account can create new customer representative accounts and generate sales reports according to different criteria
- Users can post a public question that will be answered by a customer representative
- Customer representatives can remove bids, remove auctions, and edit/delete user accounts

## Features

* Please use **Google Chrome** as the browser for running the project

* Add your own content to **db.properties** in the database package

  * ```
    src
       ┗ database
         ┣ Database.java
       ┗ db.properties // Add your own file
    ```

  * Contents of **db.properties**

    * ```
      username = yourMySQLUsername //e.g. root
      password = yourMySQLPassword //e.g. password
      ```

    * **Do not** use " " or ' ', just plain text

* Add your **Tomcat Server** (if needed): 

  * Download from http://tomcat.apache.org/
  * Further instructions: https://www.codejava.net/servers/tomcat/how-to-add-tomcat-server-in-eclipse-ide

* Set Tomcat admin port (if needed)

- Set HTTP/1.1 (if needed)

  * Add your own **mysql-connector-java jar** to WebContent/WEB-INF/lib/ (if needed):

    * Or add jar file as a **Web App library**

  * In case automatic import doesn't work please copy over into a new **dynamic web project**:

    *  **src**

    *  **WebContent**

## Project Structure

```
📦BuyMe
 ┣ 📂sql
 ┃ ┣ 📜buyme.sql
 ┃ ┗ 📜buymeSimplified.sql
 ┣ 📂src
 ┃ ┣ 📂database
 ┃ ┃ ┣ 📜Database.java
 ┃ ┃ ┗ 📜db.properties
 ┃ ┗ 📂util
 ┃ ┃ ┣ 📜Account.java
 ┃ ┃ ┣ 📜Aircraft.java
 ┃ ┃ ┣ 📜Alert.java
 ┃ ┃ ┣ 📜AuctionItem.java
 ┃ ┃ ┣ 📜Bid.java
 ┃ ┃ ┣ 📜Boat.java
 ┃ ┃ ┣ 📜Car.java
 ┃ ┃ ┣ 📜CheckAutoBids.java
 ┃ ┃ ┣ 📜CheckListings.java
 ┃ ┃ ┣ 📜QuestionAnswer.java
 ┃ ┃ ┗ 📜WishlistItem.java
 ┣ 📂WebContent
 ┃ ┣ 📂css
 ┃ ┃ ┗ 📜main.css
 ┃ ┣ 📂js
 ┃ ┃ ┗ 📜main.js
 ┃ ┣ 📂META-INF
 ┃ ┃ ┗ 📜MANIFEST.MF
 ┃ ┣ 📂WEB-INF
 ┃ ┃ ┣ 📂lib
 ┃ ┃ ┃ ┗ 📜mysql-connector-java-8.0.23.jar
 ┃ ┃ ┗ 📜web.xml
 ┃ ┣ 📜accountProcess.jsp
 ┃ ┣ 📜alertList.jsp
 ┃ ┣ 📜alertMarkAs.jsp
 ┃ ┣ 📜answerProcess.jsp
 ┃ ┣ 📜auction.jsp
 ┃ ┣ 📜auctionAircraft.jsp
 ┃ ┣ 📜auctionBoat.jsp
 ┃ ┣ 📜auctionCar.jsp
 ┃ ┣ 📜auctionClosedCheck.jsp
 ┃ ┣ 📜auctionDelete.jsp
 ┃ ┣ 📜auctionDetails.jsp
 ┃ ┣ 📜auctionList.jsp
 ┃ ┣ 📜auctionProcess.jsp
 ┃ ┣ 📜auctionSimilarItems.jsp
 ┃ ┣ 📜autobidPlace.jsp
 ┃ ┣ 📜autobidPlaceProcess.jsp
 ┃ ┣ 📜bidAlertSend.jsp
 ┃ ┣ 📜bidDelete.jsp
 ┃ ┣ 📜bidHistory.jsp
 ┃ ┣ 📜bidPlaceProcess.jsp
 ┃ ┣ 📜createCustomerRepAccount.jsp
 ┃ ┣ 📜deactivateAccount.jsp
 ┃ ┣ 📜deactivateAccountProcess.jsp
 ┃ ┣ 📜editAccountInformation.jsp
 ┃ ┣ 📜index.jsp
 ┃ ┣ 📜login.jsp
 ┃ ┣ 📜loginProcess.jsp
 ┃ ┣ 📜logout.jsp
 ┃ ┣ 📜navigationBar.jsp
 ┃ ┣ 📜profile.jsp
 ┃ ┣ 📜question.jsp
 ┃ ┣ 📜questionDetails.jsp
 ┃ ┣ 📜questionProcess.jsp
 ┃ ┣ 📜questionsAndAnswers.jsp
 ┃ ┣ 📜register.jsp
 ┃ ┣ 📜salesReport.jsp
 ┃ ┣ 📜salesReportProcess.jsp
 ┃ ┣ 📜transactionHistory.jsp
 ┃ ┣ 📜userProfile.jsp
 ┃ ┣ 📜wishlist.jsp
 ┃ ┣ 📜wishlistAdd.jsp
 ┃ ┗ 📜wishlistProcess.jsp
 ┣ 📜.classpath
 ┣ 📜.gitignore
 ┣ 📜.project
 ┣ 📜BuyMe.iml
 ┗ 📜README.md
```

