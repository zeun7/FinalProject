package multi.com.finalproject.miniboard.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.miniboard.service.MiniBoardService;

@Slf4j
@Controller
public class MiniBoardRestController {

	@Autowired
	MiniBoardService service;

	@ResponseBody
	@RequestMapping(value = "/diary_updateOK.do", method = RequestMethod.POST)
	public Map<String, Object> diary_updateOK(
	    @ModelAttribute("vo") MiniBoardVO vo,
	    Model model,
	    @RequestParam(value = "title", required = false) String title,
	    @RequestParam(value = "content", required = false) String content,
	    @RequestParam(value = "bfile", required = false) MultipartFile bfile,
	    HttpSession session
	) throws Exception {
	    log.info("/diary_updateOK.do");

	    Integer mbnum = (Integer) session.getAttribute("mbnum");

	    vo.setMbnum(mbnum);

	    // 제목이나 내용이 수정되었을 경우에만 값을 설정합니다.
	    if (title != null && !title.isEmpty()) {
	        vo.setTitle(title);
	    }
	    if (content != null && !content.isEmpty()) {
	        vo.setContent(content);
	    }

	    if (bfile != null && !bfile.isEmpty()) {
	        String originalFilename = bfile.getOriginalFilename();
	        vo.setFilepath(originalFilename);

	        ServletContext sContext = session.getServletContext();
	        String realPath = sContext.getRealPath("resources/uploadimg");
	        File f = new File(realPath + File.separator + vo.getFilepath());
	        bfile.transferTo(f);

	        BufferedImage originalBufferImg = ImageIO.read(f);
	        BufferedImage thumbBufferImg = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
	        Graphics2D graphic = thumbBufferImg.createGraphics();
	        graphic.drawImage(originalBufferImg, 0, 0, 50, 50, null);

	        File thumbFile = new File(realPath + File.separator + "thumb_" + vo.getFilepath());
	        String formatName = vo.getFilepath().substring(vo.getFilepath().lastIndexOf(".") + 1);
	        ImageIO.write(thumbBufferImg, formatName, thumbFile);
	    } else {
	        vo.setFilepath(null); // 파일이 업로드되지 않았을 경우 파일 경로를 빈 문자열로 설정
	    }

	    int result = service.diary_update(vo);
	    Map<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("result", result);
	    resultMap.put("filePath", vo.getFilepath()); // 수정된 파일 경로를 resultMap에 추가합니다.

	    // 수정된 정보를 다시 조회하여 vo2를 업데이트합니다.
	    MiniBoardVO vo2 = service.diary_selectOne(vo);
	    model.addAttribute("vo2", vo2);

	    return resultMap;
	}

	
	@ResponseBody
	@RequestMapping(value = "/mongo_visit_findAll.do", method = RequestMethod.GET)
	public List<MiniBoardVO> mongo_visit_findAll() {
		log.info("/mongo_visit_findAll.do");

		List<MiniBoardVO> list = service.mongo_findAll();

		return list;
	}

	@ResponseBody
	@RequestMapping(value = "/mongo_visit_insertOK.do", method = RequestMethod.GET)
	public Map<String, Integer> mongo_visit_insertOK(MiniBoardVO vo) {
		log.info("mongo_visit_insertOK()...");

		Map<String, Integer> map = new HashMap<String, Integer>();

		int result = service.mongo_insert(vo);

		map.put("result", result);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mongo_visit_updateOK.do", method = RequestMethod.GET)
	public Map<String, Integer> mongo_visit_updateOK(MiniBoardVO vo) {
		log.info("mongo_visit_updateOK()...");

		Map<String, Integer> map = new HashMap<String, Integer>();

		int result = service.mongo_update(vo);

		map.put("result", result);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mongo_visit_deleteOK.do", method = RequestMethod.GET)
	public Map<String, Integer> mongo_visit_deleteOK(MiniBoardVO vo) {
		log.info("mongo_visit_deleteOK()...");

		Map<String, Integer> map = new HashMap<String, Integer>();

		int result = service.mongo_delete(vo);

		map.put("result", result);

		return map;
	}

}