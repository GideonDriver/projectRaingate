<html>
<head>
<title>Raingate</title>
<link type="text/css" rel="stylesheet" href="styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script type="text/javascript">
function returnToLogin() {
    var form = document.createElement("form");
    var element1 = document.createElement("input"); 
    var element2 = document.createElement("input");  

    form.method = "POST";
    form.action = "LoginController";   

    element1.value="<%= session.getAttribute("email") %>";
    element1.name="email";
    form.appendChild(element1);  

    element2.value="<%= session.getAttribute("password") %>";
    element2.name="password";
    form.appendChild(element2);

    document.body.appendChild(form);

    form.submit();
}
</script>
</head>
<body onload="returnToLogin()">
<center>
		<img alt="Raingate Logo" src="Raingate-logos\Raingate-logos_white.png" height=200px onclick="location.href = 'index.jsp';">
		<hr class="opacity-100" style="height:2px;width:300px;background-color:white">
		<h1>
			<font face="comic sans ms" class="text-light">Processing...</font>
		</h1>
		<hr class="opacity-100" style="height:2px;width:300px;background-color:white">


<button type="button" onclick="returnToLogin()" class="btn btn-primary btn-lg" >Back</button>

</center>
</body>
</html>
