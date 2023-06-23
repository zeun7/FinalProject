package multi.com.finalproject.member.model;

import java.util.List;

public interface MemberDAO {

	public int insert(MemberVO vo);

	public int update(MemberVO vo);

	public int delete(MemberVO vo);

	public List<MemberVO> selectAll();

	public MemberVO selectOne(MemberVO vo);

	public MemberVO login(MemberVO vo);

	public List<MemberVO> searchList(String searchKey, String searchWord);

	public MemberVO idCheck(MemberVO vo);

	public MemberVO NickCheck(MemberVO vo);
	
	public String find_id(String email) throws Exception;
	
	public String find_pw(String email) throws Exception;

	public int update_pw(MemberVO member) throws Exception;

	public List<MemberVO> friends(MemberVO vo);

	public List<MemberVO> searchUser(MemberVO vo, String searchWord);
	
	public int addfriend(MemberVO vo, MemberVO vo2);
}
