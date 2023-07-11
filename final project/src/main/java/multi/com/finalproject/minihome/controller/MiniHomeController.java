package multi.com.finalproject.minihome.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.manage.model.FriendsVO;
import multi.com.finalproject.manage.service.ManageService;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MemberService;
import multi.com.finalproject.minicomments.model.MiniCommentsVO;
import multi.com.finalproject.minicomments.service.MiniCommentsService;
import multi.com.finalproject.minihome.model.MiniHomeVO;
import multi.com.finalproject.minihome.model.VisitHistoryVO;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Slf4j
@Controller
public class MiniHomeController {

	@Autowired
	MiniHomeService service;
	
	@Autowired
	MemberService member_service;

	@Autowired
	ManageService manage_service;
	
	@Autowired
	MiniCommentsService minicomments_service;
	
	@Autowired
	ServletContext sContext;

	@Autowired
	HttpSession session;

	@ModelAttribute("mh_attr")
	public MiniHomeVO getMh_attr(MiniHomeVO vo, MemberVO mvo) {
		log.info("getMh_attr(MiniHomeVO vo)...vo : {}, mvo : {}", vo, mvo);
		MiniHomeVO mh_attr = new MiniHomeVO();
		if(vo.getId() != null) {
			mh_attr = service.selectOne(vo);
		}else if(mvo.getNickname() != null){
			MemberVO mvo2 = member_service.selectOne(mvo);
			MiniHomeVO vo2 = new MiniHomeVO();
			vo2.setId(mvo2.getId());
			mh_attr = service.selectOne(vo2); 
		}
		log.info("mh_attr : {}", mh_attr);
		return mh_attr;
	}
	
	@ModelAttribute("m_attr")
	public MemberVO getM_attr(MemberVO vo) {
		log.info("getM_attr(MemberVO vo)...{}", vo);
		MemberVO m_attr = service.selectNickPic(vo);
		if(m_attr.getNickname() == null) {
			m_attr.setNickname(vo.getNickname());
		}else {
			m_attr.setId(vo.getId());
		}
		log.info("m_attr : {}", m_attr);
		return m_attr;
	}
	
	@RequestMapping(value = "/mini_home.do", method = RequestMethod.GET)
	public String mini_home(Model model, MiniHomeVO vo) {
		log.info("mini_home(vo)...{}", vo);
		
		//세션에 저장된 로그인한 사용자 id 가져옴
		String user_id = (String) session.getAttribute("user_id");
		String nickname = (String) session.getAttribute("nickname");
		
		//1촌목록 부분
		MemberVO nick_vo = new MemberVO();
		nick_vo.setNickname(nickname);
		MemberVO user_vo = member_service.selectOne(nick_vo);
		log.info("{}", user_vo);
		
		List<FriendsVO> vos = manage_service.ilchon_selectAll(user_vo);
		model.addAttribute("vos", vos);
		
    	//오늘 날짜 생성
    	Date today_date = new Date(System.currentTimeMillis());
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	
    	// 오늘 방문 기록 확인
    	VisitHistoryVO v_vo = new VisitHistoryVO();
    	v_vo.setVisit_date(sdf.format(today_date)); 
    	v_vo.setUser_id(user_id);
    	v_vo.setMinihome_id(vo.getId());
    	//nickname 파리미터로로 홈피 방문시
    	MemberVO m_attr = (MemberVO) model.asMap().get("m_attr");
    	if(vo.getId()==null) {
    		vo.setId(m_attr.getId());
    		v_vo.setMinihome_id(vo.getId());
    	}
    	
    	log.info("v_vo : {}", v_vo);
    	
    	int hasVisitedToday = service.hasVisitedToday(v_vo); // DB에서 오늘 방문 기록 조회하는 메서드 필요
    	log.info("hasVisitedToday : {}", hasVisitedToday);
	    if (hasVisitedToday == 0) {
	        // 오늘 처음 방문한 경우
	        service.vcountUp(vo); // 미니홈피의 vtoday,vtotal +1씩
	        // 방문 기록 추가
	        service.addVisitHistory(v_vo);
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
	public String mini_random(@RequestParam("id") String param_id) {
		log.info("mini_random()...");
		String randomId;
		
		do {
		MiniHomeVO randomMiniHome = service.getRandomMiniHome();
		randomId = randomMiniHome.getId();
		} while(randomId.equals(session.getAttribute("user_id")) || randomId.equals(param_id)); // 자신의 미니홈피나, 지금 방문한 미니홈피 제외
			
		return "redirect:mini_home.do?id=" + randomId;
	}

	@RequestMapping(value = "/mini_visit.do", method = RequestMethod.GET)
	public String mini_visit() {
		log.info("mini_visit()...");

		return "mini/visit/findAll";
	}

	@RequestMapping(value = "/visit_findOne.do", method = RequestMethod.GET)
	public String visit_findOne() {
		log.info("visit_findOne()...");
		
		return "mini/visit/findOne";
	}
	
	@RequestMapping(value = "/visit_insert.do", method = RequestMethod.GET)
	public String visit_insert() {
		log.info("visit_insert()...");

		return "mini/visit/insert";
	}
	
	@RequestMapping(value = "/visit_insertOK.do", method = RequestMethod.POST)
	public String visit_insertOK(MiniCommentsVO vo) {
		log.info("visit_insertOK(vo)...{}", vo);
		
		log.info("vo : {}", vo);
		
		int result = minicomments_service.insert(vo);
		log.info("result: {}", result);

		if (result == 1) {
			return "redirect:mini_visit.do?id=" + vo.getId();
		} else {
			return "redirect:visit_insert.do?id=" + vo.getId();
		}

	}
	
	@RequestMapping(value = "/visit_deleteOK.do", method = RequestMethod.GET)
	public String visit_deleteOK(@RequestParam("id") String id, MiniCommentsVO vo) {
		log.info("visit_deleteOK(vo)...{}", vo);

		int result = minicomments_service.delete(vo);
		log.info("result...{}", result);
		
		if (result == 1) {
			return "redirect:mini_visit.do?id=" + id;
		}else {
			return "redirect:visit_findOne.do?id=" + id + "&mcnum=" + vo.getMcnum();
		}
	}
	
	@RequestMapping(value = "/mini_game.do", method = RequestMethod.GET)
	public String mini_game() {
		log.info("mini_game()...");

		return "mini/game/game";
	}
	
	@RequestMapping(value = "/mini_jukebox.do", method = RequestMethod.GET)
	public String mini_jukebox() {
		log.info("mini_jukebox()...");
		
		return "mini/jukebox/selectAll";
	}
	
//	@RequestMapping("/music_player")
//	public String musicPlayer(@RequestParam("id") String id, Model model) {
//	    MiniHomeVO vo = new MiniHomeVO();
//	    vo.setId(id);
//	    MiniHomeVO bgm_vo = service.selectOne(vo);
//	    model.addAttribute("bgm_vo", bgm_vo);
//	    return "views/mini/music_player";
//	}
	
	@RequestMapping(value = "/mini_peachPay.do", method = RequestMethod.GET)
	public String mini_peach_pay() {
		log.info("mini_peach_pay()...");

		return "mini/jukebox/peachPay";
	}

}