<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <script>
            var check = function () {
                if (document.getElementById('psw').value ==
                    document.getElementById('pswConfirmation').value) {
                    document.getElementById('message').style.color = 'green';
                    document.getElementById('message').innerHTML = 'Passwords Match';
                } else {
                    document.getElementById('message').style.color = 'red';
                    document.getElementById('message').innerHTML = "Passwords Don't Match!";
                }
            }
        </script>
        <link rel="stylesheet" href="styles.css">
    </head>

    <body>
    <%@ include file = "navigationBar.jsp" %>
        <form action="regProcess.jsp" method="POST">
            <div class="container">
                <h1>Register</h1>
                <p>Please fill in this form to create a BuyMe account.</p>
                <hr>

                <label for="firstName"><b>First Name</b></label>
                <input type="text" placeholder="Enter First Name" name="firstName" id="firstName" required>

                <label for="lastName"><b>Last Name</b></label>
                <input type="text" placeholder="Enter Last Name" name="lastName" id="lastName" required>

                <label for="username"><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="username" id="username" required>

                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="psw" id="psw" onkeyup='check();' required>

                <label for="pswConfirmation"><b>Confirm Password</b></label>
                <input type="password" placeholder="Confirm Password" name="pswConfirmation" id="pswConfirmation"
                    onkeyup='check();' required>
                <br>
                <span id='message'></span>
                <br>
                
                <label for="email"><b>Email</b></label>
                <input type="text" placeholder="Enter Email" name="email" id="email" required>
                <hr>

                <button type="submit" class="registerbtn">Register</button>
            </div>

            <div class="container signin">
                <p>Already have an account? <a href="login.jsp">Sign in</a>.</p>
            </div>
        </form>

    </body>

    </html>