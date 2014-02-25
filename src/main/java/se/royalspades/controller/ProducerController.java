package se.royalspades.controller;

import java.security.Principal;
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
@RequestMapping(value = "/producer")
public class ProducerController {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ProducerController.class);	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//Redirecta till index
		return "index";
	}
	
	
	@RequestMapping("/main")
	public String main(Locale locale, Model model){
		//Producer - Main page
		model.addAttribute("pageUid", "933c95a0-8d78-11e3-baa8-0800200c9a66" );
		
		return "producer/main";
	}
	
	@RequestMapping("/categories")
	public String categories(Locale locale, Model model){
		//Producer - categories page
		model.addAttribute("pageUid", "9a3b3410-8d78-11e3-baa8-0800200c9a666" );
		
		
		return "producer/categories";
	}
	
	@RequestMapping("/wares")
	public String wares(Locale locale, Model model, Principal principal){
		//Producer - wares page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
		model.addAttribute("pageUid", "a1d6aec0-8d78-11e3-baa8-0800200c9a66" );
	
		
		return "producer/wares";
	}
	
	@RequestMapping("/settings")
	public String settings(Locale locale, Model model, Principal principal){
		//Producer - wares page
        final String currentUser = principal.getName();
        model.addAttribute("username", currentUser);
		model.addAttribute("pageUid", "d2d3dec0-9d78-99e3-bda8-1230246c9a66" );
		
		return "producer/settings";
	}
	
	@RequestMapping("/help")
	public String help(Locale locale, Model model){
		//Producer - wares page
		model.addAttribute("pageUid", "c1d6dec0-8d78-99e3-baa8-0230246c9a66" );
		
		
		return "producer/help";
	}
}
