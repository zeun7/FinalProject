package multi.com.finalproject.member.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
	
//	public String find_pw(String email) throws Exception;
//
//	public String find_pw_tel(String tel) throws Exception;

	public String find_id_tel(String tel) throws Exception;

	public MemberVO TelCheck( MemberVO vo);

	public int pwUdate_M(MemberVO vo);

	public MemberVO selectMember(String email);

	public String find_pw(MemberVO vo, HttpServletResponse response);

	public int update_pw(MemberVO vo) throws Exception;

	public void pass_change(MemberVO vo) throws Exception;

	public MemberVO find_user(MemberVO vo);
    
 
}