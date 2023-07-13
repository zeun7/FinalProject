package multi.com.finalproject.miniboard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.LikesVO;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.miniboard.model.MiniBoardDAO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

@Slf4j
@Service
public class MiniBoardService {
	@Autowired
	MiniBoardDAO dao;
	
	public MiniBoardService() {
		log.info("MiniBoardService...");
	}
	
	public List<MiniBoardVO> mb_selectAll(Map<String, Object> map) {
		return dao.mb_selectAll(map);
	}
	
	public MiniBoardVO mb_selectOne(MiniBoardVO vo) {
		return dao.mb_selectOne(vo);
	}

	public int mb_insert(MiniBoardVO vo) {
		return dao.mb_insert(vo);
	}
	
	public int diary_update(MiniBoardVO vo) {
		return dao.diary_update(vo);
	}

	public int mb_delete(MiniBoardVO vo) {
		return dao.mb_delete(vo);
	}

	public int gallery_update(MiniBoardVO vo) {
		return dao.gallery_update(vo);
	}

	public int count(MiniBoardVO vo) {
		return dao.count(vo);
	}
	
	public LikesVO likeCheck(LikesVO vo) {
		return dao.likeCheck(vo);
	}

	public int like(LikesVO vo) {
		return dao.like(vo);
	}

	public void likesUp(MiniBoardVO vo) {
		dao.likesUp(vo);
	}

	public int deleteLike(LikesVO vo) {
		return dao.deleteLike(vo);
	}

	public void likesDown(MiniBoardVO vo) {
		dao.likesDown(vo);
	}

	public int report(Map<String, Object> map) {
		return dao.report(map);
	}

	public MiniBoardVO newest_diary(MiniBoardVO vo) {
		return dao.newest_diary(vo);
	}

	public MiniBoardVO newest_gallery(MiniBoardVO vo) {
		return dao.newest_gallery(vo);
	}
	
	public void vcountUp(MiniBoardVO vo) {
		dao.vcountUp(vo);
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

}