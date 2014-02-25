package se.royalspades.service;

import java.util.List;

import se.royalspades.model.Category;

public interface CategoryService {
	public void add(Category category);
	public void edit(Category category);
	public void delete(int categoryId);
	public Category getCategory(int categoryId);
	@SuppressWarnings("rawtypes")
	public List getAllCategories();
}
