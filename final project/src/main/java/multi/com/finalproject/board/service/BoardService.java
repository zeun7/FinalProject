package multi.com.finalproject.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardDAO;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.board.model.LikesVO;
import multi.com.finalproject.member.model.MemberVO;

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
	
	public int like(LikesVO vo){
		return dao.like(vo);
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

	public int deleteLike(LikesVO vo) {
		return dao.deleteLike(vo);
	}

	public void likesDown(BoardVO vo) {
		dao.likesDown(vo);
	}

	public LikesVO likeCheck(LikesVO vo) {
		return dao.likeCheck(vo);
	}

	public void update_nickname(Map<String, String> map) {
		dao.update_nickname(map);
	}

	public void deleteAll(MemberVO vo) {
		dao.deleteAll(vo);
	}

	public void deleteLikesAll(MemberVO vo) {
		dao.deleteLikesAll(vo);
	}
	
	public int m_count(MemberVO vo) {
		return dao.m_count(vo);
	}

	public int b_likes(MemberVO vo2) {
		
		return dao.b_likes(vo2);
	}
	
}