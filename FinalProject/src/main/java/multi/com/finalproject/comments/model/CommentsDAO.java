package multi.com.finalproject.comments.model;

import java.util.List;

public interface CommentsDAO {
	
	List<CommentsVO> selectAll(CommentsVO vo);

	public int insert(CommentsVO vo);

	public int update(CommentsVO vo);
	
	public int delete(CommentsVO vo);
	
}
