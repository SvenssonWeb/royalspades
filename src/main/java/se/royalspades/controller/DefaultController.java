package se.royalspades.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DefaultController {

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(DefaultController.class);
	
	/**
	 * 	Mapping for the page displayed for default (before login)
	 */

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String welcome(Locale locale, Model model, HttpServletRequest request) {
		
		if(request.isUserInRole("ROLE_ADMIN")){
			// Admin
			return "redirect:/admin/";
		} else if(request.isUserInRole("ROLE_SUPERVISOR")){
			// Producer
			return "redirect:/producer/";
		} else if(request.isUserInRole("ROLE_MODERATOR")){
			// Shop owner
			return "redirect:/shopowner/";
		} else if(request.isUserInRole("ROLE_USER")){
			// Customer
			return "redirect:/home/";
		}
		
		// the index page
		model.addAttribute("pageUid", "2f5gdd560-8d89-33f2-cdd8-0120211c1s33" );
		return "index"; 
	}
	
	@RequestMapping("/main")
	public String mainDefault(Locale locale, Model model){
		// Default  - Main page
		model.addAttribute("pageUid", "1d6d5222-8d75-12e3-bca8-9089200c9a33" );
		
		return "default/main";
	}
	
	
	@RequestMapping("/help")
	public String help(Locale locale, Model model){
		// user - Help page
		model.addAttribute("pageUid", "ecae7380-8d76-11e3-baa8-0800200c9a66" );
		
		return "default/help";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		// login view
		model.addAttribute("pageUid", "2f5gdd560-8d75-11e3-cdd8-0220230c9a66" );
		return "default/login";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(Locale locale, Model model) {
		// sign up view
		model.addAttribute("pageUid", "225gdd560-8375-11e3-ad98-0223323c9a66" );
		return "default/signup";
	}
	
 
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
 
		// logout
		model.addAttribute("pageUid", "2f5gdd560-8d75-11e3-cdd8-0220230c9a66" );
		return "default/login";
	}
	
	
}
