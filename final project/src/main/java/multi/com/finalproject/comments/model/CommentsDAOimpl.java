package multi.com.finalproject.comments.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class CommentsDAOimpl implements CommentsDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public CommentsDAOimpl() {
		log.info("CommentsDAOimpl()...");
	}
	
	@Override
	public List<CommentsVO> selectAll(CommentsVO vo) {
		log.info("selectAll()...{}", vo.getBnum());
		
		return sqlSession.selectList("C_SELECT_ALL", vo);
	}
	
	@Override
	public List<CommentsVO> cc_selectAll(CommentsVO vo) {
		log.info("cc_selectAll()...{}", vo.getCnum());
		return sqlSession.selectList("CC_SELECT_ALL", vo);
	}
	
	@Override
	public int insert(CommentsVO vo) {
		log.info("insert()...{}",vo);
		
		if(vo.getCcnum() == 0) {	// 댓글 작성
			return sqlSession.update("C_INSERT",vo);
		}
		else {					// 대댓글 작성
			return sqlSession.update("CC_INSERT", vo);
		}
	}

	@Override
	public int update(CommentsVO vo) {
		log.info("update()...{}",vo);
		
		return sqlSession.update("C_UPDATE",vo);
	}

	@Override
	public int delete(CommentsVO vo) {
		log.info("delete()...{}",vo);
		
		return sqlSession.delete("C_DELETE",vo);
	}

	@Override
	public int report(Map<String, Object> map) {
		log.info("report()...{}", map);
		
		sqlSession.update("C_UPDATE_REPORT", map);
		return sqlSession.insert("C_REPORT", map);
	}

	@Override
	public ClikesVO is_clike(ClikesVO vo) {
		log.info("check clike...{}", vo);
		
		return sqlSession.selectOne("C_IS_CLIKE", vo);
	}

	@Override
	public int count_clikes(ClikesVO vo) {
		log.info("count clikes...{}", vo);
		
		return sqlSession.selectOne("C_COUNT_CLIKES", vo);
	}

	@Override
	public int clike(ClikesVO vo) {
		log.info("clike...{}", vo);
		
		return sqlSession.insert("C_CLIKE", vo);
	}

	@Override
	public int cancel_clike(ClikesVO vo) {
		log.info("cancel clike...{}", vo);
		
		return sqlSession.delete("C_CANCEL_CLIKE", vo);
	}

	@Override
	public void update_nickname(Map<String, String> map) {
		log.info("update nickname()...{}", map);
		
		int result = sqlSession.update("C_UPDATE_NICKNAME", map);
		log.info("result: {}", result);
	}


}