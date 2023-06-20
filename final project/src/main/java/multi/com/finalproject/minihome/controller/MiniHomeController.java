package multi.com.finalproject.minihome.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.minihome.model.MiniHomeVO;

@Slf4j
@Controller
public class MiniHomeController {
	
	
	@RequestMapping(value = "/mini_home.do", method = RequestMethod.GET)
	public String mini_home() {
		log.info("mini_home()...");
		
		return "mini/minihome";
	}
	
	@RequestMapping(value = "/mini_update.do", method = RequestMethod.POST)
	public String mini_update() {
		log.info("mini_update()...");
		
		return "mini/update";
	}
	
	@RequestMapping(value = "/mini_updateOK.do", method = RequestMethod.GET)
	public String mini_updateOK(MiniHomeVO vo) {
		log.info("mini_update()...");
		
		return "mini/update";
	}
	
	@RequestMapping(value = "/mini_random.do", method = RequestMethod.GET)
	public String mini_random() {
		log.info("mini_random()...");
		
		return "mini/minihome";
	}
	
	@RequestMapping(value = "/mini_visit.do", method = RequestMethod.GET)
	public String mini_visit() {
		log.info("mini_visit()...");
		
		return "mini/visit/visit";
	}
	
	@RequestMapping(value = "/mini_game.do", method = RequestMethod.GET)
	public String mini_game() {
		log.info("mini_game()...");
		
		return "mini/game/game";
	}
	
	
}
