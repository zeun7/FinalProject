package multi.com.finalproject.openai.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.openai.model.RequestQuestionVO;
import multi.com.finalproject.openai.model.ResponseVO;

@Slf4j
@Service
public class GptService {
	private String API_KEY = "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";
    private static final String COMPLETION_ENDPOINT = "https://api.openai.com/v1/completions";
    private static final String IMAGES_ENDPOINT = "https://api.openai.com/v1/images/generations";

    public ResponseVO getConversation(RequestQuestionVO requestQuestionVO) {
        ResponseVO responseVo = new ResponseVO();
        try {

            String answer = generateText(requestQuestionVO.getQuestion(), 0.5f, 1000);

            responseVo.setCode(200);
            String answerFilter1 = answer.replaceAll("\n", "");
            String result =  answerFilter1.replaceAll("\\.","");
            result =  result.replaceAll("\\\\","");
            result =  result.replaceAll("\"","");

            responseVo.setResponse(result);
        } catch (Exception e) {
            responseVo.setCode(500);
            responseVo.setResponse("generateText error(서버 에러)");
        }
        return responseVo;
    }

    public ResponseVO makeImages(RequestQuestionVO requestQuestionVO) {
    	log.info("makeImages(requestQuestionVO)...{}", requestQuestionVO);
    	log.info("API_KEY : {}", API_KEY);
        ResponseVO responseVo = new ResponseVO();
        try {
            String url = makeImages(requestQuestionVO.getQuestion());
            responseVo.setCode(200);
            responseVo.setResponse(url);
        } catch (Exception e) {
            responseVo.setCode(500);
            responseVo.setResponse("generateText error(서버 에러)");
        }
        return responseVo;
    }

    public String generateText(String prompt, float temperature, int maxTokens) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + API_KEY);

        Map<String, Object> requestBody = new HashMap<String, Object>();
        requestBody.put("model","text-davinci-003");
        requestBody.put("prompt", prompt);
        requestBody.put("temperature", temperature);
        requestBody.put("max_tokens", maxTokens);

        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<Map<String, Object>>(requestBody, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.postForEntity(COMPLETION_ENDPOINT, requestEntity, Map.class);
        Map<String, Object> responseBody = response.getBody();
        System.out.println(responseBody.toString());

        List<Map<String, Object>> choicesList = (List<Map<String, Object>>)responseBody.get("choices");
        Map<String, Object> choiceMap = choicesList.get(0);
        String answer = (String)choiceMap.get("text");

        return answer;
    }

    public String makeImages(String prompt) {
    	log.info("makeImages()...");
    	log.info("prompt : {}", prompt);
    	log.info("API_KEY : {}", API_KEY);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + API_KEY);

        Map<String, Object> requestBody = new HashMap<String, Object>();
        requestBody.put("prompt", prompt);
        requestBody.put("size","1024x1024");
        requestBody.put("n", 1);
        requestBody.put("response_format", "url");

        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<Map<String, Object>>(requestBody, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.postForEntity(IMAGES_ENDPOINT, requestEntity, Map.class);
        Map<String, Object> responseBody = response.getBody();

        List<Map<String,Object>> dataList = (List<Map<String,Object>>)responseBody.get("data");
        String url = (String)(dataList.get(0).get("url"));
        return url;
    }
}