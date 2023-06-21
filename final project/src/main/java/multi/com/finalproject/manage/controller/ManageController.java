package multi.com.finalproject.manage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.manage.service.ManageService;
import multi.com.finalproject.member.model.MemberVO;


@Slf4j
@Controller
public class ManageController {
	
	@Autowired
	ManageService service;
	
	@RequestMapping(value = "/manage.do",  method = RequestMethod.GET)
	public String manage() {
		log.info("/manage.do...");
		
		return "manage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mng_member.do",  method = RequestMethod.GET)
	public List<MemberVO> json_mng_member() {
		log.info("/json_mng_member.do...");
		
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
