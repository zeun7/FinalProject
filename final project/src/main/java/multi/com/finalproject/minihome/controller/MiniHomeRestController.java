package multi.com.finalproject.minihome.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLContext;
import javax.servlet.http.HttpSession;

import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContextBuilder;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.member.service.MemberService;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.miniboard.service.MiniBoardService;
import multi.com.finalproject.minihome.model.GameVO;
import multi.com.finalproject.minihome.model.JukeboxVO;
import multi.com.finalproject.minihome.service.MiniHomeService;

@Slf4j
@Controller
public class MiniHomeRestController {
	
	@Autowired
	MiniHomeService service;
	
	@Autowired
	MiniBoardService miniboard_service;
	
	@Autowired
	MemberService member_service;
	
	@Autowired
	RestTemplate restTemplate;
	
	@Autowired
	HttpSession session;
	
	@ResponseBody
	@RequestMapping(value = "/newest_diary.do", method = RequestMethod.GET)
	public MiniBoardVO newest_diary(MiniBoardVO vo) {
		log.info("newest_diary(vo)...{}", vo);
		
		MiniBoardVO vo2 = miniboard_service.newest_diary(vo); 
		log.info("vo2 : {}", vo2);
		return vo2 != null ? vo2 : new MiniBoardVO();
	}
	
	@ResponseBody
	@RequestMapping(value = "/newest_gallery.do", method = RequestMethod.GET)
	public MiniBoardVO newest_gallery(MiniBoardVO vo) {
		log.info("newest_gallery(vo)...{}", vo);
		
		MiniBoardVO vo2 = miniboard_service.newest_gallery(vo);
		log.info("vo2 : {}", vo2);
		return vo2 != null ? vo2 : new MiniBoardVO();
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_j_count.do", method = RequestMethod.GET)
	public int json_j_count(JukeboxVO vo) {
		log.info("json_j_count(vo)...{}", vo);
		int count = service.count(vo);
		log.info("count : {}", count);
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_j_selectAll.do", method = RequestMethod.GET)
	public List<JukeboxVO> json_j_selectAll(JukeboxVO vo, int page) {
		log.info("json_j_selectAll(vo)...{}", vo);
		log.info("page : {}", page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		
		List<JukeboxVO> vos = service.j_selectAll(map);
		for (JukeboxVO x : vos) {
			log.info(x.toString());
		}
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/bgm_selectOne.do", method = RequestMethod.GET)
	public JukeboxVO bgm_selectOne(JukeboxVO vo) {
		log.info("bgm_selectOne(vo)...{}", vo);
		JukeboxVO vo2 = service.bgm_selectOne(vo);
		return vo2;
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/validateWord/{word}", method = RequestMethod.GET)
//	public Map<String, Object> validateWord(@PathVariable String word) {
//		
//	    String url = "https://opendict.korean.go.kr/api/search?certkey_no=5639&key=9C37D5176D46A9E8F98D17FD5AE96673&target_type=search&req_type=json&part=word&q="
//	            + word + "&sort=dict&start=1&num=10";
//	    Map<String, Object> result = new HashMap<>();
//	    try {
//	        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
//	        if(response.getStatusCode() == HttpStatus.OK) {
//	            JSONObject json = new JSONObject(response.getBody());
//	            int count = json.getJSONObject("searchResult").getInt("total");
//	            if (count > 0) {
//	                result.put("isValid", true);
//	            } else {
//	                result.put("isValid", false);
//	                result.put("message", "사전에 존재하지 않는 단어입니다.");
//	            }
//	        } else {
//	            result.put("isValid", false);
//	            result.put("message", "API request failed with status: " + response.getStatusCode());
//	        }
//	    } catch (RestClientException e) {
//	        result.put("isValid", false);
//	        result.put("message", "Exception occurred while making API request: " + e.getMessage());
//	    }
//	    return result;
//	}
	@ResponseBody
	@RequestMapping(value = "/validateWord/{word}", method = RequestMethod.GET)
	public Map<String, Object> validateWord(@PathVariable String word) throws Exception {
		log.info("validateWord(word)...{}", word);
	    // SSLContext를 생성하고 모든 인증서를 신뢰하도록 설정
	    SSLContext sslContext = SSLContextBuilder
	        .create()
	        .loadTrustMaterial(new TrustSelfSignedStrategy())
	        .build();

	    // 모든 호스트 이름을 신뢰하도록 HostnameVerifier를 설정
	    HostnameVerifier allowAllHosts = new NoopHostnameVerifier();

	    // SSLConnectionSocketFactory를 생성하고 위에서 만든 SSLContext와 HostnameVerifier를 사용하도록 설정
	    SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext, allowAllHosts);

	    // HttpClient를 생성하고 위에서 만든 SSLConnectionSocketFactory를 사용하도록 설정
	    CloseableHttpClient httpClient = HttpClients
	        .custom()
	        .setSSLSocketFactory(csf)
	        .build();

	    // RestTemplate의 RequestFactory를 HttpComponentsClientHttpRequestFactory로 설정하고, 
	    // 위에서 만든 HttpClient를 사용하도록 설정
	    HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
	    requestFactory.setHttpClient(httpClient);

	    RestTemplate restTemplate = new RestTemplate(requestFactory);

	    String url = "https://opendict.korean.go.kr/api/search?certkey_no=5639&key=9C37D5176D46A9E8F98D17FD5AE96673&target_type=search&req_type=json&part=word&q="
	        + word + "&sort=dict&start=1&num=10";
	    Map<String, Object> result = new HashMap<>();
	    try {
	        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
	        if(response.getStatusCode() == HttpStatus.OK) {
	            JSONObject json = new JSONObject(response.getBody());
	            int count = json.getJSONObject("channel").getInt("total");
	            if (count > 0) {
	                result.put("isValid", true);
	            } else {
	                result.put("isValid", false);
	                result.put("message", "사전에 존재하지 않는 단어입니다.");
	            }
	        } else {
	            result.put("isValid", false);
	            result.put("message", "API request failed with status: " + response.getStatusCode());
	        }
	    } catch (RestClientException e) {
	        result.put("isValid", false);
	        result.put("message", "Exception occurred while making API request: " + e.getMessage());
	    }
	    return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/game_record_insert.do", method = RequestMethod.POST)
	public Map<String, Object> game_record_insert(GameVO vo) {
		log.info("game_record_insert(vo)...{}", vo);
		
		log.info("game_ranking_insert(vo)...{}", vo);
	    Map<String, Object> map = new HashMap<String, Object>();

	    // 세션에서 id를 가져와서 세팅
	    MemberVO mvo = new MemberVO();
	    mvo.setId(session.getAttribute("user_id").toString());
	    MemberVO mvo2 = member_service.selectOne(mvo);
	    log.info("mvo2 : {}", mvo2);
	    
	    vo.setProfilepic(mvo2.getProfilepic());
	    vo.setId(mvo2.getId()); 

	    int result = service.record_insert(vo);
	    map.put("result", result);
	    if (result > 0) {
	        GameVO vo2 = service.record_selectOne(vo);
	        map.put("gnum", vo2.getGnum());
	    }
	    return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/game_ranking_all.do", method = RequestMethod.GET)
	public List<GameVO> game_ranking_all() {
		log.info("game_ranking_all()...");
		
		List<GameVO> vos = service.record_selectAll();
		log.info("역대 랭킹 vos : {}", vos);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/game_ranking_today.do", method = RequestMethod.GET)
	public List<GameVO> game_ranking_today() {
		log.info("game_ranking_today()...");
		
		List<GameVO> vos = service.record_selectAll_today();
		log.info("오늘 랭킹 vos : {}", vos);
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/game_ranking_all2.do", method = RequestMethod.GET)
	public Map<String, Object> game_ranking_all2(GameVO vo) {
		log.info("game_ranking_all2(vo)...{}", vo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<GameVO> vos = service.record_selectAll();
		GameVO vo2 = service.record_selectOne(vo);
		map.put("vos", vos);
		map.put("vo2", vo2);
		log.info("역대 랭킹 vos : {}", vos);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/game_ranking_today2.do", method = RequestMethod.GET)
	public Map<String, Object> game_ranking_today2(GameVO vo) {
		log.info("game_ranking_today2(vo)...{}", vo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<GameVO> vos = service.record_selectAll_today();
		GameVO vo2 = service.record_selectOne(vo);
		map.put("vos", vos);
		map.put("vo2", vo2);
		log.info("오늘 랭킹 vos : {}", vos);
		return map;
	}
}