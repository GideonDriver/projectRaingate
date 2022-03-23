<%@page import="com.training.ers.dao.LoginDAOImpl"%>
<%@page import="com.training.ers.dao.LoginDAO"%>
<%@page import="io.opentelemetry.exporter.logging.SystemOutLogExporter"%>
<%@page import="org.apache.commons.lang3.concurrent.ConcurrentUtils"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.training.ers.model.User"%>
<%@page import="com.training.ers.model.Reimbursement"%>
<%@page import="java.util.List"%>
<%@page import="com.training.ers.dao.RequestsDAOImpl"%>
<%@page import="com.training.ers.dao.RequestsDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Menu</title>
<link type="text/css" rel="stylesheet" href="styles.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script type="text/javascript">
	function logout() {
		session = null;
		location.href = 'index.jsp';
	}
	function reload() {
		location.reload();
	}
	function updateRequest(requestId, status) {
		console.log(status+": "+requestId);
	    var form = document.createElement("form");
	    var element1 = document.createElement("input"); 
	    var element2 = document.createElement("input");  

	    form.method = "POST";
	    form.action = "RequestController";   

	    element1.value=requestId;
	    element1.name="reimbursementId";
	    form.appendChild(element1);  

	    element2.value=status;
	    element2.name="status";
	    form.appendChild(element2);

	    document.body.appendChild(form);

	    form.submit();
		
	}
	
	function navReset() {
		document.getElementById("pendingRequests").style.display = 'none';
		document.getElementById("resolvedRequests").style.display = 'none';
		document.getElementById("requestsByEmployee").style.display = 'none';
		document.getElementById("employeeInfo").style.display = 'none';
		document.getElementById("navBtn1").classList.remove('active');
		document.getElementById("navBtn2").classList.remove('active');
		document.getElementById("navBtn3").classList.remove('active');;
		document.getElementById("navBtn4").classList.remove('active');
	}
	function showPendingRequests() {
		navReset();
		document.getElementById("pendingRequests").style.display = 'block';
		document.getElementById("navBtn1").classList.add('active');
	}
	function showResolvedRequests() {
		navReset();
		document.getElementById("resolvedRequests").style.display = 'block';
		document.getElementById("navBtn2").classList.add('active');
	}
	function showRequestsByEmployee() {
		navReset();
		document.getElementById("requestsByEmployee").style.display = 'block';
		document.getElementById("navBtn3").classList.add('actve');
	}
	function showEmployeeInfo() {
		navReset();
		document.getElementById("employeeInfo").style.display = 'block';
		document.getElementById("navBtn4").classList.add('actve');
	}
</script>
<style type="text/css">
</style>
</head>
<body>
	<center>
		<table cellspacing="10" cellpadding="1" border="0">
			<td width="1000px" align="center">
				<%
				LoginDAO loginDAO = new LoginDAOImpl();
				RequestsDAO requestsDAO = new RequestsDAOImpl();
				
				List<Reimbursement> pendingRequests = requestsDAO.viewPendingRequests((int) session.getAttribute("userId"));
				Iterator<Reimbursement> iteratorPending = pendingRequests.iterator();
				List<Reimbursement> resolvedRequests = requestsDAO.viewResolvedRequests((int) session.getAttribute("userId"));
				Iterator<Reimbursement> iteratorResolved = resolvedRequests.iterator();

				List<User> employees = loginDAO.getEmployees((int) session.getAttribute("userId"));
				Iterator<User> iteratorEmployees = employees.iterator();
				%>

				<div class="btn-group" role="group" aria-label="Basic example">
					<button type="button" id="navBtn1" onclick="showPendingRequests()" class="btn btn-secondary active">Pending Requests</button>
					<button type="button" id="navBtn2" onclick="showResolvedRequests()" class="btn btn-secondary">Resolved Requests</button>
					<button type="button" id="navBtn3" onclick="showRequestsByEmployee()" class="btn btn-secondary">Requests by Employee</button>
					<button type="button" id="navBtn4" onclick="showEmployeeInfo()" class="btn btn-secondary">All Employee Info</button>
				</div>


				<div id="pendingRequests" style="display:block;">

					<br />

					<table class="table table-striped table-dark">
						<tr>
							<th>Request Id</th>
							<th>User Id</th>
							<th>Reason</th>
							<th>Amount</th>
							<th>Note</th>
							<th>Status</th>
							<th>Timestamp</th>
						</tr>
						<%
						while (iteratorPending.hasNext()) {
							Reimbursement pendingRequest = iteratorPending.next();
						%>
						<tr>
							<td><%=pendingRequest.getReimbursementId()%></td>
							<td><%=pendingRequest.getRequesterId() %></td>
							<td><%=pendingRequest.getReason()%></td>
							<td><%=pendingRequest.getFormattedAmount()%></td>
							<td><%=(pendingRequest.getNote() == null) ? "NA" : pendingRequest.getNote()%></td>
							<td>
								<button type="button" onclick="updateRequest(<%=pendingRequest.getReimbursementId()%>, 'approve')" class="btn btn-success btn-sm">Approve</button>
								<button type="button" onclick="updateRequest(<%=pendingRequest.getReimbursementId()%>, 'deny')" class="btn btn-danger btn-sm">Deny</button>
							</td>
							<td><%=pendingRequest.getDateTime().substring(0, 19)%></td>
						</tr>
						<%
						}
						%>
					</table>


				</div>
				<div id="resolvedRequests" style="display:none;">

					<br />

					<table class="table table-striped table-dark">
						<tr>
							<th>Request Id</th>
							<th>User Id</th>
							<th>Reason</th>
							<th>Amount</th>
							<th>Note</th>
							<th>Status</th>
							<th>Timestamp</th>
						</tr>
						<%
						while (iteratorResolved.hasNext()) {
							Reimbursement resolvedRequest = iteratorResolved.next();
						%>
						<tr>
							<td><%=resolvedRequest.getReimbursementId()%></td>
							<td><%=resolvedRequest.getRequesterId() %></td>
							<td><%=resolvedRequest.getReason()%></td>
							<td><%=resolvedRequest.getFormattedAmount()%></td>
							<td><%=(resolvedRequest.getNote() == null) ? "NA" : resolvedRequest.getNote()%></td>
							<td><%=resolvedRequest.getStatus()%></td>
							<td><%=resolvedRequest.getDateTime().substring(0, 19)%></td>
						</tr>
						<%
						}
						%>
					</table>


				</div>
				<div id="requestsByEmployee" style="display:none;">

				</div>
				<div id="employeeInfo" style="display:none;">

					<br />

					<table class="table table-striped table-dark">
						<tr>
							<th>User Id</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Email</th>
							<!-- <th>Account Type</th> -->
							<th>Active</th>
						</tr>
						<%
						while (iteratorEmployees.hasNext()) {
							User employee = iteratorEmployees.next();
						%>
						<tr>
							<td><%=employee.getUserId()%></td>
							<td><%=employee.getFirstName() %></td>
							<td><%=employee.getLastName()%></td>
							<td><%=employee.getEmail()%></td>
							<%-- <td><%=employee.getAccountType()%></td> --%>
							<td><%=employee.isActive()%></td>
						</tr>
						<%
						}
						%>
					</table>


				</div>
			</td>
		</table>

	</center>
</body>
</html>