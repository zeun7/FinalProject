package multi.com.finalproject.minihome.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

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
		MiniHomeVO vo2 = sqlSession.selectOne("MINI_SELECT_ONE", vo);
		log.info("{}", vo2);
		return vo2;
	}
	
	@Override
	public int update(MiniHomeVO vo) {
		log.info("update(vo)...{}", vo);
		return sqlSession.update("MINI_UPDATE",vo);
	}


}
