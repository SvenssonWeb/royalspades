package se.royalspades.dao;

import java.util.List;

import se.royalspades.model.Store;

public interface StoreDAO {
	public void add(Store store);
	public void edit(Store store);
	public void delete(int storeId);
	public Store getStore(int storeId);
	@SuppressWarnings("rawtypes")
	public List getAllStores();
}
