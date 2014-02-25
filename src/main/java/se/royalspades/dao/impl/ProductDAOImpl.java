package se.royalspades.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import se.royalspades.dao.ProductDAO;
import se.royalspades.model.Product;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	 private SessionFactory sessionFactory;
	
	@Override
	public void add(Product product) {
		getCurrentSession().save(product);
	}

	@Override
	public void edit(Product product) {
		getCurrentSession().update(product);
	}

	@Override
	public void delete(int productId) {
		getCurrentSession().delete(getProduct(productId));
	}

	@Override
	public Product getProduct(int productId) {
		return (Product) getCurrentSession().get(Product.class, productId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllProducts() {
		return getCurrentSession().createCriteria(Product.class).list();
	}

	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}
}
