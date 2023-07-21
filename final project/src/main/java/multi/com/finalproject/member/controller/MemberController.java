package multi.com.finalproject.member.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.service.BoardService;
import multi.com.finalproject.comments.service.CommentsService;
import multi.com.finalproject.manage.service.ManageService;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MemberService;
import multi.com.finalproject.miniboard.service.MiniBoardService;
import multi.com.finalproject.minicomments.service.MiniCommentsService;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Controller
@Slf4j
public class MemberController {

	@Autowired
	MemberService service;

	@Autowired
	BoardService board_service;

	@Autowired
	CommentsService comments_service;

	@Autowired
	MiniHomeService minihome_service;

	@Autowired
	MiniBoardService miniboard_service;

	@Autowired
	MiniCommentsService minicomments_service;

	@Autowired
	ManageService manage_service;

	@Autowired
	ServletContext sContext;

	@Autowired
	HttpSession session;

	@Autowired
	JavaMailSender mailSender;

	@RequestMapping(value = "/m_insert.do", method = RequestMethod.GET)
	public String insert(MemberVO vo) {
		log.info("insert()....", vo);

		return "member/insert";
	}

	@RequestMapping(value = "/m_insertOK.do", method = RequestMethod.POST)
	public String insertOK(MemberVO vo) throws IllegalStateException, IOException {

		// 필수 입력 항목 확인
		if (vo.getId().isEmpty() || vo.getPw().isEmpty() || vo.getNickname().isEmpty() || vo.getTel().isEmpty()
				|| vo.getQuestion().isEmpty() || vo.getAnswer().isEmpty()) {
			// 필수 입력 항목이 작성되지 않은 경우
			return "redirect:m_insert.do";
		}

		String getOriginalFilename = vo.getM_file().getOriginalFilename();
		int fileNameLength = vo.getM_file().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() == 0) {
			vo.setProfilepic("default.png");
		} else {
			vo.setProfilepic(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getProfilepic());
			vo.getM_file().transferTo(f);

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
			minihome_service.insert(vo);
			return "redirect:login.do";
		} else {
			return "redirect:m_insert.do";
		}
	}

	@RequestMapping(value = "/m_selectOne.do", method = RequestMethod.GET)
	public String m_selectOne(MemberVO vo, Model model) {
		log.info("/m_selectOne.do...{}", vo);

		MemberVO vo2 = service.selectOne(vo);
		
		int count1=board_service.m_count(vo2);
		int count2=miniboard_service.m_count2(vo2);
		
		int total = count1+count2;
		
		int likes1=board_service.b_likes(vo2);
		int likes2=miniboard_service.mb_likes(vo2);
		
		int total_likes = likes1+likes2;
		
		model.addAttribute("total_likes",total_likes);
		model.addAttribute("total",total);
		model.addAttribute("vo2", vo2);

		return "member/selectOne";
	}

	@RequestMapping(value = "/m_update.do", method = RequestMethod.GET)
	public String m_update(MemberVO vo, Model model) {
		log.info("/m_update.do...{}", vo);

		MemberVO vo2 = service.selectOne(vo);

		model.addAttribute("vo2", vo2);

		return "member/update";
	}

	@RequestMapping(value = "/m_updateOK.do", method = RequestMethod.POST)
	public String m_updateOK(MemberVO vo, Model model) throws IllegalStateException, IOException {
		log.info("/m_updateOK.do...{}", vo);

		String getOriginalFilename = vo.getM_file().getOriginalFilename();
		int fileNameLength = vo.getM_file().getOriginalFilename().length();
		log.info("getOriginalFilename:{}", getOriginalFilename);
		log.info("fileNameLength:{}", fileNameLength);

		if (getOriginalFilename.length() == 0) {
			vo.setProfilepic(vo.getProfilepic());
		} else {

			vo.setProfilepic(getOriginalFilename);
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
			String realPath = sContext.getRealPath("resources/uploadimg");
			log.info("realPath : {}", realPath);

			File f = new File(realPath + "\\" + vo.getProfilepic());
			vo.getM_file().transferTo(f);

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

		MemberVO vo2 = service.selectOne(vo);

		int result = service.update(vo);

		if (result == 1) {
			if (vo.getNickname() != vo2.getNickname()) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("before", vo2.getNickname());
				map.put("after", vo.getNickname());

				board_service.update_nickname(map);
				comments_service.update_nickname(map);
				miniboard_service.update_nickname(map);
				minicomments_service.update_nickname(map);
				manage_service.update_nickname(map);
			}

			session.invalidate();
			session.setAttribute("user_id", vo.getId());
			session.setAttribute("nickname", vo.getNickname());
			session.setAttribute("mclass", vo2.getMclass());
			session.setAttribute("profilepic", vo2.getProfilepic());

			return "redirect:m_selectOne.do?id=" + vo.getId();
		} else {
			return "redirect:m_update.do?id=" + vo.getId();
		}
	}

	@RequestMapping(value = "/m_deleteOK.do", method = RequestMethod.GET)
	public String m_deleteOK(MemberVO vo) {
		log.info("/m_deleteOK.do");
		log.info("vo:{}", vo);

		int result = service.delete(vo);
		log.info("result:{}", result);
		vo.setNickname(session.getAttribute("nickname").toString());

		if (result == 1) {
			miniboard_service.deleteAll(vo); // 미니홈피 게시글 삭제, 게시글 좋아요 삭제, 댓글 삭제, 댓글 좋아요 삭제
			board_service.deleteAll(vo); // 게시글 삭제, 게시글 좋아요 삭제, 댓글 삭제, 댓글 좋아요 삭제
			board_service.deleteLikesAll(vo); // 게시글 좋아요 삭제
			comments_service.deleteClikesAll(vo); // 게시글의 댓글 좋아요 삭제
			comments_service.deleteWriter(vo); // 작성한 댓글 삭제
			miniboard_service.deleteLikesAll(vo); // 미니홈피 게시글 좋아요 삭제
			minicomments_service.deleteClikesAll(vo); // 미니홈피 게시글의 댓글 좋아요 삭제
			minicomments_service.deleteWriter(vo); // 작성한 미니홈피 댓글 삭제
			manage_service.delfriendAll(vo); // 친구 목록 삭제

			session.invalidate(); // 세션 만료시킴

			return "redirect:home.do";

		} else {
			log.info("false");
			return "redirect:m_selectOne.do?id=" + vo.getId();
		}

	}

	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(MemberVO vo) {
		log.info("/m_logout.do...{}", vo);

		session.invalidate(); // 세션 만료시킴

		return "redirect:home.do";
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login(String message, Model model) {
		log.info("/login.do....{}", message);

		if (message != null)
			message = "아이디/비번 을 확인하세요";
		model.addAttribute("message", "아이디/비번 을 확인하세요");

		return "member/login";
	}

	@RequestMapping(value = "/loginOK.do", method = RequestMethod.POST)
	public String loginOK(String id, MemberVO vo, Model model) {
		log.info("/loginOK.do...{}", vo);

		MemberVO vo2 = service.login(vo);
		log.info("vo2...{}", vo2);

		if (vo2 == null) {
			model.addAttribute("message", "아이디/비번 을 확인하세요");
			model.addAttribute("errorMessage", true); // 에러 메시지 플래그 추가
			return "member/login";

		} else {
			log.info("내가 보유한 peach 갯수 : {}", vo2.getPeach());
			session.setAttribute("user_id", vo2.getId());
			session.setAttribute("nickname", vo2.getNickname());
			session.setAttribute("mclass", vo2.getMclass());
			session.setAttribute("profilepic", vo2.getProfilepic());
			session.setAttribute("myPeach", vo2.getPeach());
			session.setMaxInactiveInterval(60 * 120); // 60초 * 120 = 2시간
			return "redirect:home.do";
		}
	}

	@RequestMapping(value = "/find_id_email.do", method = RequestMethod.GET)
	public String find_id_email(@RequestParam("email") String email, Model model) {
		log.info("/find_id_email.do... email: {}", email);

		MemberVO vo = new MemberVO();
		vo.setEmail(email);

		MemberVO vo2 = service.find_id(vo);
		log.info("vo2... {}", vo2);

		if (vo2 == null) {
			model.addAttribute("message", "가입된 아이디가 존재하지 않습니다"); // 알림창에 표시할 메시지를 모델에 추가
			model.addAttribute("errorMessage", true);
			return "member/find_id_from_email";
		} else {
			session.setAttribute("id", vo2.getId());
			return "member/find_id"; // 아이디가 존재하는 경우를 나타내는 뷰로 이동
		}
	}

	@RequestMapping(value = "/find_id_question.do", method = RequestMethod.GET)
	public String find_id_question(MemberVO vo, Model model) {
		log.info("/find_id_question.do... vo: {}", vo);

		MemberVO vo2 = service.find_id_question(vo);
		log.info("vo2... {}", vo2);

		if (vo2 == null) {
			model.addAttribute("message", "가입된 아이디가 존재하지 않습니다"); // 알림창에 표시할 메시지를 모델에 추가
			model.addAttribute("errorMessage", true);
			return "member/find_id_from_question";
		} else {
			session.setAttribute("id", vo2.getId());
			return "member/find_id"; // 아이디가 존재하는 경우를 나타내는 뷰로 이동
		}
	}

	@RequestMapping(value = "/find_id_from.do")
	public String find_id_from() throws Exception {

		return "member/find_id_from";
	}


	@RequestMapping(value = "/find_id_from_email.do")
	public String find_id_from_email() throws Exception {

		return "member/find_id_from_email";
	}

	@RequestMapping(value = "/find_id_from_question.do")
	public String find_id_from_question() throws Exception {

		return "member/find_id_from_question";
	}

	@RequestMapping(value = "/find_pw_from.do")
	public String find_pw_from() throws Exception {

		return "member/find/pw";
	}

	@RequestMapping(value = "find_pass.do", method = RequestMethod.POST)
	public ModelAndView find_pass(HttpServletRequest request, String id, String email,
			RedirectAttributes redirectAttributes,HttpServletResponse response_email, MemberVO vo, Model model) throws IOException {
		log.info("find_pass.....{}", vo);
		MemberVO vo2 = service.find_user(vo);
		log.info("{}", vo2);

		model.addAttribute("vo2", vo2);

		if (vo2 == null) {
			response_email.setContentType("text/html; charset=UTF-8");
			
			 redirectAttributes.addFlashAttribute("message", "아이디 또는 이메일이 일치하지 않습니다.");
			 
		        return new ModelAndView("redirect:/find_pw_from.do");

		}

		// 랜덤한 난수 (인증번호) 생성
		Random r = new Random();
		int dice = r.nextInt(900000) + 100000;// 6자리의 랜덤한 숫자

		String setfrom = "anstjdus0917@gmail.com";
		String tomail = request.getParameter("email").trim();
		String title = "인증번호 메일";
		String content = "인증번호는 " + dice + "입니다.";

		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587 ");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

			Session session = Session.getDefaultInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(" anstjdus0917@gmail.com", "mhcoibmgvgzhlhoz");
				}
			});

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(setfrom));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(tomail));
			message.setSubject(title);
			message.setText(content);

			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}

		ModelAndView mv = new ModelAndView();
		mv.setViewName("member/find/pass_email"); // 뷰의 이름
		mv.addObject("dice", dice);
		mv.addObject("email", tomail);

		System.out.println("mv : " + mv);

		response_email.setContentType("text/html; charset=UTF-8");
		PrintWriter out_email = response_email.getWriter();
		out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
		out_email.flush();
		return mv;
	}

	// 인증번호를 입력한 후에 확인 버튼을 누르면 자료가 넘어오는 컨트롤러
	@RequestMapping(value = "/pass_injeung.do", method = RequestMethod.POST)
	public ModelAndView pass_injeung(String pass_injeung, String dice, MemberVO vo, Model model,
			HttpServletResponse response_equals) throws IOException {

		System.out.println("마지막 : pass_injeung : " + pass_injeung);

		System.out.println("마지막 : dice : " + dice);

		ModelAndView mv = new ModelAndView();

		mv.setViewName("member/find/pass_change");
		model.addAttribute("vo", vo);

		mv.addObject("email", vo.getEmail());

		if (pass_injeung.equals(dice)) {

			// 인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 비밀번호 변경창으로 이동시킨다

			mv.setViewName("member/find/pass_change");

			mv.addObject("email", vo.getEmail());

			// 만약 인증번호가 같다면 이메일을 비밀번호 변경 페이지로 넘기고, 활용할 수 있도록 한다.

			response_equals.setContentType("text/html; charset=UTF-8");
			PrintWriter out_equals = response_equals.getWriter();
			out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 변경창으로 이동합니다.');</script>");
			out_equals.flush();

			return mv;

		} else if (pass_injeung != dice) {

			ModelAndView mv2 = new ModelAndView();

			mv2.setViewName("member/find/pass_email");

			response_equals.setContentType("text/html; charset=UTF-8");
			PrintWriter out_equals = response_equals.getWriter();
			out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.'); history.go(-1);</script>");
			out_equals.flush();

			return mv2;

		}

		return mv;

	}

	// 변경할 비밀번호를 입력한 후에 확인 버튼을 누르면 넘어오는 컨트롤러
	@RequestMapping(value = "pass_change.do", method = RequestMethod.POST)
	public ModelAndView pass_change(MemberVO vo) throws Exception {
		log.info("vo:{}", vo);
		service.pass_change(vo);

		ModelAndView mv = new ModelAndView();

		mv.setViewName("member/find/find_pass_result");

		return mv;

	}

	@RequestMapping(value = "/loginSuccess.do")
	public String loginSuccess() throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			String username = ((UserDetails) principal).getUsername();

			MemberVO vo = new MemberVO();
			vo.setId(username);

			MemberVO vo2 = service.selectOne(vo);

			session.setAttribute("user_id", vo2.getId());
			session.setAttribute("nickname", vo2.getNickname());
			session.setAttribute("mclass", vo2.getMclass());
			session.setAttribute("profilepic", vo2.getProfilepic());
			session.setAttribute("myPeach", vo2.getPeach());
			session.setMaxInactiveInterval(60 * 120); // 60초 * 120 = 2시간
		} else {
			String username = principal.toString();
		}

		return "home";
	}

	@RequestMapping(value = "/loginFail.do")
	public String loginFail(Model model) {
		model.addAttribute("message", "아이디/비번 을 확인하세요");
		model.addAttribute("errorMessage", true); // 에러 메시지 플래그 추가
		return "member/login";
	}
}