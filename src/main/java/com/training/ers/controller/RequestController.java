package com.training.ers.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.training.ers.dao.LoginDAO;
import com.training.ers.dao.LoginDAOImpl;
import com.training.ers.dao.RequestsDAO;
import com.training.ers.dao.RequestsDAOImpl;
import com.training.ers.model.Reimbursement;
import com.training.ers.model.User;

/**
 * Servlet implementation class LoginController
 */
public class RequestController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RequestController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		boolean result;

		if (request.getParameter("requestType").equals("updateRequest")) {

			int reimbursementId = Integer.parseInt(request.getParameter("reimbursementId"));
			String status = request.getParameter("status");
			int userId = (int) session.getAttribute("userId");

			RequestsDAO requestsDAO = new RequestsDAOImpl();
			result = requestsDAO.updateStatus(reimbursementId, status, userId);

		} else if (request.getParameter("requestType").equals("searchRequest")) {

			session.setAttribute("searchUserId", Integer.parseInt(request.getParameter("userId")));
			session.setAttribute("navSelection", 3);
			
		} else {

			String reason = request.getParameter("reason");
			double amount = Double.parseDouble(request.getParameter("amount"));
			String note = request.getParameter("note");

			RequestsDAO requestsDAO = new RequestsDAOImpl();
			Reimbursement reimbursement = new Reimbursement(-1, (int) session.getAttribute("userId"), reason, amount,
					"", note, "", "");
			result = requestsDAO.newRequest(reimbursement);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("back.jsp");
		dispatcher.include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
