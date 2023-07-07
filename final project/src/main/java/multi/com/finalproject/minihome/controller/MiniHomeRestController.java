package multi.com.finalproject.minihome.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.miniboard.service.MiniBoardService;

@Slf4j
@Controller
public class MiniHomeRestController {
	
	@Autowired
	MiniBoardService service;
	
	@ResponseBody
	@RequestMapping(value = "/newest_diary.do", method = RequestMethod.GET)
	public MiniBoardVO newest_diary(MiniBoardVO vo) {
		log.info("newest_diary(vo)...{}", vo);
		
		MiniBoardVO vo2 = service.newest_diary(vo); 
		log.info("vo2 : {}", vo2);
		return vo2;
	}
	
	@ResponseBody
	@RequestMapping(value = "/newest_gallery.do", method = RequestMethod.GET)
	public MiniBoardVO newest_gallery(MiniBoardVO vo) {
		log.info("newest_gallery(vo)...{}", vo);
		
		MiniBoardVO vo2 = service.newest_gallery(vo);
		log.info("vo2 : {}", vo2);
		return vo2;
	}
}