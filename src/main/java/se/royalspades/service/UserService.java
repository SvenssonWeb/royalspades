package se.royalspades.service;

import java.util.List;

import se.royalspades.model.User;

public interface UserService {
	public void add(User user);
	public void edit(User user);
	public void delete(int userId);
	public User getUser(int userId);
	public boolean checkIfUserExists(String username);
	public User getUserByUsername(String userName);
	@SuppressWarnings("rawtypes")
	public List getAllUsers();
}
