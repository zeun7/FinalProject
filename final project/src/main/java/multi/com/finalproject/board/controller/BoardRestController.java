package multi.com.finalproject.board.controller;

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
import multi.com.finalproject.board.service.BoardService;

@Controller
@Slf4j
public class BoardRestController {
	
	@Autowired
	BoardService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_b_selectAll.do", method = RequestMethod.GET)
	public List<BoardVO> json_b_selectAll(BoardVO vo, int page, int limit) {
		log.info("/json_b_selectAll.do...{}, {}", page, limit);
		log.info("vo: {}", vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		map.put("limit", limit);
		
		List<BoardVO> vos = service.selectAll(map);
		log.info("{}", vos);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_count.do", method = RequestMethod.GET)
	public int json_b_count(BoardVO vo) {
		log.info("/json_b_count.do...{}", vo);
		
		int count = service.count(vo);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_searchList.do", method = RequestMethod.GET)
	public List<BoardVO> json_b_searchList(BoardVO vo, int page, int limit, String searchKey, String searchWord) {
		log.info("/json_b_searchList.do...{}", vo);
		log.info("page:{}, limit:{}", page, limit);
		log.info("searchKey:{}", searchKey);
		log.info("searchWord:{}", searchWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		map.put("limit", limit);
		map.put("searchKey", searchKey);
		map.put("searchWord", "%"+searchWord+"%");
		
		List<BoardVO> vos = service.searchList(map);
		log.info("{}", vos);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_like.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_like(int num, int bnum) {
		log.info("/json_b_searchList.do...");
		log.info("num:{}", num);
		log.info("bnum:{}", bnum);
		
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("num", num);
		param.put("bnum", num);
		
		int result = service.like(param);
		log.info("result:{}", result);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_report.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_report(BoardVO vo) {
		log.info("/json_b_report.do...{}", vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		return map;
	}	
}