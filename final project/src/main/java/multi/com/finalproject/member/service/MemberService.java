package multi.com.finalproject.member.service;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;



import multi.com.finalproject.member.model.MemberDAO;
import multi.com.finalproject.member.model.MemberVO;


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

	public String find_id(HttpServletResponse response, String email) throws Exception {

		return dao.find_id(email);
	}

	public String find_id_tel( String tel)  {

		return dao.find_id_tel(tel);
	}

	public String find_pw(String email ) {
		return dao.find_pw(email);
	}

//	public String find_pw_tel(HttpServletResponse response, String tel) throws Exception {
//		return dao.find_pw_tel(tel);
//	}

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
}