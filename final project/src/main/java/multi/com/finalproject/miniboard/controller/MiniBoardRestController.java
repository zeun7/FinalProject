package multi.com.finalproject.miniboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class MiniBoardRestController {
	
	@Autowired
	MiniBoardService service;
	
	@ResponseBody
	@RequestMapping(value = "/mongo_visit_findAll.do", method = RequestMethod.GET)
	public List<MiniBoardVO> mongo_visit_findAll() {
		log.info("/mongo_visit_findAll.do");
	
		List<MiniBoardVO> list = service.mongo_findAll();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = "/mongo_visit_insertOK.do", method = RequestMethod.GET)
	public Map<String, Integer> mongo_visit_insertOK(MiniBoardVO vo) {
		log.info("mongo_visit_insertOK()...");

		Map<String, Integer> map = new HashMap<String, Integer>();

		int result = service.mongo_insert(vo);

		map.put("result", result);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mongo_visit_updateOK.do", method = RequestMethod.GET)
	public Map<String, Integer> mongo_visit_updateOK(MiniBoardVO vo) {
		log.info("mongo_visit_updateOK()...");
		
		Map<String, Integer> map = new HashMap<String, Integer>();

		int result = service.mongo_update(vo);

		map.put("result", result);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mongo_visit_deleteOK.do", method = RequestMethod.GET)
	public Map<String, Integer> mongo_visit_deleteOK(MiniBoardVO vo) {
		log.info("mongo_visit_deleteOK()...");
		
		Map<String, Integer> map = new HashMap<String, Integer>();

		int result = service.mongo_delete(vo);

		map.put("result", result);
		
		return map;
	}

}