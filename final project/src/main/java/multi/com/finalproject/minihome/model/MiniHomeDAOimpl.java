package multi.com.finalproject.minihome.model;

import java.util.List;
import java.util.Map;

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
	public void insert(MemberVO vo) {
		log.info("insert(vo)...{}", vo);
		sqlSession.insert("MINI_INSERT", vo);
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

	@Override
	public int count(JukeboxVO vo) {
		log.info("count(vo)...{}", vo);
		return sqlSession.selectOne("J_COUNT", vo);
	}

	@Override
	public List<JukeboxVO> j_selectAll(Map<String, Object> map) {
		log.info("j_selectAll(map)...{},{}", map.get("vo"), map.get("page"));
		return sqlSession.selectList("J_SELECT_ALL", map);
	}

	@Override
	public JukeboxVO bgm_selectOnce(JukeboxVO vo) {
		log.info("bgm_selectOne(vo)...{}", vo);
		return sqlSession.selectOne("BGM_SELECT_ONE", vo);
	}

	@Override
	public void delete(MemberVO vo) {
		log.info("delete()...{}", vo);
		
		int result = sqlSession.delete("MH_DELETE", vo);
		log.info("result: {}", result);
	}
	
	@Override
	public int record_insert(GameVO vo) {
		log.info("record_insert(vo)...{}", vo);
		return sqlSession.insert("GAME_RECORD_INSERT", vo);
	}

	@Override
	public List<GameVO> record_selectAll() {
		log.info("record_selectAll()...");
		return sqlSession.selectList("GAME_SELECT_ALL");
	}

	@Override
	public List<GameVO> record_selectAll_today() {
		log.info("record_selectAll_today");
		return sqlSession.selectList("GAME_SELECT_TODAY");
	}

	@Override
	public GameVO record_selectOne(GameVO vo) {
		log.info("record_selectOne(vo)...{}", vo);
		return sqlSession.selectOne("GAME_SELECT_ONE", vo);
	}

}