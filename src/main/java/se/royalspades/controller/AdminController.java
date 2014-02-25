package se.royalspades.controller;

import java.security.Principal;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/admin")
public class AdminController {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		//Redirecta till main
		return "index";
	}
	
	
	@RequestMapping("/main")
	public String main(Locale locale, Model model){
		//Admin - Main page
		model.addAttribute("pageUid", "9e60de60-8d77-11e3-baa8-0800200c9a66" );
		
		return "admin/main";
	}
	
	@RequestMapping("/help")
	public String help(Locale locale, Model model){
		//Admin - Help page
		model.addAttribute("pageUid", "1c63de21-99cc-21e3-baa8-9830222c9a66" );
		
		return "admin/help";
	}
	
	@RequestMapping("/apihelp")
	public String apiHelp(Locale locale, Model model){
		//Admin - API Help page
		model.addAttribute("pageUid", "1c33de21-22cc-21e3-b1a8-1830222c9a66" );
		
		return "admin/apihelp";
	}
	
	@RequestMapping("/settings")
	public String settings(Locale locale, Model model, Principal principal){
		//Admin - API Help page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
		model.addAttribute("pageUid", "aa33de21-23cc-44e3-baa8-2230222c9a66" );
		
		return "admin/settings";
	}
	
	@RequestMapping("/shops")
	public String shop(Locale locale, Model model){
		//Admin - shop page
		model.addAttribute("pageUid", "a82b9520-8d77-11e3-baa8-0800200c9a66" );
		
		
		return "admin/shops";
	}
	
	@RequestMapping("/suppliers")
	public String supplier(Locale locale, Model model){
		//Admin - supplier page
		model.addAttribute("pageUid", "ae8fef60-8d77-11e3-baa8-0800200c9a66" );
		
		
		return "admin/suppliers";
	}
	
	
	@RequestMapping("/newSupplier")
	public String newSupplier(Locale locale, Model model){
		//Admin - supplier page
		model.addAttribute("pageUid", "ad1gef60-8d22-33r3-baa8-0555020c9r66" );
		
		
		return "admin/newSupplier";
	}
	
	@RequestMapping("/editSupplier")
	public String editSupplier(Locale locale, Model model, @RequestParam(value = "id", required = true) int id){
		//Admin - supplier page
		model.addAttribute("pageUid", "cfcd9e0b-c1cd-4122-9486-b96cb026bb3c" );
		
		model.addAttribute("id", id);

		return "admin/editSupplier";
	}
	
	
	@RequestMapping("/users")
	public String user(Locale locale, Model model){
		//Admin - user page
		model.addAttribute("pageUid", "b8d6db00-8d77-11e3-baa8-0800200c9a66" );
		
		
		return "admin/user";
	}
	
	@RequestMapping("/editShop")
	public String editShop(Locale locale, Model model, @RequestParam(value = "id", required = true) int id){
		//Admin - edit shop page
		model.addAttribute("pageUid", "39af771a-f069-4e2a-bce9-bd2e2f8b383a" );
		
		model.addAttribute("id", id);
		
		return "admin/editShop";
	}
	
	@RequestMapping("/newShop")
	public String newShop(Locale locale, Model model){
		//Admin - new shop page
		model.addAttribute("pageUid", "cf3daa14-80ef-4da3-9d4e-e00ad67174cf" );
		
		
		return "admin/newShop";
	}
	
	@RequestMapping("/categories")
	public String categories(Locale locale, Model model) {
		//Admin - administration of categories 
		model.addAttribute("pageUid","cf3daa14-80ef-4da3-7f9a-e00ad67174cf" );
		
		return "admin/categories";
		
	}
}
