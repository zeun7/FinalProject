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
import java.util.List;

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
import multi.com.finalproject.minihome.model.JukeboxVO;

@Slf4j
@Controller
public class JukeboxRestController {
	
	@Autowired
	JukeboxService service;
	
	@Autowired
	HttpSession session;
	
	@ResponseBody
	@RequestMapping(value = "/json_peachPay.do", method = RequestMethod.GET)
	public String json_peachPay(KakaoReadyVO vo) {
		log.info("/json_peachPay.do...{}", vo);
		
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection huConnection = (HttpURLConnection) url.openConnection();
			huConnection.setRequestMethod("POST");
			huConnection.setRequestProperty("Authorization", "KakaoAK c44837637d8b5cd56e70c4eece9c8825");
			huConnection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			huConnection.setDoOutput(true);
			
			String param = "cid=TC0ONETIME&partner_order_id=123456";
			param += "&partner_user_id=" + vo.getPartner_user_id();
			param += "&item_name=peach";
			param += "&quantity=" + vo.getQuantity();
			param += "&total_amount=" + vo.getTotal_amount();
			param += "&tax_free_amount=0";
			
//			로컬에서의 리다이렉트 주소
			param += "&approval_url=http://localhost:8088/finalproject/kakaopay_success.do?quantity="+vo.getQuantity();
			param += "&cancel_url=http://localhost:8088/finalproject/kakaopay_cancel.do&fail_url=http://localhost:8088/finalproject/kakaopay_fail.do";
			
//			배포서버에서 리다이렉트 주소
//			param += "&approval_url=http://175.45.201.175:8080/final%20project/kakaopay_success.do?quantity="+vo.getQuantity();
//			param += "&cancel_url=http://175.45.201.175:8080/final%20project/kakaopay_cancel.do&fail_url=http://175.45.201.175/finalproject/kakaopay_fail.do";
			
			OutputStream outputStream = huConnection.getOutputStream();
			
			DataOutputStream dataOutputStream = new DataOutputStream(outputStream);
			dataOutputStream.writeBytes(param);
			dataOutputStream.close();
			
			int resultCode = huConnection.getResponseCode();
			
			InputStream inputStream;
			if(resultCode == 200) {
				inputStream = huConnection.getInputStream();
			}else {
				inputStream = huConnection.getErrorStream();
			}
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
			BufferedReader br = new BufferedReader(inputStreamReader);
			return br.readLine();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "{\"result\":\"NO\"}";
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_musicPay_count.do", method = RequestMethod.GET)
	public int json_musicPay_count() {
		log.info("/json_musicPay_count.do...");
		
		int count = service.count();
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_musicPay_selectAll.do", method = RequestMethod.GET)
	public List<JukeboxVO> json_musicPay_selectAll(int page) {
		log.info("/json_musicPay_selectAll.do...{}", page);
		
		List<JukeboxVO> vos = service.selectAll(page);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_peach_count.do", method = RequestMethod.GET)
	public MemberVO json_peach_count(MemberVO vo) {
		log.info("/json_peach_count.do...{}", vo);
		
		MemberVO vo2 = service.peachCount(vo);
		
		return vo2;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_jukebox_insertOK.do", method = RequestMethod.GET)
	public int json_jukebox_insertOK(String id, String bgm, int peach) {
		log.info("/json_jukebox_insertOK.do...");
		log.info("id:{}", id);
		log.info("bgm:{}", bgm);
		log.info("peach:{}", peach);
		
		MemberVO vo = new MemberVO();
		vo.setId(id);
		vo.setPeach(peach);
		service.pcountDown(vo);
		
		JukeboxVO jvo = new JukeboxVO();
		jvo.setId(id);
		jvo.setBgm(bgm);
		int result = service.insert(jvo);
		log.info("{}", result);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_jukebox_check.do", method = RequestMethod.GET)
	public int json_jukebox_check(JukeboxVO vo) {
		log.info("/json_jukebox_check.do...{}", vo);
		
		JukeboxVO vo2 = service.jukebox_check(vo);
		log.info("{}", vo2);
		
		int result = 1;
		if(vo2 == null) {
			result = 0;
		}
		return result;
	}
	
}