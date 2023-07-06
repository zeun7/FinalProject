package multi.com.finalproject.miniboard.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MemberService;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.miniboard.service.MiniBoardService;
import multi.com.finalproject.minihome.model.MiniHomeVO;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Slf4j
@Controller
public class MiniBoardController {

	@Autowired
	MiniBoardService service;

	@Autowired
	ServletContext sContext;
	
	@Autowired
	MiniHomeService minihome_service;

	@Autowired
	MemberService member_service;
	
	@ModelAttribute("mh_attr")
	public MiniHomeVO getMh_attr(MiniHomeVO vo, MemberVO mvo) {
		log.info("getMh_attr(MiniHomeVO vo)...vo : {}, mvo : {}", vo, mvo);
		MiniHomeVO mh_attr = new MiniHomeVO();
		if(vo.getId() != null) {
			mh_attr = minihome_service.selectOne(vo);
		}else if(mvo.getNickname() != null){
			MemberVO mvo2 = member_service.selectOne(mvo);
			MiniHomeVO vo2 = new MiniHomeVO();
			vo2.setId(mvo2.getId());
			mh_attr = minihome_service.selectOne(vo2); 
		}
		log.info("mh_attr : {}", mh_attr);
		return mh_attr;
	}

	@ModelAttribute("m_attr")
	public MemberVO getM_attr(MemberVO vo) {
		log.info("getM_attr(MemberVO vo)...{}", vo);
		MemberVO m_attr = minihome_service.selectNickPic(vo);
		if(m_attr.getNickname() == null) {
			m_attr.setNickname(vo.getNickname());
		}else {
			m_attr.setId(vo.getId());
		}
		log.info("m_attr : {}", m_attr);
		return m_attr;
	}
	
	@RequestMapping(value = "/mini_diary.do", method = RequestMethod.GET)
	public String mini_diary() {
		log.info("mini_diary()...");
		
		return "mini/diary/selectAll";
	}

	@RequestMapping(value = "/mini_gallery.do", method = RequestMethod.GET)
	public String mini_gallery() {
		log.info("mini_gallery()...");

		return "mini/gallery/selectAll";
	}

	@RequestMapping(value = "/diary_selectOne.do", method = RequestMethod.GET)
	public String diary_selectOne(Model model, MiniBoardVO vo) {
		log.info("diary_selectOne(vo)...{}", vo);

		MiniBoardVO vo2 = service.mb_selectOne(vo);

		model.addAttribute("vo2", vo2);
		log.info("vo2 : {}",vo2);
		
		return "mini/diary/selectOne";
	}

	@RequestMapping(value = "/diary_insert.do", method = RequestMethod.GET)
	public String diary_insert() {
		log.info("diary_insert()...");

		return "mini/diary/insert";
	}

	@RequestMapping(value = "/mb_insertOK.do", method = RequestMethod.POST)
	public String mb_insertOK(@RequestParam("id") String id, MiniBoardVO vo) throws IllegalStateException, IOException {
		log.info("mb_insertOK(vo)...{}", vo);

		if (vo.getFile() != null && !vo.getFile().isEmpty()) {
			String originalFilename = vo.getFile().getOriginalFilename();
			int fileNameLength = originalFilename.length();
			log.info("originalFilename: {}", originalFilename);
			log.info("fileNameLength: {}", fileNameLength);

			vo.setFilepath(originalFilename);

			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath: {}", realPath);

			File f = new File(realPath + File.separator + vo.getFilepath());
			vo.getFile().transferTo(f);

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
		
		int result = service.mb_insert(vo);
		log.info("result: {}", result);

		if (result == 1) {
			return "redirect:mini_diary.do?id=" + id;
		} else {
			return "redirect:insert.do?id=" + id;
		}

	}

	@RequestMapping(value = "/diary_update.do", method = RequestMethod.GET)
	public String diary_update(Model model, MiniBoardVO vo) {
		log.info("diary_update(vo)...{}", vo);

		MiniBoardVO vo2 = service.mb_selectOne(vo);
		model.addAttribute("vo2", vo2);
		
		return "mini/diary/update";
	}
	
	@RequestMapping(value = "/diary_updateOK.do", method = RequestMethod.POST)
	public String diary_updateOK(@RequestParam("id") String id, MiniBoardVO vo) throws IllegalStateException, IOException {
		log.info("diary_updateOK(vo)...{}", vo);

		if (vo.getFile() != null && !vo.getFile().isEmpty()) {
			String originalFilename = vo.getFile().getOriginalFilename();
			int fileNameLength = originalFilename.length();
			log.info("originalFilename: {}", originalFilename);
			log.info("fileNameLength: {}", fileNameLength);

			vo.setFilepath(originalFilename);

			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath: {}", realPath);

			File f = new File(realPath + File.separator + vo.getFilepath());
			vo.getFile().transferTo(f);

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
		
		int result = service.diary_update(vo);
		log.info("result: {}", result);

		if (result == 1) {
			return "redirect:mini_diary.do?id=" + id + "&mbnum=" + vo.getMbnum();
		} else {
			return "redirect:insert.do?id=" + id+ "&mbnum=" + vo.getMbnum();
		}

	}
	
	@RequestMapping(value = "/diary_deleteOK.do", method = RequestMethod.GET)
	public String diary_deleteOK(@RequestParam("id") String id, @RequestParam("mbnum") String mbnum, MiniBoardVO vo) {
		log.info("diary_deleteOK(vo)...{}", vo);

		int result = service.mb_delete(vo);
		log.info("result...{}", result);
		
		if (result == 1) {
			return "redirect:mini_diary.do?id=" + id;
		}else {
			return "redirect:diary_selectOne.do?id=" + id + "&mbnum=" + mbnum;
		}
	}
	
	@RequestMapping(value = "/gallery_selectOne.do", method = RequestMethod.GET)
	public String gallery_selectOne(Model model, MiniBoardVO vo) {
		log.info("gallery_selectOne()...");

		MiniBoardVO vo2 = service.mb_selectOne(vo);
		
		model.addAttribute("vo2", vo2);
		return "mini/gallery/selectOne";
	}


	@RequestMapping(value = "/gallery_deleteOK.do", method = RequestMethod.GET)
	public String gallery_deleteOK(@RequestParam("id") String id, @RequestParam("mbnum") String mbnum, MiniBoardVO vo) {
		log.info("gallery_deleteOK(vo)...{}", vo);

		int result = service.mb_delete(vo);
		log.info("result...{}", result);
		
		if (result == 1) {
			return "redirect:mini_gallery.do?id=" + id;
		}else {
			return "redirect:gallery_selectOne.do?id=" + id + "&mbnum=" + mbnum;
		}
	}
	
}