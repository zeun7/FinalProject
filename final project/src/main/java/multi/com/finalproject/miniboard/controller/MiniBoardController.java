package multi.com.finalproject.miniboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.miniboard.service.MiniBoardService;

@Slf4j
@Controller
public class MiniBoardController {

	@Autowired
	MiniBoardService service;

	@RequestMapping(value = "/mini_diary.do", method = RequestMethod.GET)
	public String mini_diary(Model model, Model models, MiniBoardVO vo) {
		log.info("mini_diary(vo)...");

		MiniBoardVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);
		
		List<MiniBoardVO> vos = service.selectAll();

		models.addAttribute("vos", vos);

		return "mini/diary/selectAll";
	}

	@RequestMapping(value = "/diary_selectOne.do", method = RequestMethod.GET)
	public String diary_selectOne(Model model, MiniBoardVO vo) {
		log.info("diary_selectOne(vo)...{}", vo);

		MiniBoardVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "mini/diary/selectOne";
	}

	@RequestMapping(value = "/diary_insert.do", method = RequestMethod.GET)
	public String diary_insert(Model model, MiniBoardVO vo) {
		log.info("diary_insert()...");

		MiniBoardVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "mini/diary/insert";
	}

	@RequestMapping(value = "/diary_insertOK.do", method = RequestMethod.POST)
	public String diary_insertOK(MiniBoardVO vo) {
		log.info("diary_insertOK(vo)...{}", vo);

		int result = service.insert(vo);
		log.info("result...{}", result);

		if (result == 1) {
			return "redirect:mini_diary.do";
		} else {
			return "redirect:diary_insert.do";
		}

	}

	@RequestMapping(value = "/diary_deleteOK.do", method = RequestMethod.GET)
	public String diary_deleteOK(MiniBoardVO vo) {
		log.info("diary_deleteOK(vo)...{}", vo);

		return "redirect:mini_diary.do";
	}

	@RequestMapping(value = "/diary_update.do", method = RequestMethod.GET)
	public String diary_update(Model model, MiniBoardVO vo) {
		log.info("diary_update()...");

		return "mini/diary/update";
	}

	@RequestMapping(value = "/mini_gallery.do", method = RequestMethod.GET)
	public String mini_gallery() {
		log.info("mini_gallery()...");

		return "mini/gallery/selectAll";
	}

	@RequestMapping(value = "/gallery_selectOne.do", method = RequestMethod.GET)
	public String gallery_selectOne(MiniBoardVO vo) {
		log.info("gallery_selectOne()...");

		return "mini/gallery/selectOne";
	}

}
