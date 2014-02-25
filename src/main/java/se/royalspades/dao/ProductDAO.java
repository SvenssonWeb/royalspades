package se.royalspades.dao;

import java.util.List;

import se.royalspades.model.Product;

public interface ProductDAO {
	public void add(Product product);
	public void edit(Product product);
	public void delete(int productId);
	public Product getProduct(int productId);
	@SuppressWarnings("rawtypes")
	public List getAllProducts();
}
