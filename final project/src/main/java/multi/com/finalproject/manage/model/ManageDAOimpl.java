package multi.com.finalproject.manage.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<ManageFriendsVO> friends(ManageFriendsVO vo) {
		log.info("friends()...{}", vo);
		
		return sqlSession.selectList("MNG_FRIENDS",vo);
	}

	@Override
	public List<MemberVO> searchUser(MemberVO vo, String searchWord) {
		log.info("searchUser()...{}", searchWord);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", vo.getNickname());
		map.put("searchWord", "%"+searchWord+"%");
		log.info("{}", map);
		
		return sqlSession.selectList("MNG_SEARCH_LIST_NICKNAME", map);
	}
	
	@Override
	public int addfriend(MemberVO vo, MemberVO vo2) {
		log.info("addfriend()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		int result = sqlSession.insert("MNG_ADD_FRIEND",map);
		
		return result;
	}
	
	@Override
	public List<MemberVO> member() {
		log.info("member selectAll()...");
		
		return sqlSession.selectList("M_SELECT_ALL");
	}

	@Override
	public List<BoardVO> board() {
		log.info("board select reported()...");
		
		return sqlSession.selectList("MNG_B_SELECT_REPORT");
	}

	@Override
	public List<CommentsVO> comments() {
		log.info("comments select reported()...");
		
		return sqlSession.selectList("MNG_C_SELECT_REPORT");
	}

}
