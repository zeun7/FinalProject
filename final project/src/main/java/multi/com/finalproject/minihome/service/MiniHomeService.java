package multi.com.finalproject.minihome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.minihome.model.MiniHomeDAO;
import multi.com.finalproject.minihome.model.MiniHomeVO;

@Slf4j
@Service
public class MiniHomeService {
	
	@Autowired
	MiniHomeDAO dao;
	
	public MiniHomeService() {
		log.info("MiniHomeService...");
	}
	
	public MiniHomeVO selectOne(MiniHomeVO vo) {
		return dao.selectOne(vo);
	}
	
	public int update(MiniHomeVO vo) {
		return dao.update(vo);
	}
		
	public void vcountUp(MiniHomeVO vo) {
		dao.vcountUp(vo);
	}
}