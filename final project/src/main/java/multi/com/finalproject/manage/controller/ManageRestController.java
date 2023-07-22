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
import multi.com.finalproject.manage.model.FriendsVO;
import multi.com.finalproject.manage.model.ReportVO;
import multi.com.finalproject.manage.service.ManageService;
import multi.com.finalproject.member.model.MemberVO;


@Slf4j
@Controller
public class ManageRestController {
	
	@Autowired
	ManageService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_m_friends.do", method = RequestMethod.GET)
	public List<FriendsVO> json_m_friends(FriendsVO vo) {
		log.info("/json_m_friends.do...{}", vo);
		
		List<FriendsVO> vos = service.friends(vo);
		for (FriendsVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_grade.do", method = RequestMethod.GET)
	public Map<String, Integer> json_mng_grade(FriendsVO vo) {
		log.info("/json_mng_grade.do...{}", vo);
		
		int result = service.grade(vo);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("{}", map);
		
		return map;
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
	@RequestMapping(value = "/json_m_bans.do", method = RequestMethod.GET)
	public List<FriendsVO> json_m_bans(FriendsVO vo) {
		log.info("/json_m_bans.do...{}", vo);
		
		List<FriendsVO> vos = service.selectBan(vo);
		for (FriendsVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_addban.do", method = RequestMethod.GET)
	public Map<String, Integer> json_m_addban(String nickname1, String nickname2) {
		log.info("/json_m_addban.do...");
		log.info("{}, {}", nickname1, nickname2);
		MemberVO vo = new MemberVO();
		MemberVO vo2 = new MemberVO();
		vo.setNickname(nickname1);
		vo2.setNickname(nickname2);
		
		int result = service.addBan(vo, vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_newban.do", method = RequestMethod.GET)
	public Map<String, Integer> json_m_newban(String nickname1, String nickname2) {
		log.info("/json_m_newban.do...");
		log.info("{}, {}", nickname1, nickname2);
		MemberVO vo = new MemberVO();
		MemberVO vo2 = new MemberVO();
		vo.setNickname(nickname1);
		vo2.setNickname(nickname2);
		
		int result = service.newBan(vo, vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_delban.do", method = RequestMethod.GET)
	public Map<String, Integer> json_m_delban(String nickname1, String nickname2) {
		log.info("/json_m_delban.do...");
		log.info("{}, {}", nickname1, nickname2);
		MemberVO vo = new MemberVO();
		MemberVO vo2 = new MemberVO();
		vo.setNickname(nickname1);
		vo2.setNickname(nickname2);
		
		int result = service.delBan(vo, vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_member.do",  method = RequestMethod.GET)
	public List<MemberVO> json_mng_member(Integer page) {
		log.info("/json_mng_member.do...{}", page);
		
		List<MemberVO> vos = service.member(page);
		for (MemberVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_mcount.do",  method = RequestMethod.GET)
	public Integer json_mng_mcount() {
		log.info("/json_mng_mcount.do...");
		
		int count = service.mcount();
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_mclass.do",  method = RequestMethod.POST)
	public Integer json_mng_mclass(MemberVO vo) {
		log.info("/json_mng_mclass.do...");
		
		int result = service.mclass(vo);
		log.info("result: {}", result);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_board.do",  method = RequestMethod.GET)
	public List<ReportVO> json_mng_board() {
		log.info("/json_mng_board.do...");
		
		List<ReportVO> vos = service.board();
		
		for(ReportVO vo : vos) {
			log.info("{}", vo.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_bcount.do",  method = RequestMethod.GET)
	public Integer json_mng_bcount() {
		log.info("/json_mng_bcount.do...");
		
		int count = service.bcount();
		log.info("board & miniboard count: {}", count);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_b_deleteOK.do",  method = RequestMethod.GET)
	public Integer json_mng_b_deleteOK(ReportVO vo) {
		log.info("/json_mng_b_deleteOK.do...{}", vo.getBnum());
		
		int result = service.del_board(vo);
		log.info("result: {}", result);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_comments.do",  method = RequestMethod.GET)
	public List<ReportVO> json_mng_comments() {
		log.info("/json_mng_comments.do...");
		
		List<ReportVO> vos = service.comments();
		List<ReportVO> vos2 = service.minicomments();
		
		vos.addAll(vos2);
		
		for (ReportVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_ccount.do",  method = RequestMethod.GET)
	public Integer json_mng_ccount() {
		log.info("/json_mng_ccount.do...");
		
		int count = service.ccount();
		log.info("count: {}", count);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_c_deleteOK.do",  method = RequestMethod.GET)
	public Integer json_mng_c_deleteOK(ReportVO vo) {
		log.info("/json_mng_c_deleteOK.do...");
		
		int result = service.del_comments(vo);
		log.info("result: {}", result);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_report_deleteOK.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_report_deleteOK(ReportVO vo) {
		log.info("/json_b_report_deleteOK.do...{}", vo);
		
		ReportVO vo2 = service.select_report(vo);
		
		int result = service.del_b_report(vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_report_deleteOK.do", method = RequestMethod.GET)
	public Map<String, Integer> json_c_report_deleteOK(ReportVO vo) {
		log.info("/json_c_report_deleteOK.do...{}", vo);
		
		ReportVO vo2 = service.select_report(vo);
		
		int result = service.del_c_report(vo2);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		log.info("result: {}", map);
		
		return map;
	}
	
}
