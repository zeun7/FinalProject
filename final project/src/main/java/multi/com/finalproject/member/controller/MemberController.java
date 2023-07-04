package multi.com.finalproject.member.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

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

	@RequestMapping(value = "/m_insert.do", method = RequestMethod.GET)
	public String insert(MemberVO vo) {
		log.info("insert()....", vo);

		return "member/insert";
	}

	@RequestMapping(value = "/m_insertOK.do", method = RequestMethod.POST)
	public String insertOK(MemberVO vo) throws IllegalStateException, IOException {
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
			return "redirect:home.do";
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

//	 @RequestMapping(value = "/delete.do", method = RequestMethod.GET)
//	    public String deleteForm(Model model) {
//	        
//			MemberVO vo2 = service.user(vo); // 사용자 정보 가져오는 서비스 호출
//	        model.addAttribute("vo2", vo2); // 모델에 사용자 정보 추가
//	        return "member/delete"; // delete.jsp 뷰 반환
//	    }
//
//	    @RequestMapping(value = "/deleteOK.do", method = RequestMethod.POST)
//	    public String delete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
//	        MemberVO member = (MemberVO) session.getAttribute("member");
//	        String sessionPass = member.getPw();
//	        String voPass = vo.getPw();
//
//	        if (!sessionPass.equals(voPass)) {
//	            rttr.addFlashAttribute("msg", false);
//	            return "redirect:/delete.do";
//	        }
//
//	        service.delete(vo);
//	        session.invalidate();
//	        return "redirect:/";
//	    }

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
			return "redirect:m_selectOne.do?num=" + vo.getNum();
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
	public String loginOK(MemberVO vo, Model model) {
		log.info("/loginOK.do...{}", vo);

		MemberVO vo2 = service.login(vo);
		log.info("vo2...{}", vo2);

		if (vo2 == null) {
			model.addAttribute("message", "아이디 또는 비밀번호가 틀렸습니다.");
			return "redirect:login.do?message=fail";
		} else {
			session.setAttribute("num", vo2.getNum());
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

	@RequestMapping(value = "/find_pw_tel.do", method = RequestMethod.GET)
	public String find_pw_tel(HttpServletResponse response, @RequestParam("tel") String tel, Model model) {
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
				String sql = "select pw from member where tel = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, tel);

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

	@RequestMapping(value = "/find_pw_from_email.do")
	public String find_pw_from_email() throws Exception {

		return "member/find_pw_from_email";
	}

	@RequestMapping(value = "/find_pw_from_tel.do")
	public String find_pw_from_tel() throws Exception {

		return "member/find_pw_from_tel";
	}

	@RequestMapping(value = "/find_pw_from.do")
	public String find_pw_from() throws Exception {

		return "member/find_pw_from";
	}
}