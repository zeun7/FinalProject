package multi.com.finalproject.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.board.service.BoardService;


@Controller
@Slf4j
public class BoardController {
	
	@Autowired
	BoardService service;
	
	@RequestMapping(value = "/b_selectAll.do", method = RequestMethod.GET)
	public String b_selectAll() {
		log.info("/b_selectAll.do...");
		
		return "board/selectAll";
	}
	
	@RequestMapping(value = "/b_selectOne.do", method = RequestMethod.GET)
	public String b_selectOne(BoardVO vo, Model model) {
		log.info("/b_selectOne.do...{}", vo);
		
		service.vcountUp(vo);
		
		BoardVO vo2 = service.selectOne(vo);
		log.info("vo2:{}", vo2);
		model.addAttribute("vo2", vo2);
		
		return "board/selectOne";
	}
	
	@RequestMapping(value = "/b_insert.do", method = RequestMethod.GET)
	public String b_insert() {
		log.info("/b_insert.do...");
		
		return "board/insert";
	}
	
	@RequestMapping(value = "/b_update.do", method = RequestMethod.GET)
	public String b_update(Model model, BoardVO vo) {
		log.info("/b_update.do...{}", vo);
		
		BoardVO vo2 = service.selectOne(vo);
		model.addAttribute("vo2", vo2);
		
		return "board/update";
	}
	
	@RequestMapping(value = "/b_insertOK.do", method = RequestMethod.POST)
	public String b_insertOK(BoardVO vo) {
		log.info("/b_insertOK.do...{}", vo);
		
		int result = service.insert(vo);
		log.info("result:{}", result);
		
		if(result == 1) {
			return "redirect:b_selectAll.do?bname="+vo.getBname();
		}else {
			return "redirect:b_insert.do?bname="+vo.getBname();
		}
	}
	
	@RequestMapping(value = "/b_updateOK.do", method = RequestMethod.POST)
	public String b_updateOK(BoardVO vo) {
		log.info("/b_updateOK.do...{}", vo);
		
		int result = service.update(vo);
		log.info("result:{}", result);
		
		if(result == 1) {
			return "redirect:b_selectOne.do?bnum="+vo.getBnum();
		}else {
			return "redirect:b_update.do";
		}
	}
	
	@RequestMapping(value = "/b_deleteOK.do", method = RequestMethod.GET)
	public String b_deleteOK(BoardVO vo) {
		log.info("/b_deleteOK.do...{}", vo);
		
		int result = service.delete(vo);
		log.info("result:{}", result);
		
		if(result == 1) {
			return "redirect:b_selectAll.do?bname="+vo.getBname();
		}else {
			return "redirect:b_selectOne.do?bnum="+vo.getBnum();
		}
	}
}