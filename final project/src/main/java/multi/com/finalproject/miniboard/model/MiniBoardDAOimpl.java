package multi.com.finalproject.miniboard.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.LikesVO;

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
		log.info("selectAll(map)...{}", map);
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
	public int count(MiniBoardVO vo) {
		log.info("count(vo)...{}", vo);
		return sqlSession.selectOne("MB_COUNT", vo);
	}

	@Override
	public LikesVO likeCheck(LikesVO vo) {
		log.info("likeCheck()...{}", vo);

		return sqlSession.selectOne("MB_LIKE_CHECK", vo);
	}

	@Override
	public int like(LikesVO vo) {
		log.info("like()...{}", vo);

		return sqlSession.insert("MB_LIKE", vo);
	}

	@Override
	public void likesUp(MiniBoardVO vo) {
		log.info("lcountUp()...{}", vo);

		sqlSession.update("MB_LIKES_UP", vo);
	}

	@Override
	public int deleteLike(LikesVO vo) {
		log.info("deleteLike()...{}", vo);

		return sqlSession.delete("MB_DELETE_LIKE", vo);
	}

	@Override
	public void likesDown(MiniBoardVO vo) {
		log.info("likesDown()...{}", vo);

		sqlSession.update("MB_LIKES_DOWN", vo);
	}

	@Override
	public int report(Map<String, Object> map) {
		log.info("report()...{}", map);

		return sqlSession.insert("MB_REPORT", map);
	}

	@Override
	public MiniBoardVO newest_diary(MiniBoardVO vo) {
		log.info("newest_diary(vo)...{}", vo);
		return sqlSession.selectOne("NEWEST_DIARY", vo);
	}

	@Override
	public MiniBoardVO newest_gallery(MiniBoardVO vo) {
		log.info("newest_gallery(vo)...{}", vo);
		return sqlSession.selectOne("NEWEST_GALLERY", vo);
	}
	
	@Override
	public void vcountUp(MiniBoardVO vo) {
		log.info("vcountUp(vo)...{}", vo);
		sqlSession.selectOne("MB_VCOUNT_UP", vo);
	}

	@Override
	public void update_nickname(Map<String, String> map) {
		log.info("update nickname()...{}", map);
		
		int result = sqlSession.update("MB_UPDATE_NICKNAME", map);
		log.info("result: {}", result);
	}

}