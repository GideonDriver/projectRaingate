package com.training.ers.dao;

import java.util.List;

import com.training.ers.model.User;

public interface LoginDAO {
	public boolean register(User user);
	public boolean update(User user);
	public User validate(String uname, String upass);
	public List<User> getEmployees(int userId);
	public List<User> searchFirstName(String email, String search);
}
