package multi.com.finalproject.miniboard.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

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

	@Autowired
	ServletContext sContext;
	
	@Autowired
	HttpSession session;

	@RequestMapping(value = "/mini_diary.do", method = RequestMethod.GET)
	public String mini_diary(Model model) {
		log.info("mini_diary()...{}");

		List<MiniBoardVO> vos = service.selectAll();

		model.addAttribute("vos", vos);

		return "mini/diary/selectAll";
	}

	@RequestMapping(value = "/mini_gallery.do", method = RequestMethod.GET)
	public String mini_gallery(Model model) {
		log.info("mini_gallery()...{}");

		List<MiniBoardVO> vos = service.selectAll();

		model.addAttribute("vos", vos);

		return "mini/gallery/selectAll";
	}

	@RequestMapping(value = "/diary_selectOne.do", method = RequestMethod.GET)
	public String diary_selectOne(Model model, MiniBoardVO vo) {
		log.info("diary_selectOne(vo)...{}", vo);

		MiniBoardVO vo2 = service.diary_selectOne(vo);

		model.addAttribute("vo2", vo2);
		log.info("vo2 : {}",vo2);
		session.setAttribute("mbnum", vo2.getMbnum());
		
		return "mini/diary/selectOne";
	}

	@RequestMapping(value = "/diary_insert.do", method = RequestMethod.GET)
	public String diary_insert(Model model, MiniBoardVO vo) {
		log.info("diary_insert()...");

		return "mini/diary/insert";
	}

	@RequestMapping(value = "/mb_insertOK.do", method = RequestMethod.POST)
	public String mb_insertOK(MiniBoardVO vo) throws IllegalStateException, IOException {
		log.info("mb_insertOK(vo)...{}", vo);

		if (vo.getBfile() != null && !vo.getBfile().isEmpty()) {
			String originalFilename = vo.getBfile().getOriginalFilename();
			int fileNameLength = originalFilename.length();
			log.info("originalFilename: {}", originalFilename);
			log.info("fileNameLength: {}", fileNameLength);

			vo.setFilepath(originalFilename);

			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath: {}", realPath);

			File f = new File(realPath + File.separator + vo.getFilepath());
			vo.getBfile().transferTo(f);

			// 썸네일 이미지 생성
			BufferedImage originalBufferImg = ImageIO.read(f);
			BufferedImage thumbBufferImg = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumbBufferImg.createGraphics();
			graphic.drawImage(originalBufferImg, 0, 0, 50, 50, null);

			File thumbFile = new File(realPath + File.separator + "thumb_" + vo.getFilepath());
			String formatName = vo.getFilepath().substring(vo.getFilepath().lastIndexOf(".") + 1);
			log.info("formatName: {}", formatName);
			ImageIO.write(thumbBufferImg, formatName, thumbFile);
		}
		
		log.info("vo : {}", vo);
		
		int result = service.insert(vo);
		log.info("result: {}", result);

		if (result == 1) {
			return "redirect:mini_diary.do?writer=" + vo.getWriter();
		} else {
			return "redirect:insert.do?writer=" + vo.getWriter();
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

	@RequestMapping(value = "/gallery_selectOne.do", method = RequestMethod.GET)
	public String gallery_selectOne(Model model, MiniBoardVO vo) {
		log.info("gallery_selectOne()...");

		MiniBoardVO vo2 = service.gallery_selectOne(vo);

		model.addAttribute("vo2", vo2);
		return "mini/gallery/selectOne";
	}

	@RequestMapping(value = "/gallery_updateOK.do", method = RequestMethod.POST)
	public String gallery_updateOK(MiniBoardVO vo) {
		log.info("gallery_updateOK(vo)...{}", vo);

		int result = service.gallery_update(vo);
		log.info("result...{}", result);

		return "redirect:mini_gallery.do";
	}

	@RequestMapping(value = "/gallery_deleteOK.do", method = RequestMethod.GET)
	public String gallery_deleteOK(MiniBoardVO vo) {
		log.info("gallery_deleteOK(vo)...{}", vo);

		int result = service.gallery_delete(vo);
		log.info("result...{}", result);

		return "redirect:mini_gallery.do";
	}

}