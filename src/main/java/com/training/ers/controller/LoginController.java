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
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		LoginDAO loginDAO = new LoginDAOImpl();
		User currentUser = loginDAO.validate(email, password);
		HttpSession session = request.getSession();
		session.setAttribute("userId", currentUser.getUserId());
		session.setAttribute("firstName", currentUser.getFirstName());
		session.setAttribute("lastName", currentUser.getLastName());
		session.setAttribute("email", currentUser.getEmail());
		session.setAttribute("password", currentUser.getPassword());
		session.setAttribute("accountType", currentUser.getAccountType());
		session.setAttribute("active", currentUser.isActive());
		System.out.println(currentUser);

		session.setAttribute("navSelection", 1);
		
		RequestDispatcher dispatcherHeader = request.getRequestDispatcher("menuHeader.jsp");
		dispatcherHeader.include(request, response);

		if (currentUser.isActive() && currentUser.getAccountType().equals("employee")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("employeeMenu.jsp");
			dispatcher.include(request, response);
		} else if (currentUser.isActive() && currentUser.getAccountType().equals("manager")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("managerMenu.jsp");
			dispatcher.include(request, response);
		} else {
			out.println("<center><button onclick=\"location.href = 'login.html';\" id=\"home\" class=\"btn btn-primary btn-lg\" >Try again</button>&nbsp;&nbsp;");
			out.println("<button onclick=\"location.href = 'index.jsp';\" id=\"home\" class=\"btn btn-primary btn-lg\" >Home</button><br/><br/><br/>");
			if (session.getAttribute("firstName") == null) {
				out.println("<font class=\"alert alert-danger\">Invalid credentials</font></center>");
			} else {
				out.println("<font class=\"alert alert-warning\">Account inactive</font></center>");
			}
		}
		out.println("</center>");
		out.println("</html></body>");
	}

}
