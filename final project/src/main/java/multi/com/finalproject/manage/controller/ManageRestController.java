package multi.com.finalproject.manage.controller;

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
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.manage.model.ManageFriendsVO;
import multi.com.finalproject.manage.service.ManageService;
import multi.com.finalproject.member.model.MemberVO;


@Slf4j
@Controller
public class ManageRestController {
	
	@Autowired
	ManageService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_m_friends.do", method = RequestMethod.GET)
	public List<ManageFriendsVO> json_m_friends(ManageFriendsVO vo) {
		log.info("/json_m_friends.do...{}", vo);
		
		List<ManageFriendsVO> vos = service.friends(vo);
		log.info("{}", vos);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_searchUser.do", method = RequestMethod.GET)
	public List<MemberVO> json_m_searchUser(MemberVO vo, String searchWord) {
		log.info("/json_m_searchUser.do...{}", vo);
		log.info("searchWord: {}", searchWord);
		
		List<MemberVO> vos = service.searchUser(vo, searchWord);
		log.info("{}", vos);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_friendsAdd.do", method = RequestMethod.GET)
	public Map<String, Integer> json_m_friendsAdd(String nickname1, String nickname2) {
		log.info("/json_m_friendsAdd.do...");
		log.info("{}, {}", nickname1, nickname2);
		MemberVO vo = new MemberVO();
		MemberVO vo2 = new MemberVO();
		vo.setNickname(nickname1);
		vo2.setNickname(nickname2);
		
		int result = service.addfriend(vo, vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_friendsDel.do", method = RequestMethod.GET)
	public Map<String, Integer> json_m_friendsDel(String nickname1, String nickname2) {
		log.info("/json_m_friendsDel.do...");
		log.info("{}, {}", nickname1, nickname2);
		MemberVO vo = new MemberVO();
		MemberVO vo2 = new MemberVO();
		vo.setNickname(nickname1);
		vo2.setNickname(nickname2);
		
		int result = service.delfriend(vo, vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_member.do",  method = RequestMethod.GET)
	public List<MemberVO> json_mng_member() {
		log.info("/json_mng_member.do...testest");
		
		List<MemberVO> vos = service.member();
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_board.do",  method = RequestMethod.GET)
	public List<BoardVO> json_mng_board() {
		log.info("/json_mng_board.do...");
		
		List<BoardVO> vos = service.board();
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_comments.do",  method = RequestMethod.GET)
	public List<CommentsVO> json_mng_comments() {
		log.info("/json_mng_comments.do...");
		
		List<CommentsVO> vos = service.comments();
		
		return vos;
	}
}
