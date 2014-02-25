package se.royalspades.controller;

import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import se.royalspades.model.Category;
import se.royalspades.service.CategoryService;

@Controller
@RequestMapping(value ="/api/category")
public class CategoryController {
	@Autowired CategoryService categoryService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);
	
	// get all categories
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value ="/all", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Category> getAllCategoriesResponse(){
		return categoryService.getAllCategories();
	}
	
	// get single category
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public Category getSingleCategoryResponse(@PathVariable int id){
		return categoryService.getCategory(id);
	}
	
	// add new category
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/add_category", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> addCategory(@RequestBody @Valid Category category){
		
		List<Category> categories = categoryService.getAllCategories();
		
		// check if a category with that name exists
		for(Category cat : categories){
			if(cat.getName().equals(category.getName())){
				return new ResponseEntity<String>("En kategori vid namn" + category.getName() + " finns redan!", HttpStatus.BAD_REQUEST);
			}
		}
		
		categoryService.add(category);
		return new ResponseEntity<String>("Kategori " + category.getName() + " skapad!", HttpStatus.OK);	
	} 
	
	
	// edit category
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/edit_category", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editCategory(@RequestBody @Valid Category category){
		List<Category>categories = categoryService.getAllCategories();
		
		// check if a category with that name exists
		for(Category cat : categories){
			if(cat.getName().equals(category.getName()) && cat.getId() != category.getId()){
				return new ResponseEntity<String>("En kategori vid namn " + category.getName() + " finns redan!", HttpStatus.BAD_REQUEST);
			}
		}
		categoryService.edit(category);
		return new ResponseEntity<String>("Kategori ändrad!", HttpStatus.OK);
	}
	
	
	// remove category
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "admin/remove_category/{categoryId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> removeCategory(@PathVariable int categoryId){
		
		Category category = categoryService.getCategory(categoryId);
		
		// check if category is used by a product
		if(category.getProducts().size() > 0){
			return new ResponseEntity<String>("Kan inte ta bort kategori. Den används av produkter!", HttpStatus.BAD_REQUEST);
		}
		
		// check if a store uses the category
		if(category.getStoreProducts().size() > 0){
			return new ResponseEntity<String>("Kan inte ta bort kategori. Den används av butiker!", HttpStatus.BAD_REQUEST);
		}

		// delete category
		categoryService.delete(categoryId);

		return new ResponseEntity<String>("Kategori raderad!", HttpStatus.OK);		
	}
	
		// TODO change category listings for store.
}

