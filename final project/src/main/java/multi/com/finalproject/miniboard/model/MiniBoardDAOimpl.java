package multi.com.finalproject.miniboard.model;

import java.util.List;
import java.util.Map;

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
	public List<MiniBoardVO> mb_selectAll(Map<String, Object> map) {
		log.info("selectAll()...{}", map);
		return sqlSession.selectList("MB_SELECT_ALL", map);
	}
	
	@Override
	public MiniBoardVO mb_selectOne(MiniBoardVO vo) {
		log.info("mb_selectOne(vo)...{}", vo);
		return sqlSession.selectOne("MB_SELECT_ONE", vo);
	}

	@Override
	public int mb_insert(MiniBoardVO vo) {
		log.info("mb_insert(vo)...{}", vo);
		return sqlSession.insert("MB_INSERT",vo);
	}
	
	@Override
	public int diary_update(MiniBoardVO vo) {
		log.info("diary_update(vo)...{}", vo);
		int flag = sqlSession.update("DIARY_UPDATE",vo);
		return flag;
	}

	@Override
	public int gallery_update(MiniBoardVO vo) {
		log.info("gallery_update(vo)...{}", vo);
		return sqlSession.insert("GALLERY_UPDATE",vo);
	}
	
	@Override
	public int mb_delete(MiniBoardVO vo) {
		log.info("mb_delete(vo)...{}", vo);
		return sqlSession.delete("MB_DELETE",vo);
	}
	
	@Override
	public List<MiniBoardVO> mongo_findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public int mongo_insert(MiniBoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int mongo_update(MiniBoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int mongo_delete(MiniBoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int count(MiniBoardVO vo) {
		log.info("count(vo)...{}", vo);
		return sqlSession.selectOne("MB_COUNT", vo);
	}

	

	

}