package multi.com.finalproject.minihome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minihome.model.MiniHomeDAO;
import multi.com.finalproject.minihome.model.MiniHomeVO;
import multi.com.finalproject.minihome.model.VisitHistoryVO;

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

	public MemberVO selectNickPic(MiniHomeVO vo) {
		return dao.selectNickPic(vo);
	}

	public void view_update(MiniHomeVO vo2) {
		dao.view_update(vo2);
	}

	public int hasVisitedToday(VisitHistoryVO v_vo) {
		return dao.hasVisitedToday(v_vo);
	}

	public void vcountUp(MiniHomeVO vo) {
		dao.vcountUp(vo);
	}

	public void addVisitHistory(VisitHistoryVO v_vo) {
		dao.addVisitHistory(v_vo);
	}

	public void resetVTodayForAll() {
		dao.resetVTodayForALL();
	}

	public MiniHomeVO getRandomMiniHome() {
		return dao.getRandomMiniHome();
	}

}