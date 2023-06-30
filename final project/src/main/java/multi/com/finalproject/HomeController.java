package multi.com.finalproject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.home.HomeService;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	HomeService service;
	
	@RequestMapping(value = {"/", "/home.do"}, method = RequestMethod.GET)
	public String home() {
		log.info("/home.do...");
		
		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_post_friends.do",  method = RequestMethod.GET)
	public List<BoardVO> json_post_friends() {
		log.info("/json_post_friends.do...");
		
		List<BoardVO> vos = service.friends_post();
		
		return vos;
	}
	

}
