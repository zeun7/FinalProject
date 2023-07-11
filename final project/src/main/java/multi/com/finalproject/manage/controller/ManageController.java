package multi.com.finalproject.manage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.manage.model.ReportVO;
import multi.com.finalproject.manage.service.ManageService;
import multi.com.finalproject.member.model.MemberVO;


@Slf4j
@Controller
public class ManageController {
	
	@Autowired
	ManageService service;
	
	@RequestMapping(value = "/m_friends.do", method = RequestMethod.GET)
	public String m_friends(MemberVO vo, Model model) {
		log.info("/m_friends.do()...{}");
		
		return "friends";
	}
	
	@RequestMapping(value = "/manage.do",  method = RequestMethod.GET)
	public String manage() {
		log.info("/manage.do...");
		
		return "manage";
	}
	
	@RequestMapping(value = "/mng_selectOne.do",  method = RequestMethod.GET)
	public String mng_selectOne(ReportVO vo) {
		log.info("/mng_selectOne.do...");
		log.info("bnum: {}, mbnum: {}", vo.getBnum(), vo.getMbnum());
		log.info("id: {}", vo.getId());
		
		if(vo.getBnum() != 0)
			return "redirect:b_selectOne.do?bnum="+vo.getBnum();
		else
			return "redirect:diary_selectOne.do?id="+vo.getId()+"&mbnum="+vo.getMbnum();
		
	}
}
