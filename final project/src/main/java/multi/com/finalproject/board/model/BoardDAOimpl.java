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
		return null;
	}

	@Override
	public List<BoardVO> searchList(String searchKey, String searchWord) {
		log.info("searchList()...");
		log.info("searchKey:{}", searchKey);
		log.info("searchWord:{}", searchWord);
		return null;
	}

	@Override
	public void vcountUp(BoardVO vo) {
		log.info("vcountUp()...{}", vo);

	}

	@Override
	public int insert(BoardVO vo) {
		log.info("insert()...{}", vo);
		return 0;
	}

	@Override
	public int update(BoardVO vo) {
		log.info("update()...{}", vo);
		return 0;
	}

	@Override
	public int delete(BoardVO vo) {
		log.info("delete()...{}", vo);
		return 0;
	}

	@Override
	public int like(BoardVO vo) {
		log.info("like()...{}", vo);
		return 0;
	}

	@Override
	public int report(BoardVO vo) {
		log.info("report()...{}", vo);
		return 0;
	}

}
