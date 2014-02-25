package se.royalspades.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import se.royalspades.dao.UserDAO;
import se.royalspades.model.User;

@Repository
public class UserDAOImpl implements UserDAO{
	
	@Autowired
	 private SessionFactory sessionFactory;
	  
	@Override
	public void add(User user) {
		getCurrentSession().save(user);
	}

	@Override
	public void edit(User user) {
		getCurrentSession().clear();
		getCurrentSession().update(user);
	}

	@Override
	public void delete(int userId) {
		getCurrentSession().delete(getUser(userId));
	}
	
	@Override
	public User getUser(int userId) {
		return (User)getCurrentSession().get(User.class, userId);
	}

	@Override
	public User getUserByUsername(String username) {
		return (User) getCurrentSession().createCriteria(User.class)
        .add(Restrictions.eq("username", username)).setMaxResults(1)
         .setCacheable(false)
        .uniqueResult();
	}
	
	@Override
	public boolean checkIfUserExists(String username){
		return getCurrentSession().createCriteria(User.class).add(Restrictions.eq("username", username))
                .setMaxResults(1).uniqueResult() != null;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getAllUsers() {
		return getCurrentSession().createCriteria(User.class).list();
	}
	
	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
}