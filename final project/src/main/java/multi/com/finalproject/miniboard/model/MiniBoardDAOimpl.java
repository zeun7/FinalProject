package multi.com.finalproject.miniboard.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MiniBoardDAOimpl implements MiniBoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public MiniBoardDAOimpl() {
		log.info("MiniBoardDAOimpl...");
	}
	
	@Override
	public List<MiniBoardVO> selectAll() {
		log.info("selectAll()....");
		return sqlSession.selectList("DIARY_SELECT_ALL");
	}

	@Override
	public MiniBoardVO selectOne(MiniBoardVO vo) {
		log.info("selectOne(vo)...{}", vo);
		return sqlSession.selectOne("DIARY_SELECT_ONE", vo);
	}

	@Override
	public int insert(MiniBoardVO vo) {
		log.info("insert(vo)...{}", vo);
		return sqlSession.insert("DIARY_INSERT",vo);
	}

}
