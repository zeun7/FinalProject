package multi.com.finalproject.minicomments.controller;

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
import multi.com.finalproject.minicomments.model.MiniCommentsVO;
import multi.com.finalproject.minicomments.service.MiniCommentsService;

@Slf4j
@Controller
public class MiniCommentsRestController {
	
	@Autowired
	MiniCommentsService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_selectAll.do", method = RequestMethod.GET)
	public List<MiniCommentsVO> json_mc_selectAll(MiniCommentsVO vo) {
		log.info("/json_mc_selectAll.do...");
		
		List<MiniCommentsVO> vos = service.selectAll(vo);

		for (MiniCommentsVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mcc_selectAll.do", method = RequestMethod.GET)
	public List<MiniCommentsVO> json_mcc_selectAll(MiniCommentsVO vo) {
		log.info("/json_mcc_selectAll.do...");
		
		List<MiniCommentsVO> vos = service.mcc_selectAll(vo);
		
		for (MiniCommentsVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_findAll.do", method = RequestMethod.GET)
	public List<MiniCommentsVO> json_mc_findAll(MiniCommentsVO vo) {
		log.info("json_mc_findAll.do(vo)...{}", vo);

		List<MiniCommentsVO> vos = service.findAll(vo);

		return vos;
	}

	@ResponseBody
	@RequestMapping(value = "/json_mc_findAll2.do", method = RequestMethod.GET)
	public List<MiniCommentsVO> json_mc_findAll2(MiniCommentsVO vo, int page) {
		log.info("json_mc_findAll2.do(vo)...{}", vo);
		log.info("page : {}", page);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);

		List<MiniCommentsVO> vos = service.findAll2(map);

		for (MiniCommentsVO x : vos) {
			log.info(x.toString());
		}
		return vos;
	}

	@ResponseBody
	@RequestMapping(value = "/json_mc_findOne.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_findOne(MiniCommentsVO vo) {
		log.info("json_mc_findOne.do...{}", vo);

		MiniCommentsVO vo2 = service.findOne(vo);

		return vo2;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_count.do", method = RequestMethod.GET)
	public int json_mc_count(MiniCommentsVO vo) {
		log.info("json_mc_count(vo)...", vo);
		int count = service.count(vo);
		return count;
	}

	@ResponseBody
	@RequestMapping(value = "/json_mc_insertOK.do", method = RequestMethod.POST)
	public Map<String, Integer> json_mc_insertOK(MiniCommentsVO vo) {
		log.info("/json_mc_insertOK.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.insert(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_updateOK.do", method = RequestMethod.POST)
	public Map<String, Integer> json_mc_updateOK(MiniCommentsVO vo) {
		log.info("/json_mc_updateOK.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.update(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/json_mc_deleteOK.do", method = RequestMethod.POST)
	public Map<String, Integer> json_mc_deleteOK(MiniCommentsVO vo) {
		log.info("/json_mc_deleteOK.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.delete(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
	
	@RequestMapping(value = "/mc_report.do", method = RequestMethod.GET)
	public String json_mc_report(MiniCommentsVO vo) {
		log.info("/mc_report.do...{}",vo);
			
		return "mini/diary/report_comments";
	}
	
	@RequestMapping(value = "/mc_reportOK.do", method = RequestMethod.POST)
	public String mc_reportOK(MiniCommentsVO vo, String reason, String id) {
		log.info("/mc_reportOK.do...{}",vo);
		log.info("reason: {}", reason);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("reason", reason);
		map.put("id", id);
		
		int result = service.report(map);
		log.info("result: {}", result);
		
		if(result == 1) {
			return "redirect:mc_report.do?mcnum=0";
		}
		else {
			return "Redirect:mc_report.do?mcnum="+vo.getMcnum();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_is_clike.do", method = RequestMethod.POST)
	public Integer json_mc_is_clike(ClikesVO vo) {
		log.info("/json_mc_is_clike.do...{}",vo);
		
		int result = 0;
		ClikesVO vo2 = service.is_clike(vo);
		
		if(vo2 != null) {
			result = 1;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_count_clikes.do", method = RequestMethod.POST)
	public Integer json_mc_count_clikes(ClikesVO vo) {
		log.info("/json_mc_count_clikes.do...{}",vo);
		
		int count = service.count_clikes(vo);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_clike.do", method = RequestMethod.POST)
	public Map<String, Integer> json_mc_clike(ClikesVO vo) {
		log.info("/json_mc_clike.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.clike(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_cancel_clike.do", method = RequestMethod.POST)
	public Map<String, Integer> json_mc_cancel_clike(ClikesVO vo) {
		log.info("/json_mc_cancel_clike.do...{}",vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		int result = service.cancel_clike(vo);
		map.put("result", result);
		log.info("{}", map);
		
		return map;
	}
}