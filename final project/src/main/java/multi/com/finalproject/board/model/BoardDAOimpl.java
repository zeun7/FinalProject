package multi.com.finalproject.board.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.comments.service.CommentsService;
import multi.com.finalproject.manage.model.FriendsVO;
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
		
		List<BoardVO> vos = sqlSession.selectList("B_SELECT_ALL", map);
		List<BoardVO> vos2 = new ArrayList<BoardVO>();
		
		String nickname = (String)map.get("watcher");
		
		List<FriendsVO> ban_vos = sqlSession.selectList("MNG_M_SELECT_BAN", nickname);	// 내가 차단 한 상대
		List<FriendsVO> banned_vos = sqlSession.selectList("MNG_M_SELECT_BANNED", nickname);	// 나를 차단 한 상대
		
		boolean isBan = false;
		
		for(BoardVO c_vo : vos) {
			isBan = false;
			
			for(FriendsVO ban_vo : ban_vos) {
				if(c_vo.getWriter().equals(ban_vo.getNickname2())) {	// 내가 차단 한 상대
					isBan = true;
				}
				
			}
			
			for(FriendsVO banned_vo : banned_vos) {
				if(c_vo.getWriter().equals(banned_vo.getNickname())) {	// 나를 차단 한 상대
					isBan = true;
				}
			}
			
			if(!isBan) {	// 차단이 아닌 경우
				vos2.add(c_vo);
			}
		}
		
		return vos2;
	}

	@Override
	public BoardVO selectOne(BoardVO vo) {
		log.info("selectOne()...{}", vo);

		return sqlSession.selectOne("B_SELECT_ONE", vo);
	}

	@Override
	public List<BoardVO> searchList(Map<String, Object> map) {
		log.info("searchList...{}", map);
		
		List<BoardVO> vos = new ArrayList<BoardVO>();
		List<BoardVO> vos2 = new ArrayList<BoardVO>();
		
		String nickname = (String)map.get("watcher");
		
		List<FriendsVO> ban_vos = sqlSession.selectList("MNG_M_SELECT_BAN", nickname);	// 내가 차단 한 상대
		List<FriendsVO> banned_vos = sqlSession.selectList("MNG_M_SELECT_BANNED", nickname);	// 나를 차단 한 상대
		
		boolean isBan = false;
		
		if (map.get("searchKey").toString().equals("title")) {
			vos = sqlSession.selectList("B_SEARCH_LIST_TITLE", map);
		} else if (map.get("searchKey").toString().equals("content")) {
			vos = sqlSession.selectList("B_SEARCH_LIST_CONTENT", map);
		} else {
			vos = sqlSession.selectList("B_SEARCH_LIST_WRITER", map);
		}
		
		for(BoardVO c_vo : vos) {
			isBan = false;
			
			for(FriendsVO ban_vo : ban_vos) {
				if(c_vo.getWriter().equals(ban_vo.getNickname2())) {	// 내가 차단 한 상대
					isBan = true;
				}
				
			}
			
			for(FriendsVO banned_vo : banned_vos) {
				if(c_vo.getWriter().equals(banned_vo.getNickname())) {	// 나를 차단 한 상대
					isBan = true;
				}
			}
			
			if(!isBan) {	// 차단이 아닌 경우
				vos2.add(c_vo);
			}
		}
		
		return vos2;
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

		List<BoardVO> vos = new ArrayList<BoardVO>();
		List<BoardVO> vos2 = new ArrayList<BoardVO>();
		
		String nickname = (String)map.get("watcher");
		
		List<FriendsVO> ban_vos = sqlSession.selectList("MNG_M_SELECT_BAN", nickname);	// 내가 차단 한 상대
		List<FriendsVO> banned_vos = sqlSession.selectList("MNG_M_SELECT_BANNED", nickname);	// 나를 차단 한 상대
		
		boolean isBan = false;
		
		if (map.get("searchKey").toString().equals("title")) {
			vos = sqlSession.selectList("B_SEARCH_LIST_TITLE_ALL", map);
		} else if (map.get("searchKey").toString().equals("content")) {
			vos = sqlSession.selectList("B_SEARCH_LIST_CONTENT_ALL", map);
		} else {
			vos = sqlSession.selectList("B_SEARCH_LIST_WRITER_ALL", map);
		}
		
		for(BoardVO c_vo : vos) {
			isBan = false;
			
			for(FriendsVO ban_vo : ban_vos) {
				if(c_vo.getWriter().equals(ban_vo.getNickname2())) {	// 내가 차단 한 상대
					isBan = true;
				}
				
			}
			
			for(FriendsVO banned_vo : banned_vos) {
				if(c_vo.getWriter().equals(banned_vo.getNickname())) {	// 나를 차단 한 상대
					isBan = true;
				}
			}
			
			if(!isBan) {	// 차단이 아닌 경우
				vos2.add(c_vo);
			}
		}
		
		return vos2.size();
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
	
	@Override
	public int m_count(MemberVO vo) {
		log.info("m_count..{}",vo);
		return sqlSession.selectOne("B_COUNT_BY_WRITER", vo);
	}

	@Override
	public int b_likes(MemberVO vo2) {
		log.info("b_likes..{}",vo2);
	int count = 0;
		
		List <BoardVO> vos=  sqlSession.selectList("B_SEARCH_ALL_WRITER", vo2);
		for(BoardVO vo: vos ) {
			count += vo.getLikes(); 
		}
		return count;
	}

}