package multi.com.finalproject.comments.model;

import java.util.List;

public interface CommentsDAO {
		
		public List<CommentsVO> selectAll(CommentsVO vo);

		public List<CommentsVO> cc_selectAll(CommentsVO vo);

		public int insert(CommentsVO vo);

		public int update(CommentsVO vo);
		
		public int delete(CommentsVO vo);

		public List<CommentsVO> findByBnum(Long bNum);
}