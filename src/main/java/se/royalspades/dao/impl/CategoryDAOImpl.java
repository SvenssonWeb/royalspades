package se.royalspades.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import se.royalspades.dao.CategoryDAO;
import se.royalspades.model.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

	@Autowired
	 private SessionFactory sessionFactory;
	
	@Override
	public void add(Category category) {
		getCurrentSession().save(category);
	}

	@Override
	public void edit(Category category) {
		getCurrentSession().update(category);
	}

	@Override
	public void delete(int categoryId) {
		getCurrentSession().delete(getCategory(categoryId));
	}

	@Override
	public Category getCategory(int categoryId) {
		return (Category)getCurrentSession().get(Category.class, categoryId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllCategories() {
		return getCurrentSession().createCriteria(Category.class).list();
	}	
	
	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

}
