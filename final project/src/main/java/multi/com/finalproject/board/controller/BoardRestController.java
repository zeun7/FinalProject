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
import multi.com.finalproject.board.model.LikesVO;
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
	@RequestMapping(value = "/json_b_searchList_count.do", method = RequestMethod.GET)
	public int json_b_searchList_count(BoardVO vo, String searchKey, String searchWord) {
		log.info("/json_b_searchList_count.do...{}", vo);
		log.info("searchKey:{}", searchKey);
		log.info("searchWord:{}", searchWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("searchKey", searchKey);
		map.put("searchWord", "%"+searchWord+"%");
		
		int count = service.searchCount(map);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_like.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_like(int num, BoardVO vo) {
		log.info("/json_b_like.do...");
		log.info("num:{}", num);
		log.info("vo:{}", vo);
		
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("num", num);
		param.put("bnum", vo.getBnum());
		
		int result = service.like(param);
		log.info("result:{}", result);
		
		//좋아요 성공하면 카운트업
		if(result == 1) {
			service.likesUp(vo);
		}
		BoardVO vo2 = service.selectOne(vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("likes", vo2.getLikes());	//좋아요 개수 반환
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_like_delete.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_like_delete(int num, BoardVO vo) {
		log.info("/json_b_like_delete.do...");
		log.info("num:{}", num);
		log.info("vo:{}", vo);
		
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("num", num);
		param.put("bnum", vo.getBnum());
		
		int result = service.deleteLike(param);
		log.info("result:{}", result);
		
		//좋아요 삭제 성공하면 카운트다운
		if(result == 1) {
			service.likesDown(vo);
		}
		BoardVO vo2 = service.selectOne(vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("likes", vo2.getLikes());	//좋아요 개수 반환
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_likeCheck.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_likeCheck(int num, BoardVO vo) {
		log.info("/json_b_likeCheck.do...");
		log.info("num:{}", num);
		log.info("vo:{}", vo);
		
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("num", num);
		param.put("bnum", vo.getBnum());
		
		LikesVO vo2 = service.likeCheck(param);
		log.info("vo2:{}", vo2);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		if(vo2 == null) {
			map.put("result", 0);
		}else {
			map.put("result", 1);
		}
		
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