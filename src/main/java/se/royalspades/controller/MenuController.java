package se.royalspades.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/menu")
public class MenuController {
	
	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@RequestMapping(value = "/default", method = RequestMethod.GET)
	public String menuDefault(Locale locale, Model model) {
		
		//redirect to main page
		return "menu/default";
	}
	
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String menuAdmin(Locale locale, Model model) {
		
		//redirect to main page
		return "menu/admin";
	}
	
	@RequestMapping(value = "/producer", method = RequestMethod.GET)
	public String menuProducer(Locale locale, Model model) {
		
		//redirect to main page
		return "menu/producer";
	}
	
	@RequestMapping(value = "/shopowner", method = RequestMethod.GET)
	public String menuShopOwner(Locale locale, Model model) {
		
		//redirect to main page
		return "menu/shopowner";
	}
	
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String menuUser(Locale locale, Model model) {
		
		//redirect to main page
		return "menu/user";
	}

}
