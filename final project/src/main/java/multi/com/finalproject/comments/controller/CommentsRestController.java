package multi.com.finalproject.comments.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.model.ClikesVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.comments.service.CommentsService;

@Slf4j
@Controller
public class CommentsRestController {
	
	@Autowired
	CommentsService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_c_selectAll.do", method = RequestMethod.GET)
	public List<CommentsVO> json_c_selectAll(CommentsVO vo) {
		log.info("/json_c_selectAll.do...");
		
		List<CommentsVO> vos = service.selectAll(vo);

		for (CommentsVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_cc_selectAll.do", method = RequestMethod.GET)
	public List<CommentsVO> json_cc_selectAll(CommentsVO vo) {
		log.info("/json_cc_selectAll.do...");
		
		List<CommentsVO> vos = service.cc_selectAll(vo);
		
		for (CommentsVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}

	@ResponseBody
	@RequestMapping(value = "/json_c_insertOK.do", method = RequestMethod.POST)
	public Map<String, Integer> json_c_insertOK(CommentsVO vo) {
		log.info("/json_c_insertOK.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.insert(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_updateOK.do", method = RequestMethod.POST)
	public Map<String, Integer> json_c_updateOK(CommentsVO vo) {
		log.info("/json_c_updateOK.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.update(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/json_c_deleteOK.do", method = RequestMethod.POST)
	public Map<String, Integer> json_c_deleteOK(CommentsVO vo) {
		log.info("/json_c_deleteOK.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.delete(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
	
	@RequestMapping(value = "/c_report.do", method = RequestMethod.GET)
	public String json_c_report(CommentsVO vo) {
		log.info("/c_report.do...{}",vo);
			
		return "board/report_comments";
	}
	
	@RequestMapping(value = "/c_reportOK.do", method = RequestMethod.POST)
	public String c_reportOK(CommentsVO vo, String reason) {
		log.info("/c_reportOK.do...{}",vo);
		log.info("reason: {}", reason);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("reason", reason);
		
		int result = service.report(map);
		log.info("result: {}", result);
		
		if(result == 1) {
			return "redirect:c_report.do?cnum=0";
		}
		else {
			return "Redirect:c_report.do?cnum="+vo.getCnum();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_is_clike.do", method = RequestMethod.POST)
	public Integer json_c_is_clike(ClikesVO vo) {
		log.info("/json_c_is_clike.do...{}",vo);
		
		int result = 0;
		ClikesVO vo2 = service.is_clike(vo);
		
		if(vo2 != null) {
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_count_clikes.do", method = RequestMethod.POST)
	public Integer json_c_count_clikes(ClikesVO vo) {
		log.info("/json_c_count_clikes.do...{}",vo);
		
		int count = service.count_clikes(vo);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_clike.do", method = RequestMethod.POST)
	public Map<String, Integer> json_c_clike(ClikesVO vo) {
		log.info("/json_c_clike.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.clike(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_cancel_clike.do", method = RequestMethod.POST)
	public Map<String, Integer> json_c_cancel_clike(ClikesVO vo) {
		log.info("/json_c_cancel_clike.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.cancel_clike(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
}