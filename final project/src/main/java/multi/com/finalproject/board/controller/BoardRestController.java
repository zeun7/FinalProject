package multi.com.finalproject.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.board.model.LikesVO;
import multi.com.finalproject.board.service.BoardService;

@Controller
@Slf4j
public class BoardRestController {
	
	@Autowired
	BoardService service;
	
	@Autowired
	ServletContext sContext;
	
	@ResponseBody
	@RequestMapping(value = "/json_b_selectAll.do", method = RequestMethod.GET)
	public List<BoardVO> json_b_selectAll(BoardVO vo, int page, int limit, String watcher) {
		log.info("/json_b_selectAll.do...{}, {}", page, limit);
		log.info("vo: {}", vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		map.put("limit", limit);
		map.put("watcher", watcher);
		
		List<BoardVO> vos = service.selectAll(map);
		log.info("{}", vos);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_count.do", method = RequestMethod.GET)
	public int json_b_count(BoardVO vo) {
		log.info("/json_b_count.do...{}", vo);
		
		int count = service.count(vo);
		
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_searchList.do", method = RequestMethod.GET)
	public List<BoardVO> json_b_searchList(BoardVO vo, int page, int limit, String searchKey, String searchWord,
			String watcher) {
		log.info("/json_b_searchList.do...{}", vo);
		log.info("page:{}, limit:{}", page, limit);
		log.info("searchKey:{}", searchKey);
		log.info("searchWord:{}", searchWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("page", page);
		map.put("limit", limit);
		map.put("searchKey", searchKey);
		map.put("searchWord", "%"+searchWord+"%");
		map.put("watcher", watcher);
		
		List<BoardVO> vos = service.searchList(map);
		log.info("{}", vos);
		
		return vos;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_searchList_count.do", method = RequestMethod.GET)
	public int json_b_searchList_count(BoardVO vo, String searchKey, String searchWord, String watcher) {
		log.info("/json_b_searchList_count.do...{}", vo);
		log.info("searchKey:{}", searchKey);
		log.info("searchWord:{}", searchWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vo", vo);
		map.put("searchKey", searchKey);
		map.put("searchWord", "%"+searchWord+"%");
		map.put("watcher", watcher);
		
		int count = service.searchCount(map);
		log.info("count:{}", count);
		return count;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_like.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_like(LikesVO vo) {
		log.info("/json_b_like.do...{}", vo);
		
		int result = service.like(vo);
		log.info("result:{}", result);
		
		BoardVO vo2 = new BoardVO();
		vo2.setBnum(vo.getBnum());
		
		//좋아요 성공하면 카운트업
		if(result == 1) {
			service.likesUp(vo2);
		}
		BoardVO vo3 = service.selectOne(vo2);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("likes", vo3.getLikes());	//좋아요 개수 반환
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_like_delete.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_like_delete(LikesVO vo) {
		log.info("/json_b_like_delete.do...{}", vo);
		
		int result = service.deleteLike(vo);
		log.info("result:{}", result);
		
		BoardVO vo2 = new BoardVO();
		vo2.setBnum(vo.getBnum());
		
		//좋아요 삭제 성공하면 카운트다운
		if(result == 1) {
			service.likesDown(vo2);
		}
		BoardVO vo3 = service.selectOne(vo2);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("likes", vo3.getLikes());	//좋아요 개수 반환
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/json_b_likeCheck.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_likeCheck(LikesVO vo) {
		log.info("/json_b_likeCheck.do...{}", vo);
		
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
	@RequestMapping(value = "/json_b_report.do", method = RequestMethod.GET)
	public Map<String, Integer> json_b_report(BoardVO vo) {
		log.info("/json_b_report.do...{}", vo);
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		return map;
	}	
	
	@ResponseBody
	@RequestMapping(value = "/json_b_file_insertOK.do", method = RequestMethod.POST, consumes="multipart/form-data")
	public Map<String, List<String>> json_b_file_insertOK(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		log.info("/json_b_file_insertOK.do...");
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
				String filepath = "resources/uploadimg_board/" + getOriginalFilename;
				// 웹 어플리케이션이 갖는 실제 경로: 이미지를 업로드할 대상 경로를 찾아서 파일저장.
				String realPath = sContext.getRealPath("resources/uploadimg_board");
				log.info("realPath : {}", realPath);
				
				File f = new File(realPath + File.separator + getOriginalFilename);
				fileList.get(i).transferTo(f);
				
				filepathList.add(filepath);
			}
		}
		
		map.put("filepathList", filepathList);
		
		return map;
	}
}