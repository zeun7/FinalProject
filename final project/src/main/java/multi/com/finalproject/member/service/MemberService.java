package multi.com.finalproject.member.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.member.model.MemberDAO;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;


@Service
public class MemberService {
	@Autowired
	MemberDAO dao;

	public int insert(MemberVO vo) {
		return dao.insert(vo);
	}

	public int update(MemberVO vo) {
		return dao.update(vo);
	}

	public int delete(MemberVO vo) {
		return dao.delete(vo);
	}

	public List<MemberVO> selectAll() {
		return dao.selectAll();
	}

	public MemberVO selectOne(MemberVO vo) {
		return dao.selectOne(vo);
	}

	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	public List<MemberVO> searchList(String searchKey, String searchWord) {
		return dao.searchList(searchKey, searchWord);
	}

	public MemberVO idCheck(MemberVO vo) {
		return dao.idCheck(vo);
	}

	public MemberVO NickCheck(MemberVO vo) {
		return dao.NickCheck(vo);
	}

	public MemberVO TelCheck(MemberVO vo) {
		return dao.TelCheck(vo);
	}
	
	public MiniBoardVO FindMiniBoard(MiniBoardVO vo) {
		return dao.FindMiniBoard(vo);
	}
	
	public BoardVO FindBoard(BoardVO vo2) {
		return dao.FindBoard(vo2);
	}
	
	public MemberVO find_id(MemberVO vo)  {

		return dao.find_id(vo);
	}


	public String find_pw(String email ) {
		return dao.find_pw(email);
	}

	public int pwUpdate_M(MemberVO vo) {
		return dao.pwUdate_M(vo);
	}

	public MemberVO selectMember(String email) {
		
		return dao.selectMember(email);
	}

	public void pass_change(MemberVO vo) throws Exception {
        dao.pass_change(vo);
    }


	public MemberVO find_user(MemberVO vo) {
		return dao.find_user(vo);
	}

	public MemberVO findUser(String email) {
	
		return dao.findUser(email);
	}

	public MemberVO find_id_question(MemberVO vo) {
		return dao.find_id_question(vo);
	}
	
	public String selectOneByNick(String bNick) {
		return dao.selectOneByNick(bNick);
	}
}