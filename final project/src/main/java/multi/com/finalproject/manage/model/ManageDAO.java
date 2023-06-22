package multi.com.finalproject.manage.model;

import java.util.List;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.member.model.MemberVO;

public interface ManageDAO {

	public List<MemberVO> member();

	public List<BoardVO> board();

	public List<CommentsVO> comments();

}
