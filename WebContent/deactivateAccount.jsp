<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
	<!DOCTYPE html>
	<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>BuyMe</title>
		<script>
			var check = function () {
				if (document.getElementById('pswDelete').value ==
					document.getElementById('pswDeleteConfirmation').value) {
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
		<% if(session.getAttribute("user")==null) { response.sendRedirect("index.jsp"); } else { %>
			<div class="container">
				<form action="deactivateAccountProcess.jsp" method="POST">
					<h1>Deactivate Your Account</h1>
					<hr>

					<label for="userNameDeactivate"><b>Username</b></label>
					<input type="text" placeholder="Enter Username" name="userNameDeactivate" id="userNameDeactivate" required>

					<label for="pswDeactivate"><b>Password</b></label>
					<input type="password" placeholder="Enter Password" name="pswDeactivate" id="pswDeactivate" onkeyup='check();'
						required>

					<label for="pswDeactivateConfirmation"><b>Confirm Password</b></label>
					<input type="password" placeholder="Confirm Password" name="pswDeactivateConfirmation" id="pswDeactivateConfirmation"
						onkeyup='check();' required>
					<br>
					<span id='message'></span>
					<hr>

					<button type="submit" class="deactivatebtn">Deactivate Account</button>
				</form>

			</div>
			<% } %>
	</body>

	</html>