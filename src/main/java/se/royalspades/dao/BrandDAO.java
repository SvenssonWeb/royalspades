package se.royalspades.dao;

import java.util.List;

import se.royalspades.model.Brand;

public interface BrandDAO {
	public void add(Brand brand);
	public void edit(Brand brand);
	public void delete(int brandId);
	public Brand getBrand(int brandId);
	@SuppressWarnings("rawtypes")
	public List getAllBrands();
}
