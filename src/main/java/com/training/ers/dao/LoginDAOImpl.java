package com.training.ers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.training.ers.model.User;
import com.training.ers.utility.DBConnection;

public class LoginDAOImpl implements LoginDAO {
	
	private static Logger logger = org.apache.log4j.Logger.getLogger(LoginDAOImpl.class);
	
	public boolean register(User user) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement = null;
		int rows = 0;
		try {
			statement = connection.prepareStatement("insert into users values(default,?,?,?,?,?,?)");
			statement.setString(1, user.getFirstName());
			statement.setString(2, user.getLastName());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getPassword());
			statement.setString(5, user.getAccountType());
			statement.setBoolean(6, user.isActive());

			rows = statement.executeUpdate();

		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (rows == 0) {
			logger.warn(user.getFirstName()+" "+user.getLastName()+" failed to sign up");
			return false;
		} else {
			logger.info(user.getFirstName()+" "+user.getLastName()+" signed up");
			return true;
		}
	}
	
	public boolean update(User updateUser) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement = null;
		int rows = 0;
		try {
			statement = connection.prepareStatement("update users set firstName = ?, lastName = ?, email = ?, password = ? where userId = ?");
			statement.setString(1, updateUser.getFirstName());
			statement.setString(2, updateUser.getLastName());
			statement.setString(3, updateUser.getEmail());
			statement.setString(4, updateUser.getPassword());
			statement.setInt(5, updateUser.getUserId());

			rows = statement.executeUpdate();

		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (rows == 0) {
			logger.warn(updateUser.getFirstName()+" "+updateUser.getLastName()+" failed to update user info");
			return false;
		} else {
			logger.info(updateUser.getFirstName()+" "+updateUser.getLastName()+" updated user info");
			return true;
		}
	}
	
	public User validate(String email, String password) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		User currentUser = new User();
		try {
			statement = connection.prepareStatement("select * from users where email = ? and password = ? ");
			statement.setString(1, email);
			statement.setString(2, password);
			

			ResultSet result = statement.executeQuery();
			result.next();
			currentUser.setUserId(result.getInt(1));
			currentUser.setFirstName(result.getString(2));
			currentUser.setLastName(result.getString(3));
			currentUser.setEmail(result.getString(4));
			currentUser.setPassword(result.getString(5));
			currentUser.setAccountType(result.getString(6));
			currentUser.setActive(result.getBoolean(7));
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}

			logger.info(currentUser.getFirstName()+" "+currentUser.getLastName()+" signed in");
		} catch (SQLException e) {
			// e.printStackTrace();
			logger.info(email+" attempted to sign in, invalid credidentials");
		}
		return currentUser;
	}

	@Override
	public List<User> getEmployees(int userId) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		List<User> users = new ArrayList<User>();
		try {
			statement = connection.prepareStatement("select * from users where accountType = 'employee'");

			ResultSet result = statement.executeQuery();
			while (result.next()) {
				User user = new User();
				user.setUserId(result.getInt(1));
				user.setFirstName(result.getString(2));
				user.setLastName(result.getString(3));
				user.setEmail(result.getString(4));
				user.setPassword(result.getString(5));
				user.setAccountType(result.getString(6));
				user.setActive(result.getBoolean(7));
				users.add(user);
			}
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}
		    
		} catch (SQLException e) {
			// e.printStackTrace();
		}
		logger.info(userId+" pulled employees table");
		return users;
	}

	public List<User> searchFirstName(String email, String keyword) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		List<User> users = new ArrayList<User>();
		keyword = "%"+keyword+"%";
		try {
			statement = connection.prepareStatement("select * from users where firstName ilike ?");
			statement.setString(1, keyword);
			

			ResultSet result = statement.executeQuery();
			while (result.next()) {
				User user = new User();
				user.setUserId(result.getInt(1));
				user.setFirstName(result.getString(2));
				user.setLastName(result.getString(3));
				user.setEmail(result.getString(4));
				user.setPassword(result.getString(5));
				user.setAccountType(result.getString(6));
				user.setActive(result.getBoolean(7));
				users.add(user);
			}
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}
		    
		} catch (SQLException e) {
			// e.printStackTrace();
		}
		logger.info(email+" completed search with keyword: "+keyword.replace("%", "'"));
		return users;
	}
}
