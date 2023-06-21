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

		MiniBoardVO vo2 = service.diary_selectOne(vo);

		model.addAttribute("vo2", vo2);
		
		List<MiniBoardVO> vos = service.diary_selectAll();

		models.addAttribute("vos", vos);

		return "mini/diary/selectAll";
	}

	@RequestMapping(value = "/diary_selectOne.do", method = RequestMethod.GET)
	public String diary_selectOne(Model model, MiniBoardVO vo) {
		log.info("diary_selectOne(vo)...{}", vo);

		MiniBoardVO vo2 = service.diary_selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "mini/diary/selectOne";
	}

	@RequestMapping(value = "/diary_insert.do", method = RequestMethod.GET)
	public String diary_insert(Model model, MiniBoardVO vo) {
		log.info("diary_insert()...");

		MiniBoardVO vo2 = service.diary_selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "mini/diary/insert";
	}

	@RequestMapping(value = "/diary_insertOK.do", method = RequestMethod.POST)
	public String diary_insertOK(MiniBoardVO vo) {
		log.info("diary_insertOK(vo)...{}", vo);

		int result = service.diary_insert(vo);
		log.info("result...{}", result);

		if (result == 1) {
			return "redirect:mini_diary.do";
		} else {
			return "redirect:diary_insert.do";
		}

	}

	@RequestMapping(value = "/diary_update.do", method = RequestMethod.GET)
	public String diary_update(Model model, MiniBoardVO vo) {
		log.info("diary_update()...");

		return "mini/diary/update";
	}
	
	@RequestMapping(value = "/diary_updateOK.do", method = RequestMethod.GET)
	public String diary_updateOK(Model model, MiniBoardVO vo) {
		log.info("diary_updateOK()...");
		
		int result = service.diary_update(vo);
		log.info("result...{}", result);

		if (result == 1) {
			return "redirect:mini_diary.do";
		} else {
			return "redirect:diary_update.do";
		}
	}
	
	@RequestMapping(value = "/diary_deleteOK.do", method = RequestMethod.GET)
	public String diary_deleteOK(MiniBoardVO vo) {
		log.info("diary_deleteOK(vo)...{}", vo);

		int result = service.diary_delete(vo);
		log.info("result...{}", result);

		if (result == 1) {
			return "redirect:mini_diary.do";
		} else {
			return "redirect:diary_update.do";
		}
	}
	
	@RequestMapping(value = "/mini_visit.do", method = RequestMethod.GET)
	public String mini_visit() {
		log.info("mini_visit()...");
		
		return "mini/visit/visit";
	}

	@RequestMapping(value = "/mini_gallery.do", method = RequestMethod.GET)
	public String mini_gallery(Model model, Model models, MiniBoardVO vo) {
		log.info("mini_gallery()...");

		MiniBoardVO vo2 = service.gallery_selectOne(vo);

		model.addAttribute("vo2", vo2);
		
		List<MiniBoardVO> vos = service.gallery_selectAll();

		models.addAttribute("vos", vos);
		
		return "mini/gallery/selectAll";
	}

	@RequestMapping(value = "/gallery_selectOne.do", method = RequestMethod.GET)
	public String gallery_selectOne(Model model, MiniBoardVO vo) {
		log.info("gallery_selectOne()...");
		
		MiniBoardVO vo2 = service.gallery_selectOne(vo);

		model.addAttribute("vo2", vo2);
		
		return "mini/gallery/selectOne";
	}
	
	@RequestMapping(value = "/gallery_insertOK.do", method = RequestMethod.POST)
	public String gallery_insertOK(MiniBoardVO vo) {
		log.info("gallery_insertOK(vo)...{}", vo);

		int result = service.gallery_insert(vo);
		log.info("result...{}", result);

		return "redirect:mini_gallery.do";
	}
	
	@RequestMapping(value = "/gallery_updateOK.do", method = RequestMethod.POST)
	public String gallery_updateOK(MiniBoardVO vo) {
		log.info("gallery_updateOK(vo)...{}", vo);
		
		int result = service.gallery_update(vo);
		log.info("result...{}", result);
		
		return "redirect:mini_gallery.do";
	}

	@RequestMapping(value = "/diary_deleteOK.do", method = RequestMethod.GET)
	public String gallery_deleteOK(MiniBoardVO vo) {
		log.info("gallery_deleteOK(vo)...{}", vo);
		
		int result = service.gallery_delete(vo);
		log.info("result...{}", result);
		
		return "redirect:mini_gallery.do";
	}
	
}
