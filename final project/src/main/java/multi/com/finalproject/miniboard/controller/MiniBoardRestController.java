package multi.com.finalproject.miniboard.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@Autowired
	ServletContext sContext;
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_count.do", method = RequestMethod.GET)
	public int json_mb_count(MiniBoardVO vo) {
		log.info("/json_mb_count.do...{}", vo);
		int count = service.count(vo);
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_selectAll.do", method = RequestMethod.GET)
	public List<MiniBoardVO> json_mb_selectAll(MiniBoardVO vo, int page) {
		log.info("/json_mb_selectAll.do(vo)...{}", vo);
		log.info("page...{}", page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		
		List<MiniBoardVO> vos = service.mb_selectAll(map);
		for (MiniBoardVO x : vos) {
			log.info(x.toString());
		}
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/select_mb_deleteOK.do", method = RequestMethod.POST)
	public String select_mb_deleteOK(MiniBoardVO vo) {
		log.info("/select_mb_deleteOK(vo)...{}", vo);
		
		int result = service.mb_delete(vo);
		log.info("result : {}", result);
		if (result == 1) {
		    return "success";
	    } else {
	        return "error";
	    }
	}
	
	@ResponseBody
	@RequestMapping(value = "/gallery_insertOK.do", method = RequestMethod.POST)
	public String gallery_insertOK(@RequestParam("file") MultipartFile file, @RequestParam("mbname") String mbname, 
			@RequestParam("writer") String writer, @RequestParam("title") String title) {
	    // 파일이 업로드되지 않았을 경우 처리
	    if (file.isEmpty()) {
	        return "error";
	    }

	    // 원본 파일 이름
	    String originalFilename = file.getOriginalFilename();
	    
	    log.info("file : {}", file.toString());
	    log.info("mbname : {}", mbname);
	    log.info("writer : {}", writer);
	    
	    // VO 객체 생성 및 데이터 설정
	    MiniBoardVO vo = new MiniBoardVO();
	    vo.setMbname(mbname);
	    vo.setWriter(writer);
	    vo.setTitle(title);
	    vo.setFilepath(originalFilename);

	    try {
	        // 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
	        String realPath = sContext.getRealPath("resources/uploadimg");
	        File f = new File(realPath + File.separator + vo.getFilepath());
	        file.transferTo(f);

	        // 썸네일 이미지 생성
	        BufferedImage originalBufferImg = ImageIO.read(f);
	        BufferedImage thumbBufferImg = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
	        Graphics2D graphic = thumbBufferImg.createGraphics();
	        graphic.drawImage(originalBufferImg, 0, 0, 50, 50, null);

	        File thumbFile = new File(realPath + File.separator + "thumb_" + vo.getFilepath());
	        String formatName = vo.getFilepath().substring(vo.getFilepath().lastIndexOf(".") + 1);
	        ImageIO.write(thumbBufferImg, formatName, thumbFile);

	    } catch (IOException e) {
	        e.printStackTrace();
	        return "error";
	    }

	    // 서비스 호출
	    int result = service.mb_insert(vo);

	    // 처리 결과에 따른 응답
	    if (result > 0) {
	        return "success";
	    } else {
	        return "error";
	    }
	}
	
	@ResponseBody
	@RequestMapping(value = "/gallery_updateOK.do", method = RequestMethod.POST)
	public String gallery_updateOK(@RequestParam(value="file", required=false) MultipartFile file, 
			@RequestParam("filepath") String filepath, 
			@RequestParam("title") String title, 
			@RequestParam("mbnum") int mbnum) {
		// 파일이 업로드되지 않았을 경우 처리
	    if (file == null || file.isEmpty()) {
	        if(filepath == null || filepath.isEmpty()){
	            return "error";
	        }
	        else{
	            // 파일이 업로드되지 않았지만 기존의 파일을 사용
	            // filepath는 이미 서버에 있는 파일의 경로
	            String originalFilename = filepath;
	            // 서비스 호출
	            MiniBoardVO vo = new MiniBoardVO();
	            vo.setMbnum(mbnum);
	            vo.setTitle(title);
	            vo.setFilepath(originalFilename);
	            int result = service.gallery_update(vo);
	            if (result > 0) {
	                return "success";
	            } else {
	                return "error";
	            }
	        }
	    }
	    
		// 원본 파일 이름
		String originalFilename = file.getOriginalFilename();
		
		log.info("file : {}", file.toString());
		log.info("title : {}", title);
		log.info("mbnum : {}", mbnum);
		
		// VO 객체 생성 및 데이터 설정
		MiniBoardVO vo = new MiniBoardVO();
		vo.setMbnum(mbnum);
		vo.setTitle(title);
		vo.setFilepath(originalFilename);
		
		try {
			// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
			String realPath = sContext.getRealPath("resources/uploadimg");
			File f = new File(realPath + File.separator + vo.getFilepath());
			file.transferTo(f);
			
			// 썸네일 이미지 생성
			BufferedImage originalBufferImg = ImageIO.read(f);
			BufferedImage thumbBufferImg = new BufferedImage(50, 50, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = thumbBufferImg.createGraphics();
			graphic.drawImage(originalBufferImg, 0, 0, 50, 50, null);
			
			File thumbFile = new File(realPath + File.separator + "thumb_" + vo.getFilepath());
			String formatName = vo.getFilepath().substring(vo.getFilepath().lastIndexOf(".") + 1);
			ImageIO.write(thumbBufferImg, formatName, thumbFile);
			
		} catch (IOException e) {
			e.printStackTrace();
			return "error";
		}
		
		// 서비스 호출
		int result = service.gallery_update(vo);
		
		// 처리 결과에 따른 응답
		if (result > 0) {
			return "success";
		} else {
			return "error";
		}
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