<html>
<head>
<title>Raingate</title>
<link type="text/css" rel="stylesheet" href="styles.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script type="text/javascript">
	(function(window, document, undefined) {

		window.onload = init;
		function init() {
			if (
<%=session.getAttribute("active")%>
	) {
			} else {
				document.getElementById("userInfo").style.display = 'none';
			}
		}
	})(window, document, undefined);
</script>
</head>
<body>
	<center>
		<img alt="Raingate Logo" src="Raingate-logos\Raingate-logos_white.png"
			height=200px onclick="location.href = 'index.jsp';">
		<hr class="opacity-100"
			style="height: 2px; width: 300px; background-color: white">
		<div id="userInfo">
			<table cellpadding="4">
				<tr>
					<td rowspan="2">
						<h3>
							<font face="comic sans ms" class="text-light"> <%=session.getAttribute("firstName")%>
								<%=session.getAttribute("lastName")%></font>&nbsp;
						</h3>
					</td>
					<td>
						<button onclick="logout()" id="logout"
							class="btn btn-warning btn-sm">Logout</button>
					</td>
				</tr>
				<tr>
					<td>
						<button onclick="location.href = 'editProfile.jsp'"
							id="logout" class="btn btn-warning btn-sm">Edit Profile</button>
					</td>
				</tr>
			</table>

			<hr class="opacity-100"
				style="height: 2px; width: 300px; background-color: white">

		</div>

	</center>
</body>
</html>
