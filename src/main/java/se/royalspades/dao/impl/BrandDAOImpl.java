package se.royalspades.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import se.royalspades.dao.BrandDAO;
import se.royalspades.model.Brand;

@Repository
public class BrandDAOImpl implements BrandDAO {
	
	@Autowired
	 private SessionFactory sessionFactory;

	@Override
	public void add(Brand brand) {
		getCurrentSession().save(brand);
	}

	@Override
	public void edit(Brand brand) {
		getCurrentSession().clear();
		getCurrentSession().update(brand);
	}

	@Override
	public void delete(int brandId) {
		getCurrentSession().delete(getBrand(brandId));
	}

	@Override
	public Brand getBrand(int brandId) {
		return (Brand)getCurrentSession().get(Brand.class, brandId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllBrands() {
		return getCurrentSession().createCriteria(Brand.class).list();
	}
	
	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

}
