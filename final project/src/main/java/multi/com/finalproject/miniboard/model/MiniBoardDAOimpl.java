package multi.com.finalproject.miniboard.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.LikesVO;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minicomments.model.MiniCommentsVO;
import multi.com.finalproject.minicomments.service.MiniCommentsService;

@Slf4j
@Repository
public class MiniBoardDAOimpl implements MiniBoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	MiniCommentsService minicomments_service;
	
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
		
		int del_like_result = sqlSession.delete("MB_DELETE_LIKE_ALL", vo);	// 게시글 좋아요 삭제
		int del_comm_result = minicomments_service.deleteAll(vo);			// 댓글 삭제
		int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_MBNUM", vo); // 게시글 신고 삭제
		
		log.info("miniboard delete like result: {}", del_like_result);
		log.info("minicomments delete result: {}", del_comm_result);
		log.info("miniboard delete report result: {}", del_report_result);
		
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

	@Override
	public void deleteAll(MemberVO vo) {
		log.info("delete miniboard all()...{}", vo);
		
		List<MiniBoardVO> vos = sqlSession.selectList("MB_SEARCH_LIST_WRITER", vo);	// nickname으로 게시글 찾기
		
		for (MiniBoardVO vo2 : vos) {
			int del_like_result = sqlSession.delete("MB_DELETE_LIKE_ALL", vo2);	// mbnum으로 게시글 좋아요 삭제
			int del_report_result = sqlSession.delete("MNG_DEL_REPORT_BY_MBNUM", vo2); // mbnum으로 게시글 신고 삭제
			int del_comm_result = minicomments_service.deleteAll(vo2);			// mbnum으로 댓글 삭제
			
			log.info("miniboard delete like result: {}", del_like_result);
			log.info("miniboard delete report result: {}", del_report_result);
			log.info("minicomments delete result: {}", del_comm_result);
		}
		
		int result = sqlSession.delete("MB_DELETE_ALL", vo);		// nickname으로 게시글 모두 삭제
		log.info("result: {}", result);
	}

	@Override
	public void deleteLikesAll(MemberVO vo) {
		log.info("delete miniboard likes()...{}", vo);
		
		int result = sqlSession.delete("MB_DELETE_LIKE_ID", vo);	// id로 좋아요 모두 삭제
		log.info("result: {}", result);
	}

	@Override
	public int m_count2(MemberVO vo) {
		log.info("vo: {}", vo);
		return sqlSession.insert("MB_COUNT_BY_NICKNAME", vo);
	}

	@Override
	public int mb_likes(MemberVO vo2) {
		log.info("mb_likes: {}", vo2);
	int count = 0;
		 List<MiniBoardVO> vos =sqlSession.selectList("MB_SEARCH_LIST_WRITER", vo2);
		 for(MiniBoardVO vo:vos) {
			 count += vo.getLikes();
		 }
		 return count;
	}

}