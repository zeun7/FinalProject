package multi.com.finalproject.miniboard.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.LikesVO;
import multi.com.finalproject.jukebox.service.JukeboxService;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.miniboard.service.MiniBoardService;
import multi.com.finalproject.minicomments.service.MiniCommentsService;

@Slf4j
@Controller
public class MiniBoardRestController {

	@Autowired
	MiniBoardService service;
	
	@Autowired
	JukeboxService jukeService;
	
	@Autowired
	ServletContext sContext;
	
	@Autowired
	MiniCommentsService minicomments_service;
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_count.do", method = RequestMethod.GET)
	public int json_mb_count(MiniBoardVO vo) {
		log.info("/json_mb_count(vo)...{}", vo);
		int count = service.count(vo);
		log.info("count : {}", count);
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_selectAll.do", method = RequestMethod.GET)
	public List<MiniBoardVO> json_mb_selectAll(MiniBoardVO vo, int page) {
		log.info("/json_mb_selectAll(vo)...{}", vo);
		log.info("page...{}", page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		
		List<MiniBoardVO> vos = service.mb_selectAll(map);
		for (MiniBoardVO x : vos) {
			log.info(x.toString());
		}
		
		for(MiniBoardVO vo2 : vos) {
			vo2.setCcount(minicomments_service.mb_ccount(vo2));
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
	public String gallery_insertOK(@RequestParam("mbname") String mbname, 
			@RequestParam("writer") String writer, @RequestParam("title") String title, MultipartHttpServletRequest mRequest) {
		log.info("/gallery_insertOK.do...");
		List<MultipartFile> fileList = mRequest.getFiles("file");
		
	    // 파일이 업로드되지 않았을 경우 처리
	    if (fileList.isEmpty()) {
	        return "error";
	    }
	    
	    log.info("fileList : {}", fileList);
	    log.info("mbname : {}", mbname);
	    log.info("writer : {}", writer);
	    
	    // VO 객체 생성 및 데이터 설정
	    MiniBoardVO vo = new MiniBoardVO();
	    vo.setMbname(mbname);
	    vo.setWriter(writer);
	    vo.setTitle(title);
	    vo.setIsFileExist(1);

	    String fileNames = "";
	    
	    for(int i = 0; i < fileList.size(); i++) {
	    	// 원본 파일 이름
		    String originalFilename = fileList.get(i).getOriginalFilename();
		    log.info("original: {}", originalFilename);
	    	
	    	try {
	    		// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
	    		String realPath = sContext.getRealPath("resources/uploadimg");
	    		File f = new File(realPath + File.separator + originalFilename);
	    		fileList.get(i).transferTo(f);
	    		
	    		if(i == 0) {
	    			// 썸네일 이미지 생성
	    			BufferedImage originalBufferImg = ImageIO.read(f);
	    			BufferedImage thumbBufferImg = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
	    			Graphics2D graphic = thumbBufferImg.createGraphics();
	    			graphic.drawImage(originalBufferImg, 0, 0, 200, 200, null);
	    			
	    			File thumbFile = new File(realPath + File.separator + "gallery_thumb_" + originalFilename);
	    			String formatName = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
	    			ImageIO.write(thumbBufferImg, formatName, thumbFile);
	    		}
	    		
	    		fileNames += originalFilename;
	    		if(i < fileList.size() - 1) {
	    			fileNames += ",";
	    		}
	    	} catch (IOException e) {
	    		e.printStackTrace();
	    		return "error";
	    	}
	    	
	    }
	    vo.setFilepath(fileNames);
	    log.info("{}", vo);
	    
	    vo.setAi_path("");
	    
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
	public String gallery_updateOK(@RequestParam("filepath") String filepath, 
			@RequestParam("title") String title, 
			@RequestParam("mbnum") int mbnum,
			MultipartHttpServletRequest mRequest) {
		
		List<MultipartFile> fileList = mRequest.getFiles("file");
		
		// 파일이 업로드되지 않았을 경우 처리
	    if (fileList == null || fileList.isEmpty()) {
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
	    
		log.info("fileList : {}", fileList);
		log.info("title : {}", title);
		log.info("mbnum : {}", mbnum);
		
		// VO 객체 생성 및 데이터 설정
		MiniBoardVO vo = new MiniBoardVO();
		vo.setMbnum(mbnum);
		vo.setTitle(title);
		
		String fileNames = "";
		
		for(int i = 0; i < fileList.size(); i++) {
			// 원본 파일 이름
		    String originalFilename = fileList.get(i).getOriginalFilename();
		    log.info("original: {}", originalFilename);
			
			try {
				// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일 저장
				String realPath = sContext.getRealPath("resources/uploadimg");
				File f = new File(realPath + File.separator + originalFilename);
				fileList.get(i).transferTo(f);
				
				// 썸네일 이미지 생성
				BufferedImage originalBufferImg = ImageIO.read(f);
				BufferedImage thumbBufferImg = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
				Graphics2D graphic = thumbBufferImg.createGraphics();
				graphic.drawImage(originalBufferImg, 0, 0, 200, 200, null);
				
				File thumbFile = new File(realPath + File.separator + "gallery_thumb_" + originalFilename);
				String formatName = originalFilename.substring(originalFilename.lastIndexOf(".") + 1);
				ImageIO.write(thumbBufferImg, formatName, thumbFile);
				
				fileNames += originalFilename;
	    		if(i < fileList.size() - 1) {
	    			fileNames += ",";
	    		}
			} catch (IOException e) {
				e.printStackTrace();
				return "error";
			}
		}
		vo.setFilepath(fileNames);
	    log.info("{}", vo);
		
	    vo.setAi_path("");
	    
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
	@RequestMapping(value = "/json_mb_likeCheck.do", method = RequestMethod.GET)
	public Map<String, Integer> json_mb_likeCheck(LikesVO vo) {
		log.info("/json_mb_likeCheck.do...{}", vo);
		
		LikesVO vo2 = service.likeCheck(vo);
		log.info("vo2:{}", vo2);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		if(vo2 == null) {
			map.put("result", 0);
		}else {
			map.put("result", 1);
		}
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_like.do", method = RequestMethod.GET)
	public Map<String, Integer> json_mb_like(LikesVO vo) {
		log.info("/json_mb_like.do...{}", vo);
		
		int result = service.like(vo);
		log.info("result:{}", result);
		
		MiniBoardVO vo2 = new MiniBoardVO();
		vo2.setMbnum(vo.getMbnum());
		
		//좋아요 성공하면 카운트업
		if(result == 1) {
			service.likesUp(vo2);
		}
		MiniBoardVO vo3 = service.mb_selectOne(vo2);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("likes", vo3.getLikes());	//좋아요 개수 반환
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_like_delete.do", method = RequestMethod.GET)
	public Map<String, Integer> json_mb_like_delete(LikesVO vo) {
		log.info("/json_mb_like_delete.do...{}", vo);
		
		int result = service.deleteLike(vo);
		log.info("result:{}", result);
		
		MiniBoardVO vo2 = new MiniBoardVO();
		vo2.setMbnum(vo.getMbnum());
		
		//좋아요 삭제 성공하면 카운트다운
		if(result == 1) {
			service.likesDown(vo2);
		}
		MiniBoardVO vo3 = service.mb_selectOne(vo2);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("likes", vo3.getLikes());	//좋아요 개수 반환
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_mb_file_insertOK.do", method = RequestMethod.POST, consumes="multipart/form-data")
	public Map<String, List<String>> json_mb_file_insertOK(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		log.info("/json_mb_file_insertOK.do...");
		List<MultipartFile> fileList = mRequest.getFiles("file");
		log.info("{}", fileList);
		
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		List<String> filepathList = new ArrayList<String>();
		
		for(int i = 0; i < fileList.size(); i++) {
			String getOriginalFilename = fileList.get(i).getOriginalFilename();
			int fileNameLength = fileList.get(i).getOriginalFilename().length();
			log.info("getOriginalFilename:{}", getOriginalFilename);
			log.info("fileNameLength:{}", fileNameLength);
			
			if (getOriginalFilename.length() != 0) {
				String filepath = "resources/uploadimg/" + getOriginalFilename;
				// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
				String realPath = sContext.getRealPath("resources/uploadimg");
				log.info("realPath : {}", realPath);
				
				File f = new File(realPath + File.separator + getOriginalFilename);
				fileList.get(i).transferTo(f);
				
				filepathList.add(filepath);
			}
		}
		
		map.put("filepathList", filepathList);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_pcount_down.do", method = RequestMethod.GET)
	public Map<String, Integer> json_pcount_down(MemberVO vo) {
		log.info("/json_pcount_down.do...{}", vo);
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		jukeService.pcountDown(vo);
		
		int result = 1;
		map.put("result", result);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_download_image.do", method = RequestMethod.GET)
	public Map<String, String> json_download_image(String url, MemberVO vo) {
		log.info("/json_download_image.do...{}", url);
		log.info("vo:{}", vo);
		
        String imageUrl = url; // OpenAI로부터 받은 이미지 URL
        
        int randomStrLen = 10;
        
        Random random = new Random();
    	StringBuffer randomBuf = new StringBuffer();
    	for (int i = 0; i < randomStrLen; i++) {
    		// Random.nextBoolean() : 랜덤으로 true, false 리턴 (true : 랜덤 소문자 영어, false : 랜덤 숫자)
    		if (random.nextBoolean()) {
    			// 26 : a-z 알파벳 개수
    			// 97 : letter 'a' 아스키코드
    			// (int)(random.nextInt(26)) + 97 : 랜덤 소문자 아스키코드
    			randomBuf.append((char)((int)(random.nextInt(26)) + 97));
    		} else {
    			randomBuf.append(random.nextInt(10));
    		}
    	}
    	String generatedName = randomBuf.toString();
        generatedName += ".png";
        
        //파일 이름 랜덤하게 생성
        String filepath = "resources/uploadimg/" + vo.getId() + generatedName;
        
        String realPath = sContext.getRealPath("resources/uploadimg");
		log.info("realPath : {}", realPath);
		
		Path outputPath = Path.of(realPath + File.separator + vo.getId() + generatedName); // 저장할 위치와 파일 이름

        try (InputStream in = new URL(imageUrl).openStream()) {
            Files.copy(in, outputPath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        log.info("Image downloaded.");
        
        log.info("filepath:{}", filepath);
        
        Map<String, String> map = new HashMap<String, String>();
        map.put("filepath", filepath);
        
		return map;
	}
}