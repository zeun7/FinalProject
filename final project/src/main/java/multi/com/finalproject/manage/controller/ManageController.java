package multi.com.finalproject.manage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ManageController {
		
	@RequestMapping(value = "/manage.do",  method = RequestMethod.GET)
	public String manage() {
		log.info("/manage.do...");
		
		return "manage";
	}
}
