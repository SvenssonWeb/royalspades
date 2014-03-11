package se.royalspades.dao;

import java.util.List;

import se.royalspades.model.User;

public interface UserDAO {
	public void add(User user);
	public void edit(User user);
	public void delete(int userId);
	public User getUser(int userId);
	public boolean checkIfUserExists(String username);
	public User getUserByUsername(String username);
	public User getUserByMobileToken(String mobileToken);
	@SuppressWarnings("rawtypes")
	public List getAllUsers();
}
