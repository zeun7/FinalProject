package multi.com.finalproject.kakaopay;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class KakaoController {
	
	@Autowired
	KakaoService service;
	
	@ResponseBody
	@RequestMapping(value = "/mini_peachPayOK.do", method = RequestMethod.POST)
	public String mini_peachPayOK() {
		log.info("/mini_peachPayOK.do...");
		
		KakaoReadyResponseVO kakaoReady = service.kakaoReadyRequest();
		
		return "kakaoReady";
	}
	

}