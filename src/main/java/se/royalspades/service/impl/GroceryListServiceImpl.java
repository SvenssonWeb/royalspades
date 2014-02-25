package se.royalspades.service.impl;

import java.util.List;

//import javax.transaction.Transactional;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.GroceryListDAO;
import se.royalspades.model.GroceryList;
import se.royalspades.service.GroceryListService;

@Service
public class GroceryListServiceImpl implements GroceryListService{

	@Autowired
	private GroceryListDAO groceryListDao;

	@Transactional
	public void add(GroceryList groceryList) {
		groceryListDao.add(groceryList);
	}

	@Transactional
	public void edit(GroceryList groceryList) {
		groceryListDao.edit(groceryList);
	}

	@Transactional
	public void delete(int groceryListId) {
		groceryListDao.delete(groceryListId);
	}

	@Transactional
	public GroceryList getGroceryList(int groceryListId) {
		return groceryListDao.getGroceryList(groceryListId);
	}

	@SuppressWarnings("rawtypes")
	@Transactional
	public List getAllGroceryLists() {
		return groceryListDao.getAllGroceryLists();
	}
}
