package multi.com.finalproject.jukebox.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.jukebox.model.KakaoReadyVO;
import multi.com.finalproject.jukebox.service.JukeboxService;
import multi.com.finalproject.member.model.MemberVO;

@Slf4j
@Controller
public class JukeboxController {
	
	@Autowired
	JukeboxService service;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping(value = "/kakaopay_success.do", method = RequestMethod.GET)
	public String kakaopay_success(int quantity) {
		log.info("/kakaopay_success.do...");
		log.info("quantity: {}", quantity);
		String user_id = (String) session.getAttribute("user_id");
		log.info(user_id);
		
		MemberVO vo = new MemberVO();
		vo.setId(user_id);
		vo.setPeach(quantity);
		
		int result = service.pcountUp(vo);
		log.info("result:{}", result);
		
		return "mini/jukebox/kakaopay_success";
	}
	
	@RequestMapping(value = "/kakaopay_cancel.do", method = RequestMethod.GET)
	public String kakaopay_cancel() {
		log.info("/kakaopay_cancel.do...");
		
		return "mini/jukebox/kakaopay_cancel";
	}
	
	@RequestMapping(value = "/kakaopay_fail.do", method = RequestMethod.GET)
	public String kakaopay_fail() {
		log.info("/kakaopay_fail.do...");
		
		return "mini/jukebox/kakaopay_fail";
	}
	
	
	
}