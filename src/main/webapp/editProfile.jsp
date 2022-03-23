<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Profile</title>
<link type="text/css" rel="stylesheet" href="styles.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script type="text/javascript">
function signUpValidate(){

	var firstName = document.signupform.firstName.value;
	var lastName = document.signupform.lastName.value;
	var email = document.signupform.email.value;
	var password = document.signupform.password.value;
	var confirmPassword = document.signupform.confirmPassword.value;
	
	errFirstName.innerHTML = "";
	errLastName.innerHTML = "";
	errEmail.innerHTML = "";
	errPassword.innerHTML = "";
	errConfirmPassword.innerHTML = "";

	//alert("1");

	var error = 0;

	if (firstName.length == 0) {
		errFirstName.innerHTML = "<font class=\"alert alert-danger\">*Missing first name</font>";
		error = 1;
	} else	if (firstName.length > 20) {
		errFirstName.innerHTML = "<font class=\"alert alert-danger\">*Max of 20 characters</font>";
		error = 1;
	}
	//alert("2");
	
	if (lastName.length == 0) {
		errLastName.innerHTML = "<font class=\"alert alert-danger\">*Missing last name</font>";
		error = 1;
	} else	if (lastName.length > 20) {
		errLastName.innerHTML = "<font class=\"alert alert-danger\">*Max of 20 characters</font>";
		error = 1;
	}
	//alert("3");
	
	if (email.length == 0) {
		errEmail.innerHTML = "<font class=\"alert alert-danger\">*Missing email</font>";
		error = 1;
	} else	if (email.length > 40) {
		errEmail.innerHTML = "<font class=\"alert alert-danger\">*Max of 40 characters</font>";
		error = 1;
	}
	//alert("4");
	
	if (password.length == 0) {
		errPassword.innerHTML = "<font class=\"alert alert-danger\">*Missing password</font>";
		error = 1;
	} else if (password.length < 6 || password.length > 20) {
		errPassword.innerHTML = "<font class=\"alert alert-danger\">*Length must be 6-20</font>";
		error = 1;
	}
	//alert("5");
	
	if (confirmPassword.length == 0) {
		errConfirmPassword.innerHTML = "<font class=\"alert alert-danger\">*Missing password</font>";
		error = 1;
	} else if (confirmPassword != password) {
		errConfirmPassword.innerHTML = "<font class=\"alert alert-danger\">*Passwords must match</font>";
		error = 1;
	}

	//alert("6");
	
	if (error > 0) {
		//alert("false");
		return false;
	} else {
		//alert("true");
		return true;
	}
}

</script>
</head>
<body>
	<center>
		<img alt="Raingate Logo" src="Raingate-logos\Raingate-logos_white.png"
			height=200px onclick="location.href = 'index.jsp';">
		<hr class="opacity-100"
			style="height: 2px; width: 300px; background-color: white">
		<h1>
			<font face="comic sans ms" class="text-light">Edit Profile</font>
		</h1>
		<hr class="opacity-100"
			style="height: 2px; width: 300px; background-color: white">


		<table cellspacing="10" cellpadding="1" border="0" width="900px">
			<tr>
				<td width="250px">
				</td>
				<td>


					<form action="SignupController" name="signupform"
						onsubmit="return signUpValidate()" method="get">

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">First
									Name:</span>
							</div>
							<input type="text" class="form-control" id="firstName"
								name="firstName" value="<%= session.getAttribute("firstName") %>" placeholder="first name">
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">Last
									Name:</span>
							</div>
							<input type="text" class="form-control" id="lastName"
								name="lastName" value="<%= session.getAttribute("lastName") %>" placeholder="last name">
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">Email:</span>
							</div>
							<input type="email" class="form-control" id="email" name="email" value="<%= session.getAttribute("email") %>"
								placeholder="email">
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">Password:</span>
							</div>
							<input type="password" class="form-control" id="password"
								name="password" placeholder="password">
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1">Confirm
									Password:</span>
							</div>
							<input type="password" class="form-control" id="confirmPassword"
								name="confirmPassword" placeholder="confirm password">
						</div>

						<br />
						<center>
							<input type="button" onclick="location.href = 'back.jsp';"
								class="btn btn-secondary" value="Cancel">&nbsp;&nbsp; <input
								type="submit" class="btn btn-primary" value="Update">
						</center>
					</form>

				</td>
				<td width="250px">
					<div>
						<span id="errFirstName"></span>
					</div> <br />
					<div>
						<span id="errLastName"></span>
					</div> <br />
					<div>
						<span id="errEmail"></span>
					</div> <br />
					<div>
						<span id="errPassword"></span>
					</div> <br />
					<div>
						<span id="errConfirmPassword"></span>
					</div>
				</td>
			</tr>
		</table>

	</center>
</body>
</html>