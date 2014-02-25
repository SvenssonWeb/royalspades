package se.royalspades.service;

import java.util.List;

import se.royalspades.model.GroceryList;

public interface GroceryListService {
	public void add(GroceryList groceryList);
	public void edit(GroceryList groceryList);
	public void delete(int groceryListId);
	public GroceryList getGroceryList(int groceryListId);
	@SuppressWarnings("rawtypes")
	public List getAllGroceryLists();
}
