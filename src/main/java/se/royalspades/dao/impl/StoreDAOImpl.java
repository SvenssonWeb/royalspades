package se.royalspades.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import se.royalspades.dao.StoreDAO;
import se.royalspades.model.Store;

@Repository
public class StoreDAOImpl implements StoreDAO {
	
	@Autowired
	 private SessionFactory sessionFactory;

	@Override
	public void add(Store store) {
		getCurrentSession().save(store);
	}

	@Override
	public void edit(Store store) {
		getCurrentSession().update(store);
	}

	@Override
	public void delete(int storeId) {
		getCurrentSession().delete(getStore(storeId));
	}

	@Override
	public Store getStore(int storeId) {
		return (Store)getCurrentSession().get(Store.class, storeId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllStores() {
		return getCurrentSession().createCriteria(Store.class).list();
	}
	
	protected final Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

}
