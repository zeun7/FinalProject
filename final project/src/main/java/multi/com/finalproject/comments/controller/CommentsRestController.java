package multi.com.finalproject.comments.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.comments.service.CommentsService;

@Slf4j
@Controller
public class CommentsRestController {
	
	@Autowired
	CommentsService service;

	@ResponseBody
	@RequestMapping(value = "/json_c_insertOK.do", method = RequestMethod.GET)
	public CommentsVO json_c_insertOK(CommentsVO vo) {
		
		log.info("json_c_insertOK.do...{}",vo);
			
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/json_c_reinsertOK.do", method = RequestMethod.GET)
	public CommentsVO json_c_reinsertOK(CommentsVO vo) {
		
		log.info("json_c_reinsertOK.do...{}",vo);
			
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_updateOK.do", method = RequestMethod.GET)
	public CommentsVO json_c_updateOK(CommentsVO vo) {
		
		log.info("json_c_updateOK.do...{}",vo);
			
		return vo;
	}

	@ResponseBody
	@RequestMapping(value = "/json_c_deleteOK.do", method = RequestMethod.GET)
	public CommentsVO json_c_deleteOK(CommentsVO vo) {
		
		log.info("json_c_deleteOK.do...{}",vo);
			
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_report.do", method = RequestMethod.GET)
	public CommentsVO json_c_report(CommentsVO vo) {
		
		log.info("json_c_report.do...{}",vo);
			
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_c_like.do", method = RequestMethod.GET)
	public CommentsVO json_c_like(CommentsVO vo) {
		
		log.info("json_c_like.do...{}",vo);
			
		return vo;
	}
	
}