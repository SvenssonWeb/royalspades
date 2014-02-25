package se.royalspades.service;

import java.util.List;

import se.royalspades.model.Store;

public interface StoreService {
	public void add(Store store);
	public void edit(Store stroe);
	public void delete(int storeId);
	public Store getStore(int storeId);
	@SuppressWarnings("rawtypes")
	public List getAllStores();
}

