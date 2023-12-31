package multi.com.finalproject.board.model;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.member.model.MemberVO;

public interface BoardDAO {

	public List<BoardVO> selectAll(Map<String, Object> map);

	public BoardVO selectOne(BoardVO vo);

	public List<BoardVO> searchList(Map<String, Object> map);

	public void vcountUp(BoardVO vo);

	public int insert(BoardVO vo);

	public int update(BoardVO vo);

	public int delete(BoardVO vo);
	
	public int like(LikesVO vo);
	
	public int report(Map<String, Object> map);

	public int count(BoardVO vo);

	public void likesUp(BoardVO vo);

	public int searchCount(Map<String, Object> map);

	public int deleteLike(LikesVO vo);

	public void likesDown(BoardVO vo);

	public LikesVO likeCheck(LikesVO vo);

	public void update_nickname(Map<String, String> map);

	public void deleteAll(MemberVO vo);

	public void deleteLikesAll(MemberVO vo);
	
	public int m_count(MemberVO vo);

	public int b_likes(MemberVO vo2);

}