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

import se.royalspades.model.Brand;
import se.royalspades.model.User;
import se.royalspades.service.BrandService;
import se.royalspades.service.UserService;

@Controller
@RequestMapping(value ="/api/brand")
public class BrandController {
	@Autowired BrandService brandService;
	@Autowired UserService userService;
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(BrandController.class);
	
	// return all brands
	@SuppressWarnings("unchecked")
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value ="/all", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Brand> getAllBrandsResponse(){
		return brandService.getAllBrands();
	}
	
	// return single brand with id
	@Secured({"ROLE_USER","ROLE_ADMIN","ROLE_MODERATOR","ROLE_SUPERVISOR"})
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public Brand getSingleBrandResponse(@PathVariable int id){
		return brandService.getBrand(id);
	}
	
	
	// return brand/brands for owner
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value = "/owner/{ownerId}", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
	public @ResponseBody List<Brand> getOwnerBrands(@PathVariable int ownerId){
		@SuppressWarnings("unchecked")
		// get all brands
		List<Brand> brands = brandService.getAllBrands();
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();

		// list with brands to be returned
		List<Brand> brandsToReturn = new ArrayList<Brand>();
		
    	// check if the user requesting this is the same as the brand owner
    	if(user.equals(userService.getUser(ownerId).getUsername())){
    		
    		for(Brand brand : brands){
    			if(brand.getUser().getId() == ownerId){
    				brandsToReturn.add(brand);
    			}
    		}
    	}

		return brandsToReturn;
	}
	
	// add new brand
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/add_brand/{userId}", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> add(@RequestBody @Valid Brand brand, @PathVariable int userId){
				
		List<Brand>brands = brandService.getAllBrands();
		
		// check if a brand with that name exists
		for(Brand b : brands){
			if(b.getName().equals(brand.getName())){
				return new ResponseEntity<String>("En leverantör vid namn " + brand.getName() + " finns redan!", HttpStatus.BAD_REQUEST);
			}
		}
		
		// set the brand user
		User user = userService.getUser(userId);
		brand.setUser(user);
		
		brandService.add(brand);
		return new ResponseEntity<String>("Leverantör " + brand.getName() + " skapad!", HttpStatus.OK);	
	} 
	
	
	// edit brand
	@SuppressWarnings("unchecked")
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/edit_brand/{userId}", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editBrand(@RequestBody @Valid Brand brand, @PathVariable int userId){
		
		List<Brand>brands = brandService.getAllBrands();
		
		// check if a brand with that name exists
		for(Brand b : brands){
			if(b.getName().equals(brand.getName()) && b.getId() != brand.getId()){
				return new ResponseEntity<String>("En leverantör vid namn " + brand.getName() + " finns redan!", HttpStatus.BAD_REQUEST);
			}
		}
		
		// set the brand user
		User user = userService.getUser(userId);
	    brand.setUser(user);
			
		brandService.edit(brand);
		return new ResponseEntity<String>("Leverantör " + brand.getName() + " ändrad!", HttpStatus.OK);	
		
	}
	
	
	// edit brand, if you are the owner
	@SuppressWarnings("unchecked")
	@Secured("ROLE_SUPERVISOR")
	@RequestMapping(value = "/edit_my_brand", method = RequestMethod.PUT, consumes = { MediaType.APPLICATION_JSON_VALUE }, produces = "application/json; charset=utf-8")
	ResponseEntity<String> editMyBrand(@RequestBody @Valid Brand brand){
		
		List<Brand>brands = brandService.getAllBrands();
		
		// check if a brand with that name exists
		for(Brand b : brands){
			if(b.getName().equals(brand.getName()) && b.getId() != brand.getId()){
				return new ResponseEntity<String>("En leverantör vid namn " + brand.getName() + " finns redan!", HttpStatus.BAD_REQUEST);
			}
		}
		
		// get the user calling the method
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String user = authentication.getName();
		
		// check if the user calling the method is the owner of the brand
    	if(user.equals(brand.getUser().getUsername())){
    		brandService.edit(brand);
    		return new ResponseEntity<String>("Leverantör " + brand.getName() + " ändrad!", HttpStatus.OK);	
    	} else {
    		return new ResponseEntity<String>("Du kan inte ändra en leverantör du inte är satt som ägare på", HttpStatus.UNAUTHORIZED);
    	}
	}
	
	
		
	// remove brand
	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "/admin/remove_brand/{brandId}", method = RequestMethod.DELETE, produces = "application/json; charset=utf-8")
	ResponseEntity<String> removeBrand(@PathVariable int brandId){
		Brand brand = brandService.getBrand(brandId);
		
		if(brand.getBrandProducts().size() == 0){	
			brandService.delete(brandId);
			return new ResponseEntity<String>("Leverantör raderad!", HttpStatus.OK);	
		} else {
			return new ResponseEntity<String>("Leverantör har produkter och kan inte raderas innan de tagits bort!", HttpStatus.BAD_REQUEST);	

		}

	}
}
  
