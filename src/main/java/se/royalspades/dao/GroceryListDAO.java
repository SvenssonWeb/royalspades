package se.royalspades.dao;

import java.util.List;

import se.royalspades.model.GroceryList;

public interface GroceryListDAO {
	public void add(GroceryList groceryList);
	public void edit(GroceryList groceryList);
	public void delete(int groceryListId);
	public GroceryList getGroceryList(int groceryListId);
	@SuppressWarnings("rawtypes")
	public List getAllGroceryLists();
}
