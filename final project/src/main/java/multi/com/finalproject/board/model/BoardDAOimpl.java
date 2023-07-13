package multi.com.finalproject.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.service.CommentsService;
import multi.com.finalproject.member.model.MemberVO;

@Repository
@Slf4j
public class BoardDAOimpl implements BoardDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	CommentsService comments_service;

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

		if (map.get("searchKey").toString().equals("title")) {
			return sqlSession.selectList("B_SEARCH_LIST_TITLE", map);
		} else if (map.get("searchKey").toString().equals("content")) {
			return sqlSession.selectList("B_SEARCH_LIST_CONTENT", map);
		} else {
			return sqlSession.selectList("B_SEARCH_LIST_WRITER", map);
		}
	}

	@Override
	public void vcountUp(BoardVO vo) {
		log.info("vcountUp()...{}", vo);

		sqlSession.update("B_VCOUNT_UP", vo);
	}

	@Override
	public void likesUp(BoardVO vo) {
		log.info("lcountUp()...{}", vo);

		sqlSession.update("B_LIKES_UP", vo);
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
		
		int del_like_result = sqlSession.delete("B_DELETE_LIKE_ALL", vo);	// 게시글 좋아요 삭제
		int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_BNUM", vo); // 게시글 신고 삭제
		int del_comm_result = comments_service.deleteAll(vo);	// 댓글 삭제
		
		log.info("delete like result: {}", del_like_result);
		log.info("delete report result: {}", del_report_result);
		log.info("delete comments result: {}", del_comm_result);
		
		return sqlSession.delete("B_DELETE", vo);	// 게시글 삭제
	}

	@Override
	public int like(LikesVO vo) {
		log.info("like()...{}", vo);

		return sqlSession.insert("B_LIKE", vo);
	}

	@Override
	public int report(Map<String, Object> map) {
		log.info("report()...{}", map);

		return sqlSession.insert("B_REPORT", map);
	}

	@Override
	public int count(BoardVO vo) {
		log.info("count()...{}", vo);

		return sqlSession.selectOne("B_COUNT", vo);
	}

	@Override
	public int searchCount(Map<String, Object> map) {
		log.info("searchCount()...{}", map);

		if (map.get("searchKey").toString().equals("title")) {
			return sqlSession.selectOne("B_SEARCH_COUNT_TITLE", map);
		} else if (map.get("searchKey").toString().equals("content")) {
			return sqlSession.selectOne("B_SEARCH_COUNT_CONTENT", map);
		} else {
			return sqlSession.selectOne("B_SEARCH_COUNT_WRITER", map);
		}
	}

	@Override
	public int deleteLike(LikesVO vo) {
		log.info("deleteLike()...{}", vo);
		
		return sqlSession.delete("B_DELETE_LIKE", vo);
	}

	@Override
	public void likesDown(BoardVO vo) {
		log.info("likesDown()...{}", vo);
		
		sqlSession.update("B_LIKES_DOWN", vo);
	}

	@Override
	public LikesVO likeCheck(LikesVO vo) {
		log.info("likeCheck()...{}", vo);
		
		return sqlSession.selectOne("B_LIKE_CHECK", vo);
	}

	@Override
	public void update_nickname(Map<String, String> map) {
		log.info("update nickname...{}",  map);
		
		int result = sqlSession.update("B_UPDATE_NICKNAME", map);
		log.info("result: {}", result);
	}

	@Override
	public void deleteAll(MemberVO vo) {
		log.info("delete All()...{}", vo);
		
		List<BoardVO> vos = sqlSession.selectList("B_SEARCH_ALL_WRITER", vo);	// nickname으로 게시글 찾기
		
		for (BoardVO vo2 : vos) {
			int del_like_result = sqlSession.delete("B_DELETE_LIKE_ALL", vo2);	// bnum으로 게시글 좋아요 삭제
			int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_BNUM", vo2); // bnum으로 게시글 신고 삭제
			int del_comm_result = comments_service.deleteAll(vo2);	// 댓글 삭제
			
			log.info("delete like result: {}", del_like_result);
			log.info("delete report result: {}", del_report_result);
			log.info("delete comments result: {}", del_comm_result);
		}
		
		int result = sqlSession.delete("B_DELETE_ALL", vo); // nickname으로 게시글 삭제
		log.info("result: {}", result);
	}

	@Override
	public void deleteLikesAll(MemberVO vo) {
		log.info("delete likes All()...{}", vo);
		
		int result = sqlSession.delete("B_DELETE_LIKE_ID", vo);	// id로 게시글 좋아요 모두 삭제
		log.info("result: {}", result);
	}

}