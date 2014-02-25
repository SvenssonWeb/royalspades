package se.royalspades.service.impl;

import java.util.List;

//import javax.transaction.Transactional;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.CategoryDAO;
import se.royalspades.model.Category;
import se.royalspades.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDAO categoryDao;
	
	@Transactional
	public void add(Category category) {
		categoryDao.add(category);
	}

	@Transactional
	public void edit(Category category) {
		categoryDao.edit(category);
	}

	@Transactional
	public void delete(int categoryId) {
		categoryDao.delete(categoryId);
	}

	@Transactional
	public Category getCategory(int categoryId) {
		return categoryDao.getCategory(categoryId);
	}

	@SuppressWarnings("rawtypes")
	@Transactional
	public List getAllCategories() {
		return categoryDao.getAllCategories();
	}

}
