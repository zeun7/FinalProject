package multi.com.finalproject.member.model;

import java.util.List;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

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
	
	public MemberVO find_id(MemberVO vo) ;

	public MemberVO TelCheck( MemberVO vo);

	public int pwUdate_M(MemberVO vo);

	public MemberVO selectMember(String email);

	public String find_pw(String email);

	public int update_pw(MemberVO vo) throws Exception;

	public void pass_change(MemberVO vo) throws Exception;

	public MemberVO find_user(MemberVO vo);

	public MemberVO findUser(String email);

	public MemberVO find_id_question(MemberVO vo);
    
	public MiniBoardVO FindMiniBoard(MiniBoardVO vo);

	public BoardVO FindBoard(BoardVO vo2);
 
}