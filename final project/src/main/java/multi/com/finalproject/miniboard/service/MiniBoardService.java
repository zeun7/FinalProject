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
	
	public List<MiniBoardVO> selectAll() {
		return dao.selectAll();
	}

	public MiniBoardVO selectOne(MiniBoardVO vo) {
		return dao.selectOne(vo);
	}

	public int insert(MiniBoardVO vo) {
		return dao.insert(vo);
	}

}
