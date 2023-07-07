package multi.com.finalproject.member.controller;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MailService;
import multi.com.finalproject.member.service.MemberService;

@Controller
@Slf4j
public class MemberRestController {
	@Autowired
	MemberService service;

	@Autowired
	 MailService mailService;
	
	
	@RequestMapping(value = "/json_m_selectAll.do", method = RequestMethod.GET)
	public List<MemberVO> json_m_selectAll() {
		log.info("/json_m_selectAll.do");

		List<MemberVO> vos = service.selectAll();

		return vos;
	}

	@RequestMapping(value = "/json_m_selectOne.do", method = RequestMethod.GET)
	public MemberVO json_m_selectOne(MemberVO vo) {
		log.info("/json_mv_selectAll.do");

		MemberVO vo2 = service.selectOne(vo);
		if (vo2 == null)
			vo2 = vo;
		return vo2;
	}

	@ResponseBody
	@RequestMapping(value = "/json_m_idCheck.do", method = RequestMethod.GET)
	public String json_m_idCheck(MemberVO vo) {
		log.info("/json_m_idCheck.do...{}",vo);
		
		MemberVO vo2 = service.idCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_NickCheck.do", method = RequestMethod.GET)
	public String json_m_NickCheck(MemberVO vo) {
		log.info("/json_m_NickCheck.do...{}",vo);
		
		MemberVO vo2 = service.NickCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_m_TelCheck.do", method = RequestMethod.GET)
	public String json_m_TelCheck(MemberVO vo) {
		log.info("/json_m_TelCheck.do...{}",vo);
		
		MemberVO vo2 = service.TelCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkEmailAjax.do",method = RequestMethod.POST)
	public Map<String, String> sendMail(@RequestBody Map<String, String> map, HttpSession session) {

		log.info("/checkEmail.do에 들어옴");
		log.info("입력받은 email의 값 : " + map.get("email"));

		MemberVO vo = service.findUser( map.get("email")); 

		log.info("sendMail() 메서드 실행됨");
		String exists =""; 
				if(vo==null) {
					exists="false";
					}else{
					exists="true";
				}
				
		log.info("exists 필드의 값: " + exists);
		
		
		int random = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
		log.info("random의 값 : " + random);

		String joinCode = String.valueOf(random);
		log.info("joinCode의 값 : " + joinCode);

		session.setAttribute("joinCode", joinCode);

		String subject = "회원가입 인증 코드 입니다.";
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("안녕하세요. 'minihome'입니다.\r귀하의 인증 코드는  <" + joinCode + "> 입니다.");
		log.info(stringBuilder.toString());

		boolean finishSend = false;
		if (!exists.equals("true")) {
		    finishSend = this.mailService.send(subject, stringBuilder.toString(), "TongAdmin", map.get("email"));
		}
		log.info("성공이냐 실패냐 : " + finishSend);

		map.put("joinCode", joinCode);
		map.put("exists", exists);
		
		System.out.println(map);

		return map;
	}

}