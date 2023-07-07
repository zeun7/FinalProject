package multi.com.finalproject.miniboard.model;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.board.model.LikesVO;

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
	
	
}