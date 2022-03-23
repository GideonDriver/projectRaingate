package com.training.ers.dao;

import java.util.List;

import com.training.ers.model.Reimbursement;
import com.training.ers.model.User;

public interface RequestsDAO {
	public boolean newRequest(Reimbursement reimbursement);
	
	public List<Reimbursement> viewUserPendingRequests(int userId);
	public List<Reimbursement> viewUserResolvedRequests(int userId);

	public List<Reimbursement> viewPendingRequests(int userId);
	public List<Reimbursement> viewResolvedRequests(int userId);
	
	public boolean updateStatus(int reimbursementId, String status, int userId);
}
