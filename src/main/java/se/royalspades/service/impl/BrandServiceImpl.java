package se.royalspades.service.impl;

import java.util.List;

//import javax.transaction.Transactional;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import se.royalspades.dao.BrandDAO;
import se.royalspades.model.Brand;
import se.royalspades.service.BrandService;

@Service
public class BrandServiceImpl implements BrandService {

	@Autowired
	private BrandDAO brandDao;
	
	@Transactional
	public void add(Brand brand) {
		brandDao.add(brand);
	}

	@Transactional
	public void edit(Brand brand) {
		brandDao.edit(brand);
	}

	@Transactional
	public void delete(int brandId) {
		brandDao.delete(brandId);
	}

	@Transactional
	public Brand getBrand(int brandId) {
		return brandDao.getBrand(brandId);
	}

	@SuppressWarnings("rawtypes")
	@Transactional
	public List getAllBrands() {
		return brandDao.getAllBrands();
	}

}
