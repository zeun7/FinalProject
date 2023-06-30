package multi.com.finalproject.member.model;

import java.sql.Date;
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

	public String find_pw_tel(String tel) throws Exception;

	public int update_pw(MemberVO member) throws Exception;

	public String find_id_tel(String tel) throws Exception;

//	// 로그인 유지 처리
//	public void keepLogin(String id, String sessionId, Date sessionLimit) throws Exception;
//
//	// 세션키 검증
//	public MemberVO checkUserWithSessionKey(String value) throws Exception;

    
    // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(String id, String sessionId, Date next);
     
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public MemberVO checkUserWithSessionKey(String sessionId);
     
}


