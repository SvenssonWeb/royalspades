package se.royalspades.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import se.royalspades.model.Brand;
import se.royalspades.model.Category;
import se.royalspades.model.Product;
import se.royalspades.model.Store;
import se.royalspades.model.StoreProduct;
import se.royalspades.service.BrandService;
import se.royalspades.service.CategoryService;
import se.royalspades.service.ProductService;
import se.royalspades.service.StoreService;
import se.royalspades.service.UserService;

@Controller
@RequestMapping(value ="/api/product")
public class ProductController {
	@Autowired ProductService productService;
	@Autowired CategoryService categoryService;
	@Autowired BrandService brandService;
	@Autowired StoreService storeService;
	@Autowired UserService userService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	// return all products
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@SuppressWarnings("unchecked")
	@RequestMapping(value ="/all", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Product> getAllProductsResponse(){
		return productService.getAllProducts();
	}
	
	
	// return single product with id
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public Product getSingleProductResponse(@PathVariable int id){
		return productService.getProduct(id);
	}
	
	
	// return all products with a certain category
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/category/{categoryId}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Product> getAllProductsForCategory(@PathVariable int categoryId){
		List<Product> products = productService.getAllProducts();
		List<Product> productsWithCategory = new ArrayList<Product>();
		
		for(Product product : products){
			if(product.getCategory().getId() == categoryId){
				// if it's the correct category
				productsWithCategory.add(product);
			}
		}
		return productsWithCategory;
	}
	
	
	
	// add product
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value="/add_product/category/{categoryId}/brand/{brandId}", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> addProduct(@RequestBody @Valid Product product, @PathVariable int categoryId, @PathVariable int brandId){
		
		// get category and brand
		Category category = categoryService.getCategory(categoryId);
		Brand brand = brandService.getBrand(brandId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	// check so the user calling the method is the user set as owner on that brand
		if(brand.getUser().getUsername().equals(username)){
			// set category and brand
			product.setCategory(category);
			product.setBrand(brand);
			
			productService.add(product);
			return new ResponseEntity<String>("Product " + product.getName() + " skapad.", HttpStatus.OK);	
		} else {
			return new ResponseEntity<String>("Du kan bara lägga till produkter med er som leverantör", HttpStatus.UNAUTHORIZED);
		}

	}
	
	
	// edit product as brand owner
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value = "/edit_brand_product/category/{categoryId}/brand/{brandId}", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editBrandProduct(@RequestBody @Valid Product product, @PathVariable int categoryId, @PathVariable int brandId){
		// get category and brand
		Category category = categoryService.getCategory(categoryId);
		Brand brand = brandService.getBrand(brandId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
		
		// check so the user calling the method is the user set as owner on that brand
    	if(brand.getUser().getUsername().equals(username)){
    		// set category and brand
    		product.setCategory(category);
    		product.setBrand(brand);
    		
    		productService.edit(product);
    		return new ResponseEntity<String>("Product " + product.getName() + " ändrad!", HttpStatus.OK);
    	} else {
    		return new ResponseEntity<String>("Du kan bara ändra produkter som levereras av er", HttpStatus.UNAUTHORIZED);
    	}

	}
	
	
	// add store product as shop owner, (price is sent in data as {"storePrice":"12"} )
	@Secured("ROLE_MODERATOR")
	@RequestMapping(value = "/add_product_to_store/{storeId}/product/{productId}/store_category/{storeCategory}", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> addProductToStore(@PathVariable int storeId, @PathVariable int productId, @PathVariable int storeCategory, @RequestBody int storePrice){
		
		if(storePrice > 9000 || storePrice < 1){
			return new ResponseEntity<String>("Pris kan sättas mellan 1-9000", HttpStatus.BAD_REQUEST);
		}
		
		// get store, product and category
		Store store = storeService.getStore(storeId);
		Product product = productService.getProduct(productId);
		Category category = categoryService.getCategory(storeCategory);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	// check if the user calling the method is in fact the store owner
    	if(store.getUser().getUsername().equals(username)){
    		// set storeProduct
    		StoreProduct storeProduct = new StoreProduct();
    		storeProduct.Store(store);
    		storeProduct.setProduct(product);
    		storeProduct.setCategory(category);
    		storeProduct.setPrice(storePrice);
    		
    		// get all store products
    		Set<StoreProduct> storeProducts = product.getStoreProducts();

    		// add store product
    		if(!storeProducts.add(storeProduct)){
    			storeProduct = null;
    			return new ResponseEntity<String>("Produkten finns redan i butikens soritment", HttpStatus.BAD_REQUEST);
    		} else {
        		// set store products
        		product.setStoreProducts(storeProducts);

        		productService.edit(product);

        		return new ResponseEntity<String>("Produkt " + product.getName() + " tillagd i " + store.getName(), HttpStatus.OK);
    		}
    		    		
    	} else {
    		return new ResponseEntity<String>("Du kan bara lägga till produkter till din egen butik!", HttpStatus.UNAUTHORIZED);
    	}
	}
	
	

	// remove product from store as shop owner
	@Secured("ROLE_MODERATOR")
	@RequestMapping(value = "/remove_product_from_store/{storeId}/product/{productId}/category/{categoryId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> removeProductFormStore(@PathVariable int storeId, @PathVariable int productId, @PathVariable int categoryId){
		
		// get store, product and category
		Store store = storeService.getStore(storeId);
		Product product = productService.getProduct(productId);
		Category category = categoryService.getCategory(categoryId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	// check if the user calling the method is in fact the store owner
    	if(store.getUser().getUsername().equals(username)){
    		// set storeProduct
    		StoreProduct storeProduct = new StoreProduct();
    		storeProduct.Store(store);
    		storeProduct.setProduct(product);
    		storeProduct.setCategory(category);
    		
    		// get all store products
    		Set<StoreProduct> storeProducts = product.getStoreProducts();

    		// add store product
    		if(!storeProducts.remove(storeProduct)){
    			storeProduct = null;
    			return new ResponseEntity<String>("Produkten finns inte i butikens soritment", HttpStatus.BAD_REQUEST);
    		} else {
        		// set store products
        		product.setStoreProducts(storeProducts);

        		productService.edit(product);

        		return new ResponseEntity<String>("Produkt " + product.getName() + " raderad ifrån " + store.getName(), HttpStatus.OK);
    		}
    		    		
    	} else {
    		return new ResponseEntity<String>("Du kan bara radera produkter ifrån din egen butik!", HttpStatus.UNAUTHORIZED);
    	}
    	
    	
	}
	
	
	// remove product as brand owner (will also remove relations)
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value = "/remove_product/{productId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> removeProduct(@PathVariable int productId){
		Product product = productService.getProduct(productId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	// check so the user trying to remove the product is the owner of the brand that the product belongs to
    	if(product.getBrand().getUser().getUsername().equals(username)){
    		productService.delete(productId);
    		return new ResponseEntity<String>("Produkt raderad! (Ifrån alla butiken och handlarlistor)", HttpStatus.OK);
    	} else {
    		return new ResponseEntity<String>("Du kan inte ta bort produkter som inte levereras av er!", HttpStatus.UNAUTHORIZED);
    	}
	}


	// TODO Edit store product!
	
	// TODO return products for store and brand (if needed)

	
	
	// test
	@RequestMapping(value = "/add_test", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public String getTest(){
		 
		 Category category = categoryService.getCategory(1);
		 //User user = userService.getUser(1);	 
		 Brand brand = brandService.getBrand(1);

		 Product product = new Product("Milk", 1, "Liter", brand, category);
		 productService.add(product);
		 return "Done";
	}
	
	
}
