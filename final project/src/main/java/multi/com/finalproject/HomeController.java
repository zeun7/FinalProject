package multi.com.finalproject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	@RequestMapping(value = {"/", "home.do"}, method = RequestMethod.GET)
	public String home() {
		log.info("home.do");
		
		return "home";
	}
	
	@RequestMapping(value = "/manage.do",  method = RequestMethod.GET)
	public String manage() {
		log.info("manage.do");
		
		return "manage";
	}
}
