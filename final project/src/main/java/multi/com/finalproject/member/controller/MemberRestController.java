package multi.com.finalproject.member.controller;

import java.util.List;

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
		log.info("/json_m_selectOne.do");
		
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

	
	
}
