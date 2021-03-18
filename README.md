# BuyMe

## Project Structure

```
📦BuyMe
 ┣ 📂.idea // Don't Need this for Eclipse
 ┣ 📂sql
 ┃ ┗ 📜loginTest.sql
 ┣ 📂src
 ┃ ┗ 📂database
 ┃ ┃ ┣ 📜Database.java
 ┃ ┃ ┗ 📜db.properties // Add your own file
 ┣ 📂WebContent
 ┃ ┣ 📂META-INF
 ┃ ┃ ┗ 📜MANIFEST.MF
 ┃ ┣ 📂WEB-INF
 ┃ ┃ ┣ 📂lib
 ┃ ┃ ┃ ┗ 📜mysql-connector-java-8.0.23.jar // Add your own jar file
 ┃ ┃ ┗ 📜web.xml
 ┃ ┣ 📜deleteAccount.jsp
 ┃ ┣ 📜deleteAccountProcess.jsp
 ┃ ┣ 📜index.jsp
 ┃ ┣ 📜login.jsp
 ┃ ┣ 📜loginProcess.jsp
 ┃ ┣ 📜logout.jsp
 ┃ ┣ 📜navigationBar.jsp
 ┃ ┣ 📜register.jsp
 ┃ ┣ 📜regProcess.jsp
 ┃ ┣ 📜styles.css
 ┃ ┗ 📜success.jsp
 ┣ 📜.classpath
 ┣ 📜.gitignore
 ┣ 📜.project
 ┣ 📜BuyMe.iml // Don't Need this for Eclipse
 ┗ 📜README.md
```


* Add your own db.properties to database package

  * Contents of db.properties

    ```
    username = yourMySQLUsername //e.g. root
    password = yourMySQLPassword //e.g. password
    ```
  
* Add your own mysql-connector-java jar to WebContent/WEB-INF/lib/


  * Or add jar file as external library (IntelliJ)