package se.royalspades.controller;

import java.util.ArrayList;
import java.util.List;

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

import se.royalspades.model.Store;
import se.royalspades.model.User;
import se.royalspades.service.StoreService;
import se.royalspades.service.UserService;

@Controller
@RequestMapping(value ="/api/store")
public class StoreController {
	@Autowired StoreService storeService; 
	@Autowired UserService userService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(StoreController.class);
	
	// return all stores
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value ="/all", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Store> getAllStoresResponse(){
		return storeService.getAllStores();
	}
	
	
	// return single store with id
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public Store getSingleStoreResponse(@PathVariable int id){
		return storeService.getStore(id);
	}
	
	
	// return store/stores for owner
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value = "/owner/{ownerId}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Store> getOwnerStores(@PathVariable int ownerId){
		@SuppressWarnings("unchecked")
		// get all stores
		List<Store> stores = storeService.getAllStores();
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();

		// list with stores to be returned
		List<Store> storesToReturn = new ArrayList<Store>();
		
    	// check if the user requesting this is the same as the store owner
    	if(user.equals(userService.getUser(ownerId).getUsername())){
    		
    		for(Store store : stores){
    			if(store.getUser().getId() == ownerId){
    				storesToReturn.add(store);
    			}
    		}
    	}

		return storesToReturn;
	}
	
	// add new store, send user id as a url parameter
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/add_store/{userId}", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> addStore(@RequestBody @Valid Store store, @PathVariable int userId){
		
		// set the store user
		User user = userService.getUser(userId);
		store.setUser(user);
		
		storeService.add(store);
		return new ResponseEntity<String>("Butik " + store.getName() + " skapad!", HttpStatus.OK);	
	} 
	
	// edit store
	@Secured({"ROLE_ADMIN","ROLE_MODERATOR"})
	@RequestMapping(value = "/admin/edit_store/{userId}", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editStore(@RequestBody @Valid Store store, @PathVariable int userId){
		// set the store user
		User user = userService.getUser(userId);
		store.setUser(user);
		
		storeService.edit(store);
		return new ResponseEntity<String>("Butik " + store.getName() + " ändrad!", HttpStatus.OK);	
	}
	
	
	// edit store, if you are the owner
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value = "/edit_my_store", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editMyStore(@RequestBody @Valid Store store){
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();
		
		// check if the user calling the method is the owner of the brand
    	if(user.equals(store.getUser().getUsername())){
    		storeService.edit(store);
    		return new ResponseEntity<String>("Butik " + store.getName() + " ändrad!", HttpStatus.OK);	
    	} else {
    		return new ResponseEntity<String>("Du kan inte ändra en butik du inte är satt som ägare på", HttpStatus.UNAUTHORIZED);
    	}
	}
	
	
	// remove store
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/remove_store/{storeId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> removeStore(@PathVariable int storeId){
		
		Store store = storeService.getStore(storeId);
		
		if(store.getStoreProduct().size() == 0){
			storeService.delete(storeId);
			return new ResponseEntity<String>("Butik raderad!", HttpStatus.OK);	
		} else {
			return new ResponseEntity<String>("Butik har produkter och kan inte raderas innan de tagits bort!", HttpStatus.BAD_REQUEST);
		}

	}    
}
   
