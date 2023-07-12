package multi.com.finalproject.minihome.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minihome.model.GameVO;
import multi.com.finalproject.minihome.model.JukeboxVO;
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
	
	public void insert(MemberVO vo) {
		dao.insert(vo);
	}
	
	public MiniHomeVO selectOne(MiniHomeVO vo) {
		return dao.selectOne(vo);
	}
	
	public int update(MiniHomeVO vo) {
		return dao.update(vo);
	}

	public MemberVO selectNickPic(MemberVO vo) {
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

	public int count(JukeboxVO vo) {
		return dao.count(vo);
	}

	public List<JukeboxVO> j_selectAll(Map<String, Object> map) {
		return dao.j_selectAll(map);
	}

	public JukeboxVO bgm_selectOne(JukeboxVO vo) {
		return dao.bgm_selectOnce(vo);
	}

	public void delete(MemberVO vo) {
		dao.delete(vo);
	}
	
	public int record_insert(GameVO vo) {
		return dao.record_insert(vo);
	}

	public List<GameVO> record_selectAll() {
		return dao.record_selectAll();
	}

	public List<GameVO> record_selectAll_today() {
		return dao.record_selectAll_today();
	}

	public GameVO record_selectOne(GameVO vo) {
		return dao.record_selectOne(vo);
	}

}