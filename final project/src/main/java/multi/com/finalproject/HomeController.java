package multi.com.finalproject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.home.HomeService;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

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
	
	@RequestMapping(value = "/template.do", method = RequestMethod.GET)
	public String template() {
		log.info("/template.do...");
		
		return "template";
	}
	
	@RequestMapping(value = "/dashboard.do", method = RequestMethod.GET)
	public String dashboard() {
		log.info("/dashboard.do...");
		
		return "dashboard";
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_post_friends.do",  method = RequestMethod.GET)
	public List<MiniBoardVO> json_post_friends(MemberVO vo, int limit, String sortKey) {
		log.info("/json_post_friends.do...");
		log.info("vo:{}", vo);
		log.info("limit:{}", limit);
		log.info("sortKey:{}", sortKey);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", vo.getId());
		map.put("limit", limit);
		map.put("sortKey", sortKey);
		
		List<MiniBoardVO> vos = service.friends_post(map);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_post_board.do",  method = RequestMethod.GET)
	public List<BoardVO> json_post_board(BoardVO vo, int limit, String sortKey) {
		log.info("/json_post_board.do...");
		log.info("vo:{}", vo);
		log.info("limit:{}", limit);
		log.info("sortKey:{}", sortKey);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bname", vo.getBname());
		map.put("limit", limit);
		map.put("sortKey", sortKey);
		
		List<BoardVO> vos = service.board_post(map);
		
		return vos;
	}

}