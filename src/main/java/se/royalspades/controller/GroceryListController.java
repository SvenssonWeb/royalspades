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

import se.royalspades.model.GroceryList;
import se.royalspades.model.GroceryListProduct;
import se.royalspades.model.Product;
import se.royalspades.model.User;
import se.royalspades.service.GroceryListService;
import se.royalspades.service.ProductService;
import se.royalspades.service.UserService;

@Controller
@RequestMapping(value = "/api/grocerylist")
public class GroceryListController {
	@Autowired GroceryListService groceryListService;
	@Autowired UserService userService;
	@Autowired ProductService productService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(GroceryListController.class);
	
	// return all grocery lists
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value ="/all", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<GroceryList> getAllGroceryLists(){
		return groceryListService.getAllGroceryLists();
	}
	
	
	// return single grocery list
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE})
	@ResponseBody
	public GroceryList getSingleGroceryList(@PathVariable int id){		
		return groceryListService.getGroceryList(id);
	}
	

	// get all grocery lists for a certain user
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/user/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public List<GroceryList> getUserGroceryListsResponse(@PathVariable int id){
		@SuppressWarnings("unchecked")
		List<GroceryList> groceryLists = groceryListService.getAllGroceryLists();
		List<GroceryList> groceryListsToReturn = new ArrayList<GroceryList>();
		
		for(GroceryList groceryList : groceryLists){
			if(groceryList.getListOwner().getId() == id){
				groceryListsToReturn.add(groceryList);
			}
		}
		
		// return the grocery lists that belongs to the user (with path id)
		return groceryListsToReturn;
	}
	
	
	// add new grocery list
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/add_grocery_list/{userId}", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> addNewGroceryList(@RequestBody @Valid GroceryList groceryList, @PathVariable int userId){
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
		
		User user = userService.getUser(userId);
		
		// check so the user trying to create a new list is the user that will have the list
		if(user.getUsername().equals(username)){
			// set GroceryList owner 
			groceryList.setListOwner(user);
			
			groceryListService.add(groceryList);
			
			return new ResponseEntity<String>("Lista " + groceryList.getName() + " skapad!", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("Du kan bara lägga till listor till din egen användare!", HttpStatus.UNAUTHORIZED);
		}
	}
	
	
	// edit grocery list
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "edit_grocery_list/{userId}", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editGroceryList(@RequestBody @Valid GroceryList groceryList, @PathVariable int userId){
		
		User user = userService.getUser(userId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	// check so the user trying to edit the list is the list owner
    	if(user.getUsername().equals(username)){
        	// set grocery list owner
    		groceryList.setListOwner(user);
    		
    		groceryListService.edit(groceryList);
    		
    		return new ResponseEntity<String>("Lista " + groceryList.getName() + " ändrad!", HttpStatus.OK);	
    	} else {
    		return new ResponseEntity<String>("Du kan bara ändra dina egna listor!", HttpStatus.UNAUTHORIZED);
    	}

	}
	
	
	// remove grocery list  (will also remove relations)
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "remove_grocery_list/{listId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> removeGroceryList(@PathVariable int listId){
		// get grocery list
		GroceryList groceryList = groceryListService.getGroceryList(listId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();
    	
    	// check so the user trying to remove the grocery list is the list owner
    	if(groceryList.getListOwner().getUsername().equals(user)){
    		groceryListService.delete(listId);
    		return new ResponseEntity<String>("Lista raderad!", HttpStatus.OK);
    	} else {
    		return new ResponseEntity<String>("Du kan bara ta bort dina egna shoppinglistor!", HttpStatus.UNAUTHORIZED);
    	}
	}
	
	
	// add product to grocery list, (volume is sent in body as {"volume":"13"} );
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "add_product_to_grocery_list/{listId}/product/{productId}", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> addProductToGroceryList(@PathVariable int productId, @PathVariable int listId, @RequestBody int volume){
				
		// get grocery list
		GroceryList groceryList = groceryListService.getGroceryList(listId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();
    	
    	// get the list owner 
    	User owner = groceryList.getListOwner();
    	
    	// debug ( method tested but not with security in place)
    	System.out.println(owner.getUsername() + " " + user);

    	// check if the user is in fact the list owner
    	if(owner.getUsername().equals(user)){
    		
    		// get product
    		Product productToAdd = productService.getProduct(productId);	
    		
    		// set GroceryListProduct and volume
    		GroceryListProduct groceryListProduct = new GroceryListProduct();
    		groceryListProduct.setGroceryList(groceryList);
    		groceryListProduct.setProduct(productToAdd);
    		groceryListProduct.setVolume(volume);
    		
    		// get products in grocery list
    		Set<GroceryListProduct> productsInList = groceryList.getGroceryListProducts();
    		
    		// add the new product
    		if(!productsInList.add(groceryListProduct)){
    			groceryListProduct = null;
        		return new ResponseEntity<String>(productToAdd.getName() + " finns redan i " + groceryList.getName(), HttpStatus.BAD_REQUEST);
    		}
    		
    		// set the new products list
    		groceryList.setGroceryListProducts(productsInList);
    		
    		// edit
    		groceryListService.edit(groceryList);

    		return new ResponseEntity<String>(productToAdd.getName() + " tillagd i " + groceryList.getName(), HttpStatus.OK);
    	} else {
    		return new ResponseEntity<String>("Du kan inte lägga till produkter i listor som inte är dina!", HttpStatus.UNAUTHORIZED);
    	}	
	}
	
	
	

	// remove product from grocery list
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "delete_product_from_grocery_list/{listId}/product/{productId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> deleteProductFromGroceryList(@PathVariable int productId, @PathVariable int listId){
				
		// get grocery list
		GroceryList groceryList = groceryListService.getGroceryList(listId);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();
    	
    	// get the list owner 
    	User owner = groceryList.getListOwner();
    	
    	// debug ( method tested but not with security in place)
    	System.out.println(owner.getUsername() + " " + user);

    	// check if the user is in fact the list owner
    	if(owner.getUsername().equals(user)){
		
    		// get product
    		Product productToRemove = productService.getProduct(productId);	
    		
    		// set GroceryListProduct
    		GroceryListProduct groceryListProduct = new GroceryListProduct();
    		groceryListProduct.setGroceryList(groceryList);
    		groceryListProduct.setProduct(productToRemove);
    		
    		// get products in grocery list
    		Set<GroceryListProduct> productsInList = groceryList.getGroceryListProducts();
    		
    		// remove the new product
    		if(!productsInList.remove(groceryListProduct)){
    			groceryListProduct = null;
        		return new ResponseEntity<String>(productToRemove.getName() + " finns inte i " + groceryList.getName(), HttpStatus.BAD_REQUEST);
    		}
    		
    		// set new products list
    		groceryList.setGroceryListProducts(productsInList);
    		
    		// edit
    		groceryListService.edit(groceryList);
    		
    		return new ResponseEntity<String>(productToRemove.getName() + " raderad ur " + groceryList.getName(), HttpStatus.OK);
    		
    	} else {
    		return new ResponseEntity<String>("Du kan inte ta bort produkter ur listor som inte är dina!", HttpStatus.UNAUTHORIZED);
    	}	
	}
	
	
	
	// TODO Stöd för att kunna lägga till/ ta bort exemplar av produkten (volume) handle exceptions!
}



