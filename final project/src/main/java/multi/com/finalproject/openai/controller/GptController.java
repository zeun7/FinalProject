package multi.com.finalproject.openai.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.openai.model.RequestQuestionVO;
import multi.com.finalproject.openai.model.ResponseVO;
import multi.com.finalproject.openai.service.GptService;

@Slf4j
@Controller
public class GptController {
	@Autowired
	GptService gptService;

	@ResponseBody
	@RequestMapping(value = "/gptTranslate.do", method = RequestMethod.GET)
	public ResponseVO makeConversation(@Valid RequestQuestionVO requestQuestionVO) {
		log.info("makeConversation(requestQuestionVO)...{}", requestQuestionVO);
		String Query = requestQuestionVO.getQuestion() + "\n. Could you summarize this under 100 words and translate it to English?";
		requestQuestionVO.setQuestion(Query);
		ResponseVO responseVo = gptService.getConversation(requestQuestionVO);

		log.info("responseVo : {}", responseVo);
		return responseVo;
	}

	@ResponseBody
	@RequestMapping(value = "/gptMakeImage.do", method = RequestMethod.GET)
	public ResponseVO makeImages(@Valid RequestQuestionVO requestQuestionVO) {
		log.info("makeImages(requestQuestionVO)...{}", requestQuestionVO);
		ResponseVO responseVO = gptService.makeImages(requestQuestionVO);
		
		log.info("responseVo: {}", responseVO);
		return responseVO;
	}

}