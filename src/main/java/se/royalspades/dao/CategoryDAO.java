package se.royalspades.dao;

import java.util.List;

import se.royalspades.model.Category;

public interface CategoryDAO {
	public void add(Category category);
	public void edit(Category category);
	public void delete(int categoryId);
	public Category getCategory(int categoryId);
	@SuppressWarnings("rawtypes")
	public List getAllCategories();
}
