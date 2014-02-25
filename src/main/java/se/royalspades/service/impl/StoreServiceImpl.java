package se.royalspades.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.StoreDAO;
import se.royalspades.model.Store;
import se.royalspades.service.StoreService;

@Service
public class StoreServiceImpl implements StoreService {

	@Autowired
	private StoreDAO storeDao;
	
	@Transactional
	public void add(Store store) {
		storeDao.add(store);
	}

	@Transactional
	public void edit(Store store) {
		storeDao.edit(store);
	}

	@Transactional
	public void delete(int storeId) {
		storeDao.delete(storeId);
	}

	@Transactional
	public Store getStore(int storeId) {
		return storeDao.getStore(storeId);
	}

	@SuppressWarnings("rawtypes")
	@Transactional
	public List getAllStores() {
		return storeDao.getAllStores();
	}

}
