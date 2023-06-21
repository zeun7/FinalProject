package multi.com.finalproject.comments.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.comments.service.CommentsService;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class CommentsController {
	
	@Autowired
	CommentsService service;

	
	@RequestMapping(value = "/c_selectAll.do", method = RequestMethod.GET)
	public String c_selectAll() {
		log.info("/c_selectAll.do");
		
		List<CommentsVO> list = service.selectAll();
		
		return "comments/selectAll";
	}
	
}