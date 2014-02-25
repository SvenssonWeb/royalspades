package se.royalspades.service.impl;

import java.util.List;

//import javax.transaction.Transactional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.UserDAO;
import se.royalspades.model.User;
import se.royalspades.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO userDAO;

	@Transactional
	public void add(User user) {
		userDAO.add(user);
	}

	@Transactional
	public void edit(User user) {
		userDAO.edit(user);
	}

	@Transactional
	public void delete(int userId) {
		userDAO.delete(userId);
	}

	@Transactional
	public User getUser(int userId) {
		return userDAO.getUser(userId);
	}
	
	@Transactional
	public boolean checkIfUserExists(String username){
		return userDAO.checkIfUserExists(username);
	}
	
	// Used for login
	@Transactional (readOnly=true)
	public User getUserByUsername(String username) 
			throws UsernameNotFoundException, DataAccessException {
		User user;
		user = userDAO.getUserByUsername(username);
		
		if(user == null){
			throw new UsernameNotFoundException("user not found");
		}
		
		return user;
	}

	@SuppressWarnings("rawtypes")
	@Transactional
	public List getAllUsers() {
		return userDAO.getAllUsers();
	}

}
