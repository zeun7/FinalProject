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
		return sqlSession.selectList("MB_SELECT_ALL");
	}

	@Override
	public MiniBoardVO diary_selectOne(MiniBoardVO vo) {
		log.info("diary_selectOne(vo)...{}", vo);
		return sqlSession.selectOne("DIARY_SELECT_ONE", vo);
	}

	@Override
	public int insert(MiniBoardVO vo) {
		log.info("insert(vo)...{}", vo);
		return sqlSession.insert("MB_INSERT",vo);
	}
	
	@Override
	public int diary_update(MiniBoardVO vo) {
		log.info("diary_update(vo)...{}", vo);
		log.info("bfile: {}", vo.getBfile().toString());
		log.info("filepath: {}", vo.getFilepath().toString());
		int flag = sqlSession.insert("DIARY_UPDATE",vo);
		return flag;
	}

	@Override
	public int diary_delete(MiniBoardVO vo) {
		log.info("diary_delete(vo)...{}", vo);
		return sqlSession.insert("DIARY_DELETE",vo);
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
	public MiniBoardVO gallery_selectOne(MiniBoardVO vo) {
		log.info("gallery_selectOne(vo)...{}", vo);
		return sqlSession.selectOne("GALLERY_SELECT_ONE", vo);
	}

	@Override
	public int gallery_update(MiniBoardVO vo) {
		log.info("gallery_update(vo)...{}", vo);
		return sqlSession.insert("GALLERY_UPDATE",vo);
	}

	@Override
	public int gallery_delete(MiniBoardVO vo) {
		log.info("gallery_delete(vo)...{}", vo);
		return sqlSession.insert("GALLERY_DELETE",vo);
	}

}