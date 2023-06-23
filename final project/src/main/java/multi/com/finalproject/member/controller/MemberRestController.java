package multi.com.finalproject.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MemberService;


@Controller
@Slf4j
public class MemberRestController {
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/json_m_selectAll.do", method = RequestMethod.GET)
	public List<MemberVO> json_m_selectAll() {
		log.info("/json_m_selectAll.do");
		
		List<MemberVO> vos = service.selectAll();
		
		return vos;
	}
	
	@RequestMapping(value = "/json_m_selectOne.do", method = RequestMethod.GET)
	public MemberVO json_m_selectOne(MemberVO vo) {
		log.info("/json_mv_selectAll.do");
		
		MemberVO vo2 = service.selectOne(vo);
		if(vo2==null) vo2 = vo;
		return vo2;
	
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_idCheck.do", method = RequestMethod.GET)
	public String json_m_idCheck(MemberVO vo) {
		log.info("/json_m_idCheck.do...{}",vo);
		
		MemberVO vo2 = service.idCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_NickCheck.do", method = RequestMethod.GET)
	public String json_m_NickCheck(MemberVO vo) {
		log.info("/json_m_NickCheck.do...{}",vo);
		
		MemberVO vo2 = service.NickCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}

	
	@ResponseBody
	@RequestMapping(value = "/json_m_friends.do", method = RequestMethod.GET)
	public List<MemberVO> json_m_friends(MemberVO vo) {
		log.info("/json_m_friends.do...{}", vo);
		
		List<MemberVO> vos = service.friends(vo);
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
}

