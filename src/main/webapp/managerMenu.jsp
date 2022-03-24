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
	function runOnLoad() {
		navSelection()
		setStatusColor()
	}
	function setStatusColor() {
		var allDenied = document.querySelectorAll('.denied');
		var allApproved = document.querySelectorAll('.approved');
		var allPending = document.querySelectorAll('.pending');
		
		for (var i=0, max=allDenied.length; i < max; i++) {
			allDenied[i].innerHTML = '<span class=\"btn btn-danger btn-sm disabled\">Denied<span>';
		}
		for (var i=0, max=allApproved.length; i < max; i++) {
			allApproved[i].innerHTML = '<span class=\"btn btn-success btn-sm disabled\">Approved<span>';
		}
		for (var i=0, max=allPending.length; i < max; i++) {
			allPending[i].innerHTML = '<span class=\"btn btn-warning btn-sm disabled\">Pending<span>';
		}
	}
	function logout() {
		session = null;
		location.href = 'index.jsp';
	}
	function reload() {
		location.reload();
	}
	function updateRequest(requestId, status) {
		console.log(status+": "+requestId);
	    var updateRequestForm = document.createElement("form");
	    var element1 = document.createElement("input"); 
	    var element2 = document.createElement("input");  
	    var element3 = document.createElement("input");  

	    updateRequestForm.method = "POST";
	    updateRequestForm.action = "RequestController";   

	    element1.value="updateRequest";
	    element1.name="requestType";
	    updateRequestForm.appendChild(element1);  

	    element2.value=requestId;
	    element2.name="reimbursementId";
	    updateRequestForm.appendChild(element2);  

	    element3.value=status;
	    element3.name="status";
	    updateRequestForm.appendChild(element3);

	   	document.body.appendChild(updateRequestForm);

	    updateRequestForm.submit();
		
	}

	function searchByUserId() {
	    var searchByUserIdForm = document.createElement("form");
	    var element1 = document.createElement("input"); 
	    var element2 = document.createElement("input");  

	    searchByUserIdForm.method = "POST";
	    searchByUserIdForm.action = "RequestController";   

	    element1.value="searchRequest";
	    element1.name="requestType";
	    searchByUserIdForm.appendChild(element1);  

	    if (document.getElementById("searchUserId").value > 0) {
	    	element2.value=document.getElementById("searchUserId").value;
	    } else {
		    element2.value=0;
	    }
	    element2.name="userId";
	    searchByUserIdForm.appendChild(element2);  

	    document.body.appendChild(searchByUserIdForm);

	    searchByUserIdForm.submit();
		
	}
	
	function navSelection() {
		var navSelection = <%= session.getAttribute("navSelection") %>;
		if (navSelection == 3) {
			showRequestsByEmployee()
		} else {
			showPendingRequests()
		}
	}
	function navReset() {
		document.getElementById("pendingRequests").style.display = 'none';
		document.getElementById("resolvedRequests").style.display = 'none';
		document.getElementById("requestsByEmployee").style.display = 'none';
		document.getElementById("employeeInfo").style.display = 'none';
		document.getElementById("navBtn1").classList.remove('active');
		document.getElementById("navBtn2").classList.remove('active');
		document.getElementById("navBtn3").classList.remove('active');
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
		document.getElementById("navBtn3").classList.add('active');
	}
	function showEmployeeInfo() {
		navReset();
		document.getElementById("employeeInfo").style.display = 'block';
		document.getElementById("navBtn4").classList.add('active');
	}
</script>
<style type="text/css">
</style>
</head>
<body onload="runOnLoad()">
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
				
				List<Reimbursement> allRequests = requestsDAO.viewAllUserRequests(((session.getAttribute("searchUserId")==null)?0:(int)session.getAttribute("searchUserId")));
				Iterator<Reimbursement> iteratorAll = allRequests.iterator();
				System.out.println(session.getAttribute("searchUserId")+" "+allRequests);

				List<User> employees = loginDAO.getEmployees((int) session.getAttribute("userId"));
				Iterator<User> iteratorEmployees = employees.iterator();
				%>

				<div class="btn-group" role="group" aria-label="Basic example">
					<button type="button" id="navBtn1" onclick="showPendingRequests()" class="btn btn-info active">Pending Requests</button>
					<button type="button" id="navBtn2" onclick="showResolvedRequests()" class="btn btn-info">Resolved Requests</button>
					<button type="button" id="navBtn3" onclick="showRequestsByEmployee()" class="btn btn-info">Requests by Employee</button>
					<button type="button" id="navBtn4" onclick="showEmployeeInfo()" class="btn btn-info">All Employee Info</button>
				</div>


				<div id="pendingRequests" style="display:none;">

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
							<td><%=(pendingRequest.getNote() == null) ? "" : pendingRequest.getNote()%></td>
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
							<td><%=(resolvedRequest.getNote() == null) ? "" : resolvedRequest.getNote()%></td>
							<td class="<%=resolvedRequest.getStatus()%>"><%=resolvedRequest.getStatus()%></td>
							<td><%=resolvedRequest.getDateTime().substring(0, 19)%></td>
						</tr>
						<%
						}
						%>
					</table>


				</div>
				<div id="requestsByEmployee" style="display:none;">
				
				
					<br />
					<table width="250px"><tr><td>
					
														<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">User Id</span>
										</div>
										<input type="text" class="form-control" name="searchUserId"
											id="searchUserId" placeholder="0">
										<div class="input-group-append">
											<input type="button" onclick="searchByUserId()" class="btn btn-primary"
											value="Search">
										</div>
									</div>
									</td></tr></table>

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
						while (iteratorAll.hasNext()) {
							Reimbursement allRequest = iteratorAll.next();
						%>
						<tr>
							<td><%=allRequest.getReimbursementId()%></td>
							<td><%=allRequest.getRequesterId() %></td>
							<td><%=allRequest.getReason()%></td>
							<td><%=allRequest.getFormattedAmount()%></td>
							<td><%=(allRequest.getNote() == null) ? "" : allRequest.getNote()%></td>
							<td class="<%=allRequest.getStatus()%>"><%=allRequest.getStatus()%></td>
							<td><%=allRequest.getDateTime().substring(0, 19)%></td>
						</tr>
						<%
						}
						%>
					</table>

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