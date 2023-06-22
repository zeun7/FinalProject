package multi.com.finalproject.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardDAO;
import multi.com.finalproject.board.model.BoardVO;

@Service
@Slf4j
public class BoardService {

	@Autowired
	BoardDAO dao;
	
	public BoardService() {
		log.info("BoardService()...");
	}
	
	public List<BoardVO> selectAll(Map<String, Object> map){
		return dao.selectAll(map);
	}

	public BoardVO selectOne(BoardVO vo){
		return dao.selectOne(vo);
	}

	public List<BoardVO> searchList(Map<String, Object> map) {
		return dao.searchList(map);
	}

	public void vcountUp(BoardVO vo){
		dao.vcountUp(vo);
	}
	
	public void likesUp(BoardVO vo){
		dao.likesUp(vo);
	}

	public int insert(BoardVO vo){
		return dao.insert(vo);
	}

	public int update(BoardVO vo){
		return dao.update(vo);
	}

	public int delete(BoardVO vo){
		return dao.delete(vo);
	}
	
	public int like(Map<String, Integer> param){
		return dao.like(param);
	}
	
	public int report(Map<String, Object> map){
		return dao.report(map);
	}

	public int count(BoardVO vo) {
		return dao.count(vo);
	}

	public int searchCount(Map<String, Object> map) {
		return dao.searchCount(map);
	}

	public int deleteLike(Map<String, Integer> param) {
		return dao.deleteLike(param);
	}

	public void likesDown(BoardVO vo) {
		dao.likesDown(vo);
	}
	
}