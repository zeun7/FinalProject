package multi.com.finalproject.minihome.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.minihome.model.MiniHomeVO;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Slf4j
@Controller
public class MiniHomeController {
	
	@Autowired
	MiniHomeService service;
	
	@Autowired
	ServletContext sContext;
	
	@RequestMapping(value = "/mini_home.do", method = RequestMethod.GET)
	public String mini_home(Model model, MiniHomeVO vo) {
		log.info("mini_home(vo)...{}", vo);
		
		MiniHomeVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);
		
		return "mini/minihome";
	}
	
	@RequestMapping(value = "/mini_update.do", method = RequestMethod.GET)
	public String mini_update(Model model, MiniHomeVO vo) {
		log.info("mini_update(vo)...{}", vo);
		
		MiniHomeVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);
		
		log.info("{}", vo2);
		
		return "mini/update";
	}
	
	@RequestMapping(value = "/mini_updateOK.do", method = RequestMethod.POST)
	public String mini_updateOK(MiniHomeVO vo) throws IllegalStateException, IOException {
		log.info("=============================");
		log.info("mini_updateOK(vo)...{}", vo);
		
		String getOriginalFilename = vo.getFile().getOriginalFilename();
		int fileNameLength = vo.getFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() != 0) {

			vo.setBackimg(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getBackimg());
			vo.getFile().transferTo(f);

			//// create thumbnail image/////////
			BufferedImage original_buffer_img = ImageIO.read(f);
			BufferedImage thumb_buffer_img = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumb_buffer_img.createGraphics();
			graphic.drawImage(original_buffer_img, 0, 0, 50, 50, null);

			File thumb_file = new File(realPath + "/thumb_" + vo.getBackimg());
			String formatName = vo.getBackimg().substring(vo.getBackimg().lastIndexOf(".") + 1);
			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);

		} // end else
		log.info("{}", vo);

		int result = service.update(vo);
		
		log.info("result : {}", result);

		if (result == 1) {
			return "redirect:mini_home.do?id=" + vo.getId();
		} else {
			return "redirect:mini_update.do?id=" + vo.getId();
		}
	}
	
	@RequestMapping(value = "/mini_random.do", method = RequestMethod.GET)
	public String mini_random() {
		log.info("mini_random()...");
		
		return "mini/minihome";
	}
	
	@RequestMapping(value = "/mini_visit.do", method = RequestMethod.GET)
	public String mini_visit() {
		log.info("mini_visit()...");
		
		return "mini/visit/visit";
	}
	
	@RequestMapping(value = "/mini_game.do", method = RequestMethod.GET)
	public String mini_game() {
		log.info("mini_game()...");
		
		return "mini/game/game";
	}
	
}