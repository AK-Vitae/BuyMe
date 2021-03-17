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
				<form action="deleteAccountProcess.jsp" method="POST">
					<h1>Delete Your Account</h1>
					<hr>

					<label for="userNameDelete"><b>Username</b></label>
					<input type="text" placeholder="Enter Username" name="userNameDelete" id="username" required>

					<label for="pswDelete"><b>Password</b></label>
					<input type="password" placeholder="Enter Password" name="pswDelete" id="pswDelete" onkeyup='check();'
						required>

					<label for="pswDeleteConfirmation"><b>Confirm Password</b></label>
					<input type="password" placeholder="Confirm Password" name="pswDeleteConfirmation" id="pswDeleteConfirmation"
						onkeyup='check();' required>
					<br>
					<span id='message'></span>
					<hr>

					<button type="submit" class="deletebtn">Delete Account</button>
				</form>

			</div>
			<% } %>
	</body>

	</html>