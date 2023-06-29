package multi.com.finalproject.minicomments.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.minicomments.model.MiniCommentsVO;
import multi.com.finalproject.minicomments.service.MiniCommentsService;

@Slf4j
@Controller
public class MiniCommentsRestController {
	
	@Autowired
	MiniCommentsService service;
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_selectAll.do", method = RequestMethod.GET)
	public List<MiniCommentsVO> json_mc_selectAll() {
		log.info("json_mc_selectAll.do...");
		
		List<MiniCommentsVO> list = service.selectAll();
			
		return list;
	}


	@ResponseBody
	@RequestMapping(value = "/json_mc_insertOK.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_insertOK(MiniCommentsVO vo) {
		
		log.info("json_mc_insertOK.do...{}",vo);
			
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/json_mc_reinsertOK.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_reinsertOK(MiniCommentsVO vo) {
		
		log.info("json_mc_reinsertOK.do...{}",vo);
			
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_updateOK.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_updateOK(MiniCommentsVO vo) {
		
		log.info("json_mc_updateOK.do...{}",vo);
			
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/json_mc_deleteOK.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_deleteOK(MiniCommentsVO vo) {
		
		log.info("json_mc_deleteOK.do...{}",vo);
			
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_report.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_report(MiniCommentsVO vo) {
		
		log.info("json_mc_report.do...{}",vo);
			
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mc_like.do", method = RequestMethod.GET)
	public MiniCommentsVO json_mc_like(MiniCommentsVO vo) {
		
		log.info("json_mc_like.do...{}",vo);
			
		return vo;
	}
	
}