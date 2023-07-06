package multi.com.finalproject.member.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
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
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberDAO;
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

	@Autowired
	MemberDAO dao;
	
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
			return "redirect:login.do";
		} else {
			return "redirect:m_insert.do";
		}
	}

	@RequestMapping(value = "/m_selectOne.do", method = RequestMethod.GET)
	public String m_selectOne(MemberVO vo, Model model) {
		log.info("/m_selectOne.do...{}", vo);

		MemberVO vo2 = service.selectOne(vo);

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

		int result = service.update(vo);

		if (result == 1) {
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
		if (result == 1) {
			session.invalidate(); // 세션 만료시킴

			return "redirect:home.do";

		} else {
			log.info("false");
			return "redirect:m_selectOne.do?id=" + vo.getId();
		}

	}

//	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
//	public String logout(MemberVO vo) {
//		log.info("/m_logout.do...{}", vo);
//
//		session.invalidate(); // 세션 만료시킴
//
//		return "redirect:home.do";
//	}
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
		model.addAttribute("message", message);

		return "member/login";
	}

	@RequestMapping(value = "/loginOK.do", method = RequestMethod.POST)
	public String loginOK(String id, MemberVO vo, Model model) {
		log.info("/loginOK.do...{}", vo);

		MemberVO vo2 = service.login(vo);
		log.info("vo2...{}", vo2);

		if (vo2 == null) {
			model.addAttribute("message", "아이디 또는 비밀번호가 틀렸습니다.");
			model.addAttribute("errorMessage", true); // 에러 메시지 플래그 추가
			return "member/login";
		} else {
			session.setAttribute("user_id", vo2.getId());
			session.setAttribute("nickname", vo2.getNickname());
			session.setAttribute("mclass", vo2.getMclass());
			return "redirect:home.do";
		}
	}

	@RequestMapping(value = "/find_id_email.do", method = RequestMethod.GET)
	public String find_id_email(HttpServletResponse response, @RequestParam("email") String email, Model model) {
		try {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				// Oracle JDBC 드라이버 로드
				Class.forName("oracle.jdbc.driver.OracleDriver");

				// 데이터베이스 연결 설정
				String url = "jdbc:oracle:thin:@(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.ap-chuncheon-1.oraclecloud.com))(connect_data=(service_name=gcbc9103dc3cfcf_final_high.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)))"; // 데이터베이스
																																																																								// URL
				String username = "admin"; // 데이터베이스 사용자명
				String password = "Final123456!"; // 데이터베이스 비밀번호

				conn = DriverManager.getConnection(url, username, password);

				// SQL 문장 준비
				String sql = "select id from member where email = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, email);

				// 쿼리 실행
				rs = pstmt.executeQuery();

				// 결과 처리
				if (rs.next()) {
					String id = rs.getString("id");
					model.addAttribute("id", id);
				} else {
					out.println("<script>");
					out.println("alert('가입된 아이디가 없습니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					out.close();
					return null;
				}
			} finally {
				// 리소스 해제
				if (rs != null) {
					rs.close();
				}

				if (pstmt != null) {
					pstmt.close();
				}

				if (conn != null) {
					conn.close();
				}
			}

			return "member/find_id";
		} catch (Exception e) {
			// 예외 처리
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "/find_id_tel.do", method = RequestMethod.GET)
	public String find_id_tel(HttpServletResponse response, @RequestParam("tel") String tel, Model model) {
		try {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				// Oracle JDBC 드라이버 로드
				Class.forName("oracle.jdbc.driver.OracleDriver");

				// 데이터베이스 연결 설정
				String url = "jdbc:oracle:thin:@(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.ap-chuncheon-1.oraclecloud.com))(connect_data=(service_name=gcbc9103dc3cfcf_final_high.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)))"; // 데이터베이스
				// URL
				String username = "admin"; // 데이터베이스 사용자명
				String password = "Final123456!"; // 데이터베이스 비밀번호

				conn = DriverManager.getConnection(url, username, password);

				// SQL 문장 준비
				String sql = "select id from member where tel = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, tel);

				// 쿼리 실행
				rs = pstmt.executeQuery();

				// 결과 처리
				if (rs.next()) {
					String id = rs.getString("id");
					model.addAttribute("id", id);
				} else {
					out.println("<script>");
					out.println("alert('가입된 아이디가 없습니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					out.close();
					return null;
				}
			} finally {
				// 리소스 해제
				if (rs != null) {
					rs.close();
				}

				if (pstmt != null) {
					pstmt.close();
				}

				if (conn != null) {
					conn.close();
				}
			}

			return "member/find_id";
		} catch (Exception e) {
			// 예외 처리
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "/find_id_from.do")
	public String find_id_from() throws Exception {

		return "member/find_id_from";
	}

	@RequestMapping(value = "/find_id_from_tel.do")
	public String find_id_from_tel() throws Exception {

		return "member/find_id_from_tel";
	}

	@RequestMapping(value = "/find_id_from_email.do")
	public String find_id_from_email() throws Exception {

		return "member/find_id_from_email";
	}

	@RequestMapping(value = "/find_pw_email.do", method = RequestMethod.GET)
	public String find_pw_email(HttpServletResponse response, @RequestParam("email") String email, Model model) {
		try {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				// Oracle JDBC 드라이버 로드
				Class.forName("oracle.jdbc.driver.OracleDriver");

				// 데이터베이스 연결 설정
				String url = "jdbc:oracle:thin:@(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.ap-chuncheon-1.oraclecloud.com))(connect_data=(service_name=gcbc9103dc3cfcf_final_high.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)))"; // 데이터베이스
																																																																								// URL
				String username = "admin"; // 데이터베이스 사용자명
				String password = "Final123456!"; // 데이터베이스 비밀번호

				conn = DriverManager.getConnection(url, username, password);

				// SQL 문장 준비
				String sql = "select pw from member where email = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, email);

				// 쿼리 실행
				rs = pstmt.executeQuery();

				// 결과 처리
				if (rs.next()) {
					String pw = rs.getString("pw");
					model.addAttribute("pw", pw);
				} else {
					out.println("<script>");
					out.println("alert('가입된 비밀번호가 없습니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					out.close();
					return null;
				}
			} finally {
				// 리소스 해제
				if (rs != null) {
					rs.close();
				}

				if (pstmt != null) {
					pstmt.close();
				}

				if (conn != null) {
					conn.close();
				}
			}

			return "member/find_pw";
		} catch (Exception e) {
			// 예외 처리
			e.printStackTrace();
			return null;
		}
	}

//	@RequestMapping(value = "/find_pw_tel.do", method = RequestMethod.GET)
//	public String find_pw_tel(HttpServletResponse response, @RequestParam("tel") String tel, Model model) {
//		try {
//			response.setContentType("text/html;charset=utf-8");
//			PrintWriter out = response.getWriter();
//
//			Connection conn = null;
//			PreparedStatement pstmt = null;
//			ResultSet rs = null;
//
//			try {
//				// Oracle JDBC 드라이버 로드
//				Class.forName("oracle.jdbc.driver.OracleDriver");
//
//				// 데이터베이스 연결 설정
//				String url = "jdbc:oracle:thin:@(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.ap-chuncheon-1.oraclecloud.com))(connect_data=(service_name=gcbc9103dc3cfcf_final_high.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)))"; // 데이터베이스
//				// URL
//				String username = "admin"; // 데이터베이스 사용자명
//				String password = "Final123456!"; // 데이터베이스 비밀번호
//
//				conn = DriverManager.getConnection(url, username, password);
//
//				// SQL 문장 준비
//				String sql = "select pw from member where tel = ?";
//				pstmt = conn.prepareStatement(sql);
//				pstmt.setString(1, tel);
//
//				// 쿼리 실행
//				rs = pstmt.executeQuery();
//
//				// 결과 처리
//				if (rs.next()) {
//					String pw = rs.getString("pw");
//					model.addAttribute("pw", pw);
//				} else {
//					out.println("<script>");
//					out.println("alert('가입된 비밀번호가 없습니다.');");
//					out.println("history.go(-1);");
//					out.println("</script>");
//					out.close();
//					return null;
//				}
//			} finally {
//				// 리소스 해제
//				if (rs != null) {
//					rs.close();
//				}
//
//				if (pstmt != null) {
//					pstmt.close();
//				}
//
//				if (conn != null) {
//					conn.close();
//				}
//			}
//
//			return "member/find_pw";
//		} catch (Exception e) {
//			// 예외 처리
//			e.printStackTrace();
//			return null;
//		}
//	}

//	@RequestMapping(value = "/find_pw_from_email.do")
//	public String find_pw_from_email() throws Exception {
//
//		return "member/find_pw_from_email";
//	}
//
	@RequestMapping(value = "/find_pw_from.do")
	public String find_pw_from() throws Exception {

		return "member/find/pw";
	}

	
	@RequestMapping(value = "find_pass.do", method = RequestMethod.POST)
    public ModelAndView find_pass(HttpServletRequest request, String id, String email,
            HttpServletResponse response_email,MemberVO vo, Model model) throws IOException{
		log.info("find_pass.....{}",vo);
	MemberVO vo2= service.find_user(vo);
	
	model.addAttribute("vos", vo2);
	
	if (vo2 == null) {
        response_email.setContentType("text/html; charset=UTF-8");
        PrintWriter out_email = response_email.getWriter();
        out_email.println("<script>alert('아이디 또는 이메일이 일치하지 않습니다.');</script>");
        out_email.flush();
        
        // 알림창을 표시한 후 이전 페이지로 돌아감
        return new ModelAndView("redirect:/forgot-password");
    }
	

	    // 랜덤한 난수 (인증번호) 생성
	    Random r = new Random();
	    int dice = r.nextInt(900000) + 100000;//6자리의 랜덤한 숫자
	    
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

    

	//인증번호를 입력한 후에 확인 버튼을 누르면 자료가 넘어오는 컨트롤러
    @RequestMapping(value = "pass_injeung.do{dice},{email}", method = RequestMethod.POST)
        public ModelAndView pass_injeung(String pass_injeung, @PathVariable String dice, @PathVariable String email, 
                HttpServletResponse response_equals) throws IOException{
        
        System.out.println("마지막 : pass_injeung : "+pass_injeung);
        
        System.out.println("마지막 : dice : "+dice);
        
        ModelAndView mv = new ModelAndView();
        
        mv.setViewName("member/find/pass_change");
        
        mv.addObject("email",email);
        
        if (pass_injeung.equals(dice)) {
            
            //인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 비밀번호 변경창으로 이동시킨다
        
            mv.setViewName("member/find/pass_change");
            
            mv.addObject("email",email);
            
            //만약 인증번호가 같다면 이메일을 비밀번호 변경 페이지로 넘기고, 활용할 수 있도록 한다.
            
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 변경창으로 이동합니다.');</script>");
            out_equals.flush();
    
            return mv;
            
            
        }else if (pass_injeung != dice) {
            
            
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
    
    
    
    //변경할 비밀번호를 입력한 후에 확인 버튼을 누르면 넘어오는 컨트롤러
    @RequestMapping(value = "pass_change.do{email}", method = RequestMethod.POST)
    public ModelAndView pass_change(@PathVariable String email, HttpServletRequest request, MemberVO vo, HttpServletResponse pass) throws Exception{
                
    String pw = request.getParameter("pw");
                
    String email1 = email;
                
    vo.setEmail(email1);
    vo.setPw(pw);
    
    //값을 여러개 담아야 하므로 해쉬맵을 사용해서 값을 저장함
    
    Map<String, Object> map = new HashMap<>();
    
	map.put("email", vo.getEmail());
    map.put("pw", vo.getPw());
    
    service.pass_change(map,vo);
   
    
    ModelAndView mv = new ModelAndView();
    
    mv.setViewName("member/find/find_pass_result");
    
    return mv;
                
    }
}