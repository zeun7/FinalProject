package multi.com.finalproject.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class BoardDAOimpl implements BoardDAO {

	@Autowired
	SqlSession sqlSession;
	
	public BoardDAOimpl() {
		log.info("BoardDAOimpl()...");
	}
	
	@Override
	public List<BoardVO> selectAll(Map<String, Object> map) {
		log.info("selectAll()...{}", map);

		return sqlSession.selectList("B_SELECT_ALL", map);
	}

	@Override
	public BoardVO selectOne(BoardVO vo) {
		log.info("selectOne()...{}", vo);
		
		return sqlSession.selectOne("B_SELECT_ONE", vo);
	}

	@Override
	public List<BoardVO> searchList(Map<String, Object> map) {
		log.info("searchList...{}", map);
		
		if(map.get("searchKey").toString().equals("title")) {
			return sqlSession.selectList("B_SEARCH_LIST_TITLE", map);
		}else if(map.get("searchKey").toString().equals("content")) {
			return sqlSession.selectList("B_SEARCH_LIST_CONTENT", map);
		}else {
			return sqlSession.selectList("B_SEARCH_LIST_WRITER", map);
		}
	}

	@Override
	public void vcountUp(BoardVO vo) {
		log.info("vcountUp()...{}", vo);

		sqlSession.update("B_VCOUNT_UP", vo);
	}

	@Override
	public int insert(BoardVO vo) {
		log.info("insert()...{}", vo);
		
		return sqlSession.insert("B_INSERT", vo);
	}

	@Override
	public int update(BoardVO vo) {
		log.info("update()...{}", vo);
		
		return sqlSession.update("B_UPDATE", vo);
	}

	@Override
	public int delete(BoardVO vo) {
		log.info("delete()...{}", vo);
		
		return sqlSession.delete("B_DELETE", vo);
	}

	@Override
	public int like(Map<String, Integer> param) {
		log.info("like()...{}", param);
		
		return sqlSession.insert("B_LIKE", param);
	}

	@Override
	public int report(BoardVO vo) {
		log.info("report()...{}", vo);
		return 0;
	}

	@Override
	public int count(BoardVO vo) {
		log.info("count()...{}", vo);
		
		return sqlSession.selectOne("B_COUNT", vo);
	}

}