package multi.com.finalproject.miniboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
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
	
	public List<MiniBoardVO> diary_selectAll() {
		return dao.diary_selectAll();
	}

	public MiniBoardVO diary_selectOne(MiniBoardVO vo) {
		return dao.diary_selectOne(vo);
	}

	public int diary_insert(MiniBoardVO vo) {
		return dao.diary_insert(vo);
	}
	
	public int diary_update(MiniBoardVO vo) {
		return dao.diary_update(vo);
	}

	public int diary_delete(MiniBoardVO vo) {
		return dao.diary_delete(vo);
	}

	public List<MiniBoardVO> mongo_findAll() {
		return dao.mongo_findAll();
	}
	
	public int mongo_insert(MiniBoardVO vo) {
		return dao.mongo_insert(vo);
	}

	public int mongo_update(MiniBoardVO vo) {
		return dao.mongo_update(vo);
	}

	public int mongo_delete(MiniBoardVO vo) {
		return dao.mongo_delete(vo);
	}

	public List<MiniBoardVO> gallery_selectAll() {
		return dao.gallery_selectAll();
	}
	
	public MiniBoardVO gallery_selectOne(MiniBoardVO vo) {
		return dao.gallery_selectOne(vo);
	}
	
	public int gallery_insert(MiniBoardVO vo) {
		return dao.gallery_insert(vo);
	}

	public int gallery_update(MiniBoardVO vo) {
		return dao.gallery_update(vo);
	}

	public int gallery_delete(MiniBoardVO vo) {
		return dao.gallery_delete(vo);
	}

}