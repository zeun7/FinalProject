package multi.com.finalproject.kakaopay;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KakaoService {

	static final String CID = "TC0ONETIME";
	static final String ADMIN_KEY = "c44837637d8b5cd56e70c4eece9c8825";
	
	public KakaoReadyResponseVO kakaoReadyRequest() {
		log.info("kakaoReadyRequest()...");
		
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("cid", "TC0ONETIME");
		parameters.add("partner_order_id", "123456");
		parameters.add("partner_user_id", "tester");
		parameters.add("item_name", "peach");
		parameters.add("quantity", "10");
		parameters.add("total_amount", "1000");
		parameters.add("tax_free_amount", "0");
		parameters.add("approval_url", "http://localhost:8088/finalproject/success");
		parameters.add("cancel_url", "http://localhost:8088/finalproject/cancel");
		parameters.add("fail_url", "http://localhost:8088/finalproject/fail");
		
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, getHeaders());
		
		RestTemplate restTemplate = new RestTemplate();
		
		KakaoReadyResponseVO kakaoReady = new KakaoReadyResponseVO();
		kakaoReady = restTemplate.postForObject("https://kapi.kakao.com/v1/payment/ready", requestEntity, KakaoReadyResponseVO.class);
		
		return kakaoReady;
	}
	
	private HttpHeaders getHeaders() {
		HttpHeaders httpHeaders = new HttpHeaders();
		
		String auth = "KakaoAK " + ADMIN_KEY;
		
		httpHeaders.set("Authorization", auth);
		httpHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		return httpHeaders;
	}
}
