<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoggedIn</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>

<%
session.invalidate();
response.sendRedirect("index.jsp");
%>

</form>

</body>

</html>