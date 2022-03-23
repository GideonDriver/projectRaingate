package com.training.ers.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.training.ers.model.Reimbursement;
import com.training.ers.model.User;
import com.training.ers.utility.DBConnection;

public class RequestsDAOImpl implements RequestsDAO{

	private static Logger logger = org.apache.log4j.Logger.getLogger(LoginDAOImpl.class);

	@Override
	public boolean newRequest(Reimbursement reimbursement) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement = null;
		int rows = 0;
		try {
			statement = connection.prepareStatement("insert into reimbursements values(default,?,?,?,?,default,default)");
			statement.setInt(1, reimbursement.getRequesterId());
			statement.setString(2, reimbursement.getReason());
			statement.setDouble(3, reimbursement.getAmount());
			statement.setString(4, reimbursement.getNote());
			
			rows = statement.executeUpdate();

		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (rows == 0) {
			logger.warn("Userid "+reimbursement.getRequesterId()+" failed to create reimbursement request");
			return false;
		} else {
			logger.info("Userid "+reimbursement.getRequesterId()+" made reimbursement request");
			return true;
		}
	}

	@Override
	public List<Reimbursement> viewUserPendingRequests(int userId) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		List<Reimbursement> pendingReimbursements = new ArrayList<Reimbursement>();
		NumberFormat defaultFormat = NumberFormat.getCurrencyInstance();
		try {
			statement = connection.prepareStatement("select * from reimbursements where status = 'pending' and requesterId = ? order by dateTime DESC");
			statement.setInt(1, userId);
			

			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Reimbursement reimbursement = new Reimbursement();
				reimbursement.setReimbursementId(result.getInt(1));
				reimbursement.setRequesterId(result.getInt(2));
				reimbursement.setReason(result.getString(3));
				reimbursement.setAmount(result.getDouble(4));
				reimbursement.setFormattedAmount(defaultFormat.format(result.getDouble(4)));
				reimbursement.setNote(result.getString(5));
				reimbursement.setStatus(result.getString(6));
				reimbursement.setDateTime(result.getString(7));
				pendingReimbursements.add(reimbursement);
			}
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}
		    
		} catch (SQLException e) {
			// e.printStackTrace();
		}
		logger.info("Userid "+userId+" pulled pending requests");
		return pendingReimbursements;
	}

	@Override
	public List<Reimbursement> viewUserResolvedRequests(int userId) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		List<Reimbursement> resolvedReimbursements = new ArrayList<Reimbursement>();
		NumberFormat defaultFormat = NumberFormat.getCurrencyInstance();
		try {
			statement = connection.prepareStatement("select * from reimbursements where status != 'pending' and requesterId = ? order by dateTime DESC");
			statement.setInt(1, userId);
			

			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Reimbursement reimbursement = new Reimbursement();
				reimbursement.setReimbursementId(result.getInt(1));
				reimbursement.setRequesterId(result.getInt(2));
				reimbursement.setReason(result.getString(3));
				reimbursement.setAmount(result.getDouble(4));
				reimbursement.setFormattedAmount(defaultFormat.format(result.getDouble(4)));
				reimbursement.setNote(result.getString(5));
				reimbursement.setStatus(result.getString(6));
				reimbursement.setDateTime(result.getString(7));
				resolvedReimbursements.add(reimbursement);
			}
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}
		    
		} catch (SQLException e) {
			// e.printStackTrace();
		}
		logger.info("Userid "+userId+" pulled resolved requests");
		return resolvedReimbursements;
	}

	@Override
	public List<Reimbursement> viewPendingRequests(int userId) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		List<Reimbursement> pendingReimbursements = new ArrayList<Reimbursement>();
		NumberFormat defaultFormat = NumberFormat.getCurrencyInstance();
		try {
			statement = connection.prepareStatement("select * from reimbursements where status = 'pending' order by dateTime DESC;");

			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Reimbursement reimbursement = new Reimbursement();
				reimbursement.setReimbursementId(result.getInt(1));
				reimbursement.setRequesterId(result.getInt(2));
				reimbursement.setReason(result.getString(3));
				reimbursement.setAmount(result.getDouble(4));
				reimbursement.setFormattedAmount(defaultFormat.format(result.getDouble(4)));
				reimbursement.setNote(result.getString(5));
				reimbursement.setStatus(result.getString(6));
				reimbursement.setDateTime(result.getString(7));
				pendingReimbursements.add(reimbursement);
			}
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}
		    
		} catch (SQLException e) {
			// e.printStackTrace();
		}
		logger.info("Userid "+userId+" pulled pending requests");
		return pendingReimbursements;
	}

	@Override
	public List<Reimbursement> viewResolvedRequests(int userId) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement;
		List<Reimbursement> resolvedReimbursements = new ArrayList<Reimbursement>();
		NumberFormat defaultFormat = NumberFormat.getCurrencyInstance();
		try {
			statement = connection.prepareStatement("select * from reimbursements where status != 'pending' order by dateTime DESC;");

			ResultSet result = statement.executeQuery();
			while (result.next()) {
				Reimbursement reimbursement = new Reimbursement();
				reimbursement.setReimbursementId(result.getInt(1));
				reimbursement.setRequesterId(result.getInt(2));
				reimbursement.setReason(result.getString(3));
				reimbursement.setAmount(result.getDouble(4));
				reimbursement.setFormattedAmount(defaultFormat.format(result.getDouble(4)));
				reimbursement.setNote(result.getString(5));
				reimbursement.setStatus(result.getString(6));
				reimbursement.setDateTime(result.getString(7));
				resolvedReimbursements.add(reimbursement);
			}
			
		    try { result.close(); } catch (Exception e) {}
		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}
		    
		} catch (SQLException e) {
			// e.printStackTrace();
		}
		logger.info("Userid "+userId+" pulled resolved requests");
		return resolvedReimbursements;
	}

	@Override
	public boolean updateStatus(int reimbursementId, String status, int userId) {
		Connection connection = DBConnection.getConnection();
		PreparedStatement statement = null;
		int rows = 0;
		try {
			statement = connection.prepareStatement("update reimbursements set status = ? where reimbursementId = ?");
			statement.setString(1, status);
			statement.setInt(2, reimbursementId);
			
			rows = statement.executeUpdate();

		    try { statement.close(); } catch (Exception e) {}
		    try { connection.close(); } catch (Exception e) {}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (rows == 0) {
			logger.warn("Userid "+userId+" failed to update reimbursement request");
			return false;
		} else {
			logger.info("Userid "+userId+" updated reimbursement request Id: "+reimbursementId+" to "+status);
			return true;
		}
	}
	

}
