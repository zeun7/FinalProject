package multi.com.finalproject.comments.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.member.model.MemberVO;

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
		
		int del_clike_result = sqlSession.delete("C_DEL_CLIKE", vo);	// 좋아요 삭제
		int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_CNUM", vo);	// 신고 삭제
		
		log.info("delete clike result: {}", del_clike_result);
		log.info("delete report result: {}", del_report_result);
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

	@Override
	public int deleteAll(BoardVO vo2) {
		log.info("delete All()...{}", vo2);
		
		List<CommentsVO> vos = sqlSession.selectList("C_SELECT_ALL2", vo2);	// bnum으로 댓글 찾기
		
		for(CommentsVO vo : vos) {
			int del_clike_result = sqlSession.delete("C_DEL_CLIKE", vo);	// cnum으로 댓글 좋아요 삭제
			int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_CNUM", vo);	// cnum 댓글 신고 삭제
			
			log.info("delete clike result: {}", del_clike_result);
			log.info("deletet report result: {}", del_report_result);
		}
		
		return sqlSession.delete("C_DELETE_ALL", vo2);	// bnum으로 댓글 삭제
	}

	@Override
	public void deleteClikesAll(MemberVO vo) {
		log.info("delete clikes All()...{}", vo);
		
		int result = sqlSession.delete("C_DEL_CLIKE_ID", vo);	// id로 댓글 좋아요 모두 삭제
		log.info("result: {}", result);
	}

	@Override
	public void deleteWriter(MemberVO vo) {
		log.info("delete comments by writer()...{}", vo);
		
		List<CommentsVO> vos = sqlSession.selectList("C_SEARCH_LIST_WRITER", vo);	// writer로 댓글 찾기
		
		for(CommentsVO vo2 : vos) {
			if(vo2.getCcnum() != 0) {	// 대댓글일 경우
				delete(vo2);
			}
			
			int del_clike_result = sqlSession.delete("C_DEL_CLIKE", vo2);	// cnum으로 댓글 좋아요 삭제
			int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_CNUM", vo2); // cnum으로 신고 삭제
			int del_result = sqlSession.delete("C_DELETE", vo2);			// cnum으로 댓글 삭제
			log.info("delete clike result: {}", del_clike_result);
			log.info("delete report result: {}", del_report_result);
			log.info("delete result: {}", del_result);
		}
	}
}