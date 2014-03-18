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


@Controller
public class HomeController {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);	
	
	/**
	 * 	Mapping for the page displayed to customers
	 */
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		// the index page
		return "index";
	}
	
	@RequestMapping("/home/main")
	public String main(Locale locale, Model model, Principal principal){
		// user - Main page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
		model.addAttribute("pageUid", "1a6d5630-8d75-11e3-baa8-0800200c9a66" );
		
		return "home/main";
	}
	
	@RequestMapping("/home/help")
	public String help(Locale locale, Model model){
		// user - Help page
		model.addAttribute("pageUid", "ecae7380-8d76-11e3-baa8-0800200c9a66" );
		
		return "home/help";
	}
	
	@RequestMapping("/home/newgrocerybag")
	public String newgrocerybag(Locale locale, Model model, Principal principal){
		// user - New grocery bag page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
		model.addAttribute("pageUid", "f5cb8520-8d76-11e3-baa8-0800200c9a66" );
		
		return "home/newgrocerybag";
	}
	
	@RequestMapping("/home/editgrocerybag")
	public String editgrocerybag(Locale locale, Model model, Principal principal, @RequestParam(value = "id", required = true) int id){
		// user - Edit grocery bag page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
        model.addAttribute("groceryBagId", id);
		model.addAttribute("pageUid", "ffcb8520-8d76-33e3-bcc8-3850211c9a66" );
		
		return "home/editgrocerybag";
	}
	
	@RequestMapping("/home/settings")
     public String settings(Locale locale, Model model, Principal principal){
        // user - Settings page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
        model.addAttribute("pageUid", "fd2e63a0-8d76-11e3-baa8-0800200c9a66" );

        return "home/settings";
    }
    @RequestMapping("/home/compare")
    public String compare(Locale locale, Model model, Principal principal){
        // user - Settings page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
        model.addAttribute("pageUid", "ffcb8520-8d76-33e3-bcc8-3850222c9a66" );

        return "home/compare";
    }

}
