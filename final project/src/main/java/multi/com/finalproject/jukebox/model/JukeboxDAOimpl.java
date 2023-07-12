package multi.com.finalproject.jukebox.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minihome.model.JukeboxVO;

@Repository
@Slf4j
public class JukeboxDAOimpl implements JukeboxDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public int pcountUp(MemberVO vo) {
		log.info("pcountUp()...{}", vo);

		return sqlSession.update("PCOUNT_UP", vo);
	}

	@Override
	public int count() {
		log.info("count()...");

		return sqlSession.selectOne("MP_COUNT");
	}

	@Override
	public List<JukeboxVO> selectAll(int page) {
		log.info("selectAll()...{}", page);

		return sqlSession.selectList("MP_SELECT_ALL", page);
	}

	@Override
	public MemberVO peachCount(MemberVO vo) {
		log.info("peachCount()...{}", vo);

		return sqlSession.selectOne("MP_SELECT_PEACHCOUNT", vo);
	}

	@Override
	public void pcountDown(MemberVO vo) {
		log.info("pcountDown()...{}", vo);

		sqlSession.update("PCOUNT_DOWN", vo);
	}

	@Override
	public int insert(JukeboxVO jvo) {
		log.info("insert()...{}", jvo);

		return sqlSession.insert("J_INSERT", jvo);
	}

	@Override
	public JukeboxVO jukebox_check(JukeboxVO vo) {
		log.info("jukebox_check()...{}", vo);

		return sqlSession.selectOne("J_SELECT_ONE", vo);
	}

}