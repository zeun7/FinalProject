package multi.com.finalproject.miniboard.model;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.board.model.LikesVO;
import multi.com.finalproject.member.model.MemberVO;

public interface MiniBoardDAO {
	
	public List<MiniBoardVO> mb_selectAll(Map<String, Object> map);

	public MiniBoardVO mb_selectOne(MiniBoardVO vo);

	public int mb_insert(MiniBoardVO vo);
	
	public int diary_update(MiniBoardVO vo);

	public int gallery_update(MiniBoardVO vo);
	
	public int mb_delete(MiniBoardVO vo);

	public int count(MiniBoardVO vo);
	
	public LikesVO likeCheck(LikesVO vo);

	public int like(LikesVO vo);

	public void likesUp(MiniBoardVO vo);

	public int deleteLike(LikesVO vo);

	public void likesDown(MiniBoardVO vo);

	public int report(Map<String, Object> map);

	public MiniBoardVO newest_diary(MiniBoardVO vo);

	public MiniBoardVO newest_gallery(MiniBoardVO vo);
	
	public void vcountUp(MiniBoardVO vo);

	public void update_nickname(Map<String, String> map);

	public void deleteAll(MemberVO vo);

	public void deleteLikesAll(MemberVO vo);

	public int m_count2(MemberVO vo);

	public int mb_likes(MemberVO vo2);
	
}