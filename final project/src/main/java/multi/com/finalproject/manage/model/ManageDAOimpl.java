package multi.com.finalproject.manage.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.member.model.MemberVO;

@Slf4j
@Repository
public class ManageDAOimpl implements ManageDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<MemberVO> member() {
		log.info("member selectAll()...");
		
		return sqlSession.selectList("M_SELECT_ALL");
	}

	@Override
	public List<BoardVO> board() {
		log.info("board select reported()...");
		
		return sqlSession.selectList("B_SELECT_REPORT");
	}

	@Override
	public List<CommentsVO> comments() {
		log.info("comments select reported()...");
		
		return sqlSession.selectList("C_SELECT_REPORT");
	}

}
