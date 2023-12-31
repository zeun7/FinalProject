package multi.com.finalproject.comments.model;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.member.model.MemberVO;

public interface CommentsDAO {
		
		public List<CommentsVO> selectAll(CommentsVO vo);

		public List<CommentsVO> cc_selectAll(CommentsVO vo);

		public int insert(CommentsVO vo);

		public int update(CommentsVO vo);
		
		public int delete(CommentsVO vo);

		public int report(Map<String, Object> map);

		public ClikesVO is_clike(ClikesVO vo);

		public int count_clikes(ClikesVO vo);

		public int clike(ClikesVO vo);

		public int cancel_clike(ClikesVO vo);

		public void update_nickname(Map<String, String> map);

		public int deleteAll(BoardVO vo2);

		public void deleteClikesAll(MemberVO vo);

		public void deleteWriter(MemberVO vo);

}