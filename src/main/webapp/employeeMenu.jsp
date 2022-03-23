<%@page import="org.apache.commons.lang3.concurrent.ConcurrentUtils"%>
<%@page import="java.util.Iterator"%>
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
	function requestValidate() {

		var reason = document.requestform.reason.value;
		var amount = document.requestform.amount.value;
		var note = document.requestform.note.value;

		errReason.innerHTML = "";
		errAmount.innerHTML = "";
		errNote.innerHTML = "";

		var error = 0;

		if (reason == 0) {
			errReason.innerHTML = "<font class=\"alert alert-danger\">Select an option</font>";
			error = 1;
		}
		if (amount.length == 0) {
			errAmount.innerHTML = "<font class=\"alert alert-danger\">Missing amount</font>";
			error = 1;
		} else if (amount > 100000) {
			errAmount.innerHTML = "<font class=\"alert alert-danger\">Cannot exceed $100,000</font>";
			error = 1;
		} else if (amount < 0) {
			errAmount.innerHTML = "<font class=\"alert alert-danger\">Cannot be negative</font>";
			error = 1;
		} else if (isNaN(parseFloat(amount))) {
			errAmount.innerHTML = "<font class=\"alert alert-danger\">Must be a number</font>";
			error = 1;
		}
		if (note.length > 40) {
			errNote.innerHTML = "<font class=\"alert alert-danger\">Max character length of 40</font>";
			error = 1;
		}

		if (error > 0) {
			return false;
		} else {
			return true;
		}
	}
	function navReset() {
		document.getElementById("newRequest").style.display = 'none';
		document.getElementById("pendingRequests").style.display = 'none';
		document.getElementById("resolvedRequests").style.display = 'none';
		document.getElementById("navBtn1").classList.remove('active');
		document.getElementById("navBtn2").classList.remove('active');
		document.getElementById("navBtn3").classList.remove('active');
	}
	function showNewRequestForm() {
		navReset();
		document.getElementById("newRequest").style.display = 'block';
		document.getElementById("navBtn1").classList.add('active');
	}
	function showPendingRequests() {
		navReset();
		document.getElementById("pendingRequests").style.display = 'block';
		document.getElementById("navBtn2").classList.add('active');
	}
	function showResolvedRequests() {
		navReset();
		document.getElementById("resolvedRequests").style.display = 'block';
		document.getElementById("navBtn3").classList.add('actve');
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
				RequestsDAO requestsDAO = new RequestsDAOImpl();
				List<Reimbursement> pendingRequests = requestsDAO.viewUserPendingRequests((int) session.getAttribute("userId"));
				Iterator<Reimbursement> iteratorPending = pendingRequests.iterator();
				List<Reimbursement> resolvedRequests = requestsDAO.viewUserResolvedRequests((int) session.getAttribute("userId"));
				Iterator<Reimbursement> iteratorResolved = resolvedRequests.iterator();
				%>

				<div class="btn-group" role="group" aria-label="Basic example">
					<button type="button" id="navBtn1" onclick="showNewRequestForm()"
						class="btn btn-secondary active">New Request</button>
					<button type="button" id="navBtn2" onclick="showPendingRequests()"
						class="btn btn-secondary">Pending Requests</button>
					<button type="button" id="navBtn3" onclick="showResolvedRequests()"
						class="btn btn-secondary">Resolved Requests</button>
				</div>


				<div id="newRequest">

					<br />

					<form action="RequestController" name="requestform"
						onsubmit="return requestValidate()" method="get">
						<table>
							<tr>
								<td>

									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<label class="input-group-text" for="reason">Reason</label>
										</div>
										<select class="custom-select input-group-text btn-light"
											name="reason" id="reason">
											<option selected value="0">Choose...</option>
											<option>Gas</option>
											<option>Food</option>
											<option>Lodging</option>
											<option>Supplies</option>
											<option>Transportation</option>
											<option>Education</option>
											<option>Other</option>
										</select>
									</div>

								</td>
								<td>

									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">$</span>
										</div>
										<input type="text" class="form-control" name="amount"
											id="amount">
									</div>

								</td>
								<td>

									<div class="input-group mb-3">
										<div class="input-group-prepend">
											<span class="input-group-text">Note</span>
										</div>
										<input type="text" class="form-control" name="note" id="note">
									</div>

								</td>
							</tr>
							<tr height="25px">
								<td><div>
										<span id="errReason"></span>
									</div></td>
								<td><div>
										<span id="errAmount"></span>
									</div></td>
								<td><div>
										<span id="errNote"></span>
									</div></td>
							</tr>
							<tr height="25px">
							</tr>
							<tr>
								<td colspan="3">
									<center>
										<input type="submit" class="btn btn-primary"
											value="Submit Request">
									</center>
								</td>
							</tr>

						</table>
					</form>

				</div>
				<div id="pendingRequests" style="display: none;">

					<br />

					<table class="table table-striped table-dark">
						<tr>
							<th>Request Id</th>
							<!-- 	<th>Requester Id</th> -->
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
							<%-- 		<td><%= pendingRequest.getRequesterId() %></td> --%>
							<td><%=pendingRequest.getReason()%></td>
							<td><%=pendingRequest.getFormattedAmount()%></td>
							<td><%=(pendingRequest.getNote() == null) ? "NA" : pendingRequest.getNote()%></td>
							<td><%=pendingRequest.getStatus()%></td>
							<td><%=pendingRequest.getDateTime().substring(0, 19)%></td>
						</tr>
						<%
						}
						%>
					</table>


				</div>
				<div id="resolvedRequests" style="display: none;">

					<br />

					<table class="table table-striped table-dark">
						<tr>
							<th>Request Id</th>
							<!-- 	<th>Requester Id</th> -->
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
							<%-- 		<td><%= resolvedRequest.getRequesterId() %></td> --%>
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



			</td>
		</table>

	</center>
</body>
</html>