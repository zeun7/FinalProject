package multi.com.finalproject.manage.model;

import java.util.List;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.member.model.MemberVO;

public interface ManageDAO {
	
	public List<ManageFriendsVO> friends(ManageFriendsVO vo);

	public List<MemberVO> searchUser(MemberVO vo, String searchWord);
	
	public int addfriend(MemberVO vo, MemberVO vo2);
	
	public List<MemberVO> member();

	public List<BoardVO> board();

	public List<CommentsVO> comments();

	public int delfriend(MemberVO vo, MemberVO vo2);

	public int addBan(MemberVO vo, MemberVO vo2);

	public List<ManageFriendsVO> selectBan(ManageFriendsVO vo);

	public int delBan(MemberVO vo, MemberVO vo2);

	public int newBan(MemberVO vo, MemberVO vo2);

}
