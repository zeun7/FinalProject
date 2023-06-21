package multi.com.finalproject.member.controller;

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
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MemberService;


@Controller
@Slf4j
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public String insert(MemberVO vo) {
		log.info("insert()....",vo);
			
		return "member/insert";
	}
	@RequestMapping(value = "/insertOK.do", method = RequestMethod.GET)
	public String insertOK(MemberVO vo) throws IllegalStateException, IOException {
		log.info("insertOK()....",vo);
		String getOriginalFilename = vo.getFile().getOriginalFilename();
		int fileNameLength = vo.getFile().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() == 0) {
			vo.setProfilepic(getOriginalFilename);
		} else {
			vo.setProfilepic(getOriginalFilename);
			// �쎒 �뼱�뵆由ъ��씠�뀡�씠 媛뽯뒗 �떎�젣 寃쎈줈: �씠誘몄�瑜� �뾽濡쒕뱶�븷 ���긽 寃쎈줈瑜� 李얠븘�꽌 �뙆�씪���옣.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getProfilepic());
			vo.getFile().transferTo(f);

			//// create thumbnail image/////////
			BufferedImage original_buffer_img = ImageIO.read(f);
			BufferedImage thumb_buffer_img = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumb_buffer_img.createGraphics();
			graphic.drawImage(original_buffer_img, 0, 0, 50, 50, null);

			File thumb_file = new File(realPath + "/thumb_" + vo.getProfilepic());
			String formatName = vo.getProfilepic().substring(vo.getProfilepic().lastIndexOf(".") + 1);
			log.info("formatName : {}", formatName);
			ImageIO.write(thumb_buffer_img, formatName, thumb_file);

		} // end else
		log.info("{}", vo);

		int result = service.insert(vo);

		if (result == 1) {
			return "redirect:m_selectAll.do";
		} else {
			return "redirect:m_insert.do";
		}
	}
	@RequestMapping(value = "/selectAll.do", method = RequestMethod.GET)
	public String selectAll(Model model) {
		log.info("selectAll()....{}");
		
		List<MemberVO> vos = service.selectAll();
		
		model.addAttribute("vos", vos);
		
		return "member/selectAll";
	}
	
	
	@RequestMapping(value = "/selectOne.do", method = RequestMethod.GET)
	public String selectOne(MemberVO vo, Model model) {
		log.info("selectAll()....{}");
		
		MemberVO vo2 = service.selectOne(vo);
		
		model.addAttribute("vo2", vo2);
		
		return "member/selectOne";
	}
	
}
