package se.royalspades.service.impl;

import java.util.List;

//import javax.transaction.Transactional;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.ProductDAO;
import se.royalspades.model.Product;
import se.royalspades.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired private ProductDAO productDao;
	
	@Transactional
	public void add(Product product) {
		productDao.add(product);
	}

	@Transactional
	public void edit(Product product) {
		productDao.edit(product);
	}

	@Transactional
	public void delete(int productId) {
		productDao.delete(productId);
	}

	@Transactional
	public Product getProduct(int productId) {
		return productDao.getProduct(productId);
	}

	@SuppressWarnings("rawtypes")
	@Transactional
	public List getAllProducts() {
		return productDao.getAllProducts();
	}

}
