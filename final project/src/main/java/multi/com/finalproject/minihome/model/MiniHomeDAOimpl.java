package multi.com.finalproject.minihome.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;

@Slf4j
@Repository
public class MiniHomeDAOimpl implements MiniHomeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public MiniHomeDAOimpl() {
		log.info("MiniHomeDAOimpl...");
	}
	
	@Override
	public MiniHomeVO selectOne(MiniHomeVO vo) {
		log.info("selectOne(vo)...{}", vo);
		return sqlSession.selectOne("MINI_SELECT_ONE", vo);
	}
	
	@Override
	public int update(MiniHomeVO vo) {
		log.info("update(vo)...{}", vo);
		return sqlSession.update("MINI_UPDATE",vo);
	}

	@Override
	public MemberVO selectNickPic(MemberVO vo) {
		log.info("selectNickPic(MemberVO vo)...{}", vo);
		if(vo.getNickname() == null) {
			return sqlSession.selectOne("SELECT_NICK_PIC", vo);
		}else{
			return sqlSession.selectOne("SELECT_PIC", vo);
		}
	}

	@Override
	public void view_update(MiniHomeVO vo2) {
		log.info("update(vo2)...{}", vo2);
		sqlSession.update("VIEW_UPDATE",vo2);
	}

	@Override
	public int hasVisitedToday(VisitHistoryVO v_vo) {
		log.info("hasVisitedToday(v_vo)...{}", v_vo);
		return sqlSession.selectOne("HAS_VISITED_TODAY", v_vo);
	}

	@Override
	public void vcountUp(MiniHomeVO vo) {
		log.info("vcountUp(vo)...{}", vo);
		sqlSession.update("VCOUNT_UP", vo);
	}

	@Override
	public void addVisitHistory(VisitHistoryVO v_vo) {
		log.info("addVisitHistory(v_vo)...{}", v_vo);
		sqlSession.insert("ADD_VISIT_HISTORY", v_vo);
	}

	@Override
	public void resetVTodayForALL() {
		sqlSession.update("RESET_VTODAY_ALL");
	}

	@Override
	public MiniHomeVO getRandomMiniHome() {
		log.info("getRandomMiniHome()...");
		return sqlSession.selectOne("RANDOM_MINI_HOME");
	}

}