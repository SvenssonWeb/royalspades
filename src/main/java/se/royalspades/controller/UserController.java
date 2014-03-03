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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import se.royalspades.model.Brand;
import se.royalspades.model.Store;
import se.royalspades.model.User;
import se.royalspades.model.Validation.PasswordValidation;
import se.royalspades.model.Validation.UserValidation;
import se.royalspades.service.BrandService;
import se.royalspades.service.StoreService;
import se.royalspades.service.UserService;

@Controller
@RequestMapping(value = "/api")
public class UserController {
	@Autowired UserService userService;
	@Autowired BrandService brandService;
	@Autowired StoreService storeService;
	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	// return a list with all users
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value ="/admin/user/all", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<User> getAllUsersResponse(){
		return userService.getAllUsers();
	}
	
	// return single user with id
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/user/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody User getSingleUserWithId(@PathVariable int id){
		User user = userService.getUser(id);
		return user;
	}
	
	// return single user
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/user/{userName}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody User getSingleUserResponse(@PathVariable String userName){
		User user = userService.getUserByUsername(userName);
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
		
    	if(username.equals(user.getUsername())){
    		return user;
    	} else {
    		return null;			
    	}
	}
	
	// return a list with all shop managers
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value ="/admin/user/shop_managers", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<User> getAllShopManagersResponse(){
		List<User> users = userService.getAllUsers();
		List<User> shopManagers = new ArrayList<User>();
		
		for(User user : users){
			if(user.getRole().equals("shopowner")){
				// if the user is a shop manager
				// add to that list
				shopManagers.add(user);
			}
		}
		
		return shopManagers;
	}
	
	// return a list with all brand managers
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value ="/admin/user/brand_managers", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<User> getAllBrandManagersResponse(){
		List<User> users = userService.getAllUsers();
		List<User> brandManagers = new ArrayList<User>();
		
		for(User user : users){
			if(user.getRole().equals("producer")){
				// if the user is a brand manager
				// add to that list
				brandManagers.add(user);
			}
		}
		
		return brandManagers;
	}
	
	
	// as admin, return a list with users requesting higher authority
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/get_users_requesting_higher_authority", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<User> getAllUsersRequestingHigherAuthority(){
		List<User> users = userService.getAllUsers();
		List<User> usersWaitingForAuthority = new ArrayList<User>();
		
		for(User user : users){
			if(user.getRequestedAuthority().length() > 1 && user.getRequestedAuthority() != null){
				// the user is awaiting some kind of new authority
				usersWaitingForAuthority.add(user);
			}
		}
	
		return usersWaitingForAuthority;
	}

	// add a new user
	@RequestMapping(value ="/admin/user/new_user", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity <String> createUser(@RequestBody @Valid User user) {		
		if(userService.checkIfUserExists(user.getUsername())){
			// if the user exists
			return new ResponseEntity<String>("Användarnamnet är upptaget! Välj ett annat.", HttpStatus.BAD_REQUEST);	
		} 
		
		if(!user.getPassword().equals(user.getPasswordConfirm())){
			// if the passwords don't match
			return new ResponseEntity<String>("Lösenorden matchar inte!", HttpStatus.BAD_REQUEST);	
		}
			
		// role for everyone, update at request
		user.setRole("user");
		user.setRequestedAuthority(" ");
			
		user.setPassword(passwordEncoder.encode(user.getPassword()));
			
		userService.add(user);						
			
		return new ResponseEntity<String>("Användarkonto för " + user.getUsername() + " skapat!", HttpStatus.OK);			
	}
	
	
	// modify a existing user as admin
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN") 
	@RequestMapping(value="/admin/user/edit_user", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity <String> editUser(@RequestBody @Valid UserValidation userValidation){	
		// after all values are validated, then set all values to User object.
		User user = new User();
		user.setId(userValidation.getId());
		user.setUsername(userValidation.getUsername());
		user.setFirstName(userValidation.getFirstName());
		user.setLastName(userValidation.getLastName());
		user.setEmail(userValidation.getEmail());
		userValidation = null;
		
		
		List<User> users = userService.getAllUsers();
		
		// if the username is taken
		for(User u : users){
			if(u.getUsername().equals(user.getUsername()) && u.getId() != user.getId()){
				return new ResponseEntity<String>("Användarnamnet är upptaget, Välj ett annat.", HttpStatus.BAD_REQUEST);
			}
		}
		
		// get current password
		User oldUser = userService.getUser(user.getId());
		
		// set same password and role
		user.setPassword(oldUser.getPassword());
		user.setRole(oldUser.getRole());
		user.setRequestedAuthority(oldUser.getRequestedAuthority());
		
		userService.edit(user);		
    	return new ResponseEntity<String>("Ändringar för " + user.getUsername() + " sparade!", HttpStatus.OK);
	}
	

	// modify your own account details
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value="/user/edit_account", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity <String> editYourUser(@RequestBody @Valid UserValidation userValidation){			
		// after all values are validated, then set all values to User object.
		User user = new User();
		user.setId(userValidation.getId());
		user.setUsername(userValidation.getUsername());
		user.setFirstName(userValidation.getFirstName());
		user.setLastName(userValidation.getLastName());
		user.setEmail(userValidation.getEmail());
		userValidation = null;
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
		
    	if(username.equals(user.getUsername())){
    		    				
			// get current password
			User oldUser = userService.getUser(user.getId());
			
			// set same password and role
			user.setPassword(oldUser.getPassword());
			user.setRole(oldUser.getRole());
			user.setRequestedAuthority(oldUser.getRequestedAuthority());
			
			userService.edit(user);		
	    	return new ResponseEntity<String>("Ändringar för " + user.getUsername() + " sparade!", HttpStatus.OK);
			
    	} else {
    		return new ResponseEntity<String>("Du kan inte ändra ett användarkonto som inte tillhör dig!", HttpStatus.UNAUTHORIZED);
    	}
	}
	
	// modify your own password
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value="/user/edit_password", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity <String> editYourPassword(@RequestBody @Valid PasswordValidation passwordValidation){			
		// get user with id
		User user = userService.getUser(passwordValidation.getId());
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
		
    	if(username.equals(user.getUsername())){
			
			// get current password
			String currentPassword = user.getPassword();
						
			// check if the password the user entered matches the old password     
			if(passwordEncoder.matches(passwordValidation.getOldPassword(), currentPassword)){
				
				//check if password equals passwordConfirm
				if(passwordValidation.getPassword().equals(passwordValidation.getPasswordConfirm())){
					// matches set password
					user.setPassword(passwordEncoder.encode(passwordValidation.getPassword()));
	    			userService.edit(user);
	    			
	    			return new ResponseEntity<String>("Lösenord ändrat!", HttpStatus.OK);
				} else {
					return new ResponseEntity<String>("Lösenorden matchar inte varandra!", HttpStatus.BAD_REQUEST);
				}

			} else {
				return new ResponseEntity<String>("Du angav fel lösenord!", HttpStatus.BAD_REQUEST);
			}
			
    	} else {
    		return new ResponseEntity<String>("Du kan inte ändra ett användarkonto som inte tillhör dig!", HttpStatus.UNAUTHORIZED);
    	}
	}

	
	@Secured("ROLE_ADMIN")
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/admin/remove_user/{userId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity <String> removeUser(@PathVariable int userId){
		
		List<Store> stores = storeService.getAllStores();
		List<Brand> brands = brandService.getAllBrands();
		
		// check if the user is a shop owner
		for(Brand brand : brands){
			if(brand.getUser().getId() == userId){
				return new ResponseEntity<String>("Kan inte ta bort en användare som är en leverantörägare!", HttpStatus.BAD_REQUEST);
			}
		}
		
		// check if the user is a brand owner
		for(Store store : stores){
			if(store.getUser().getId() == userId){
				return new ResponseEntity<String>("Kan inte ta bort en användare som är en butiksägare!", HttpStatus.BAD_REQUEST);
			}
		}
				
		userService.delete(userId);
		return new ResponseEntity<String>("Användare raderad!", HttpStatus.OK);
	}
	
	
	// as admin, set a new password for a user
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/set_new_password/user/{userId}", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity <String> setNewPassword(@RequestBody String password, @PathVariable int userId){
		
		if(password.length() > 45){
			return new ResponseEntity<String>("Lösenord måste vara mellan 5-45 tecken!", HttpStatus.BAD_REQUEST);
		} else if(password.length() < 5){
			return new ResponseEntity<String>("Lösenord måste vara mellan 5-45 tecken!", HttpStatus.BAD_REQUEST);	
		}
		
		User user = userService.getUser(userId);
		
		// password
		user.setPassword(passwordEncoder.encode(password));
		
		userService.edit(user);
		
		return new ResponseEntity<String>("Lösenord för " + user.getUsername() +" ändrat!", HttpStatus.OK);
	}
	
	
	// request a higher authority in the system   (just send the authority as data like "producer")
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/user/{userId}/request_authority", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity <String> requestAuthority(@PathVariable int userId, @RequestBody String authority){
		// get user
		User user = userService.getUser(userId);
				
		if(authority.length() > 40){
			return new ResponseEntity<String>("Max 40 tecken!", HttpStatus.BAD_REQUEST);
		} else if(authority.length() < 1){
			return new ResponseEntity<String>("Minst 1 tecken!", HttpStatus.BAD_REQUEST);
		}
		
		// check so we don't already have that authority or already have requested it
		if(user.getRole().equals(authority)){
			return new ResponseEntity<String>("Du har redan denna behörigheten!", HttpStatus.BAD_REQUEST);
		} else if(user.getRequestedAuthority() != null && user.getRequestedAuthority().equals(authority)){
			return new ResponseEntity<String>("Du har redan begärt denna behörighet!", HttpStatus.BAD_REQUEST);
		} else {
			// set requested authority
			user.setRequestedAuthority(authority);
			userService.edit(user);
			return new ResponseEntity<String>("Högre behörighet begärd!", HttpStatus.OK);
		}
	}
	
	
	// as admin, authorize a higher authority
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/authorize/user/{userId}", method = RequestMethod.PUT, produces = "application/json; charset=utf-8")
	ResponseEntity <String> authorizeRequestedAuthority(@PathVariable int userId, @RequestBody String authority){

		if(!authority.equals("shopowner") && !authority.equals("producer") && !authority.equals("admin") && !authority.equals("user")){
			return new ResponseEntity<String>("Behörighet finns inte i systemt!", HttpStatus.BAD_REQUEST);
		}
		
		// get user
		User user = userService.getUser(userId);
		user.setRole(authority);
		user.setRequestedAuthority(" ");
		userService.edit(user);
		
		return new ResponseEntity<String>(user.getUsername() + " har nu behörighet: " + user.getRole() + "!", HttpStatus.OK);
	}

}

