package multi.com.finalproject.manage.model;

import java.util.List;

import multi.com.finalproject.member.model.MemberVO;

public interface ManageDAO {
	
	public List<FriendsVO> friends(FriendsVO vo);

	public List<MemberVO> searchUser(MemberVO vo, String searchWord);
	
	public int addfriend(MemberVO vo, MemberVO vo2);
	
	public List<MemberVO> member(Integer page);

	public List<ReportVO> board();
	
	public List<ReportVO> comments();

	public int delfriend(MemberVO vo, MemberVO vo2);

	public int addBan(MemberVO vo, MemberVO vo2);

	public List<FriendsVO> selectBan(FriendsVO vo);

	public int delBan(MemberVO vo, MemberVO vo2);

	public int newBan(MemberVO vo, MemberVO vo2);

	public int mcount();

	public int bcount();

	public int ccount();

	public int del_b_report(ReportVO vo);
	
	public int del_c_report(ReportVO vo);

	public int mclass(MemberVO vo);

	public int grade(FriendsVO vo);

	public int del_board(ReportVO vo);

	public int del_comments(ReportVO vo);
	
	public List<ReportVO> minicomments();

	public ReportVO select_report(ReportVO vo);
	
	public List<FriendsVO> ilchon_selectAll(MemberVO m_attr);
}
