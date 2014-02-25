package se.royalspades.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/shopowner")
public class ShopOwnerController {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ShopOwnerController.class);
	
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
		//Producer - Main page
		model.addAttribute("pageUid", "7ada6860-8d79-11e3-baa8-0800200c9a66" );
		
		return "shopowner/main";
	}
	
	@RequestMapping("/help")
	public String help(Locale locale, Model model){
		//ShopOwner - help page
		model.addAttribute("pageUid", "83bf04e0-8d79-11e3-baa8-0800200c9a66" );
		
		
		return "shopowner/help";
	}
	
	@RequestMapping("/settings")
	public String settings(Locale locale, Model model){
		//ShopOwner - wares page
		model.addAttribute("pageUid", "8f93bc70-8d79-11e3-baa8-0800200c9a66" );
		
		
		return "shopowner/settings";
	}
}
