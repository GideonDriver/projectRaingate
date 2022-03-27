package com.training.ers.controller;

import java.io.IOException;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.training.ers.dao.LoginDAO;
import com.training.ers.dao.LoginDAOImpl;
import com.training.ers.model.User;

/**
 * Servlet implementation class SignupController
 */
public class SignupController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignupController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Request: " + request);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		HttpSession session = request.getSession();

		String firstName1 = request.getParameter("firstName");
		String lastName1 = request.getParameter("lastName");
		String email1 = request.getParameter("email");
		String password1 = request.getParameter("password");
		boolean result;

		if (session.getAttribute("userId") == null || (int)session.getAttribute("userId") == 0) {

			User newUser = new User(-1, firstName1, lastName1, email1, password1, "employee", true);
			LoginDAO loginDAO = new LoginDAOImpl();
			result = loginDAO.register(newUser);
			System.out.println(newUser);

		} else {

			User updateUser = new User((int) session.getAttribute("userId"), firstName1, lastName1, email1, password1,
					null, true);
			LoginDAO loginDAO = new LoginDAOImpl();
			result = loginDAO.update(updateUser);
			System.out.println(updateUser);

		}

		session.setAttribute("email", email1);
		session.setAttribute("password", password1);

		RequestDispatcher dispatcherHeader = request.getRequestDispatcher("menuHeader.jsp");
		dispatcherHeader.include(request, response);

		out.println(
				"<center><button onclick=\"location.href = 'login.html';\" id=\"home\" class=\"btn btn-primary btn-lg\" >Login</button>&nbsp;&nbsp;");
		out.println(
				"<button onclick=\"location.href = 'index.jsp';\" id=\"home\" class=\"btn btn-primary btn-lg\" >Home</button><br/><br/><br/>");
		if (result) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("back.jsp");
			dispatcher.include(request, response);
			out.println("<font class=\"alert alert-success\">Thanks for signing up " + firstName1 + "!</font>");
		} else {
			out.println("<font class=\"alert alert-danger\">Registration failed</font>");
		}
		out.println("</center>");

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
