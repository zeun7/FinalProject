package multi.com.finalproject.jukebox;

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
			param += "&approval_url=http://localhost:8088/finalproject/kakaopay_success.do?quantity="+vo.getQuantity();
			param += "&cancel_url=http://localhost:8088/finalproject/kakaopay_cancel.do&fail_url=http://localhost:8088/finalproject/kakaopay_fail.do";
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
	
}