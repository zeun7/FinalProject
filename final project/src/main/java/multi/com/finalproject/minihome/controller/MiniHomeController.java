package multi.com.finalproject.minihome.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minihome.model.MiniHomeVO;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Slf4j
@Controller
public class MiniHomeController {
	
	@Autowired
	MiniHomeService service;
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping(value = "/mini_home.do", method = RequestMethod.GET)
	public String mini_home(Model model, MiniHomeVO vo) {
		log.info("mini_home(vo)...{}", vo);
		
		MiniHomeVO vo2 = service.selectOne(vo);
		
		log.info("vo2 : {}", vo2);
		
		MemberVO vo3 = service.selectProfilePic(vo);
		
		log.info("vo3 : {}", vo3);
		
		model.addAttribute("vo2", vo2);
		model.addAttribute("vo3", vo3);
		
		log.info("vo2.getBackimg()...{}", vo2.getBackimg());
		log.info("vo2.getBgm()...{}", vo2.getBgm());
		log.info("vo3.getProfilepic()...{}", vo3.getProfilepic());
		
		session.setAttribute("backimg", vo2.getBackimg());
		session.setAttribute("bgm", vo2.getBgm());
		session.setAttribute("message", vo2.getMessage());
		session.setAttribute("vtoday", vo2.getVtoday());
		session.setAttribute("vtotal", vo2.getVtotal());
		session.setAttribute("profilepic", vo3.getProfilepic());
		
		// 현재 날짜 가져오기
	    LocalDate today = LocalDate.now();
	    // 세션에서 사용자의 마지막 방문 날짜를 가져오기
	    LocalDate lastVisitDate = (LocalDate) session.getAttribute("lastVisitDate");
	    // 만약 사용자가 오늘 처음 방문하거나, 마지막 방문 날짜가 없으면 (즉, 세션에 아직 방문 날짜가 저장되어 있지 않으면) 조회수를 증가시키고 오늘 날짜를 세션에 저장
	    if (lastVisitDate == null || !today.isEqual(lastVisitDate)) {
	        vo2.setVtoday(vo2.getVtoday() + 1);
	        vo2.setVtotal(vo2.getVtotal() + 1);
	        service.view_update(vo2); // DB에 변경 사항 저장
	        session.setAttribute("lastVisitDate", today);
	    }
	    
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

		} // end if
		
		String getOriginalMusicFilename = vo.getMusicFile().getOriginalFilename();
		int musicFileNameLength = vo.getMusicFile().getOriginalFilename().length();
		log.info("getOriginalMusicFilename:{}", getOriginalMusicFilename);
		log.info("musicFileNameLength:{}", musicFileNameLength);
		
		if (getOriginalMusicFilename.length() != 0) {
			
			vo.setBgm(getOriginalMusicFilename);
			// 웹 어플리케이션이 갖는 실제 경로: bgm을 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadbgm");
			log.info("realPath : {}", realPath);
			
			File f = new File(realPath + "\\" + vo.getBgm());
			vo.getMusicFile().transferTo(f);
		} // end if
		
		log.info("vo : {}", vo);

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