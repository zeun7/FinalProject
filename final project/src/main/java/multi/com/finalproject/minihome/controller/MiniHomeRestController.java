package multi.com.finalproject.minihome.controller;

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
import multi.com.finalproject.minihome.model.JukeboxVO;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Slf4j
@Controller
public class MiniHomeRestController {
	
	@Autowired
	MiniHomeService service;
	
	@Autowired
	MiniBoardService miniboard_service;
	
	@ResponseBody
	@RequestMapping(value = "/newest_diary.do", method = RequestMethod.GET)
	public MiniBoardVO newest_diary(MiniBoardVO vo) {
		log.info("newest_diary(vo)...{}", vo);
		
		MiniBoardVO vo2 = miniboard_service.newest_diary(vo); 
		log.info("vo2 : {}", vo2);
		return vo2 != null ? vo2 : new MiniBoardVO();
	}
	
	@ResponseBody
	@RequestMapping(value = "/newest_gallery.do", method = RequestMethod.GET)
	public MiniBoardVO newest_gallery(MiniBoardVO vo) {
		log.info("newest_gallery(vo)...{}", vo);
		
		MiniBoardVO vo2 = miniboard_service.newest_gallery(vo);
		log.info("vo2 : {}", vo2);
		return vo2 != null ? vo2 : new MiniBoardVO();
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_j_count.do", method = RequestMethod.GET)
	public int json_j_count(JukeboxVO vo) {
		log.info("json_j_count(vo)...{}", vo);
		int count = service.count(vo);
		log.info("count : {}", count);
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_j_selectAll.do", method = RequestMethod.GET)
	public List<JukeboxVO> json_j_selectAll(JukeboxVO vo, int page) {
		log.info("json_j_selectAll(vo)...{}", vo);
		log.info("page : {}", page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		
		List<JukeboxVO> vos = service.j_selectAll(map);
		for (JukeboxVO x : vos) {
			log.info(x.toString());
		}
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/bgm_selectOne.do", method = RequestMethod.GET)
	public JukeboxVO bgm_selectOne(JukeboxVO vo) {
		log.info("bgm_selectOne(vo)...{}", vo);
		JukeboxVO vo2 = service.bgm_selectOne(vo);
		return vo2;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}