package se.royalspades.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import se.royalspades.dao.GroceryListDAO;
import se.royalspades.model.GroceryList;

@Repository
public class GroceryListDAOImpl implements GroceryListDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void add(GroceryList groceryList) {
		getCurrentSession().save(groceryList);
	}

	@Override
	public void edit(GroceryList groceryList) {
		getCurrentSession().update(groceryList);
	}

	@Override
	public void delete(int groceryListId) {
		getCurrentSession().delete(getGroceryList(groceryListId));
	}

	@Override
	public GroceryList getGroceryList(int groceryListId) {
		return (GroceryList)getCurrentSession().get(GroceryList.class, groceryListId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllGroceryLists() {
		return getCurrentSession().createCriteria(GroceryList.class).list();
	}

	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
}
