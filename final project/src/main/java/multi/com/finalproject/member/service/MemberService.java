package multi.com.finalproject.member.service;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

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

	public int delete(MemberVO vo)  {	
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

	public String find_id(HttpServletResponse response, String email) throws Exception {

		return dao.find_id(email);
	}

	public String find_pw(HttpServletResponse response, String email) throws Exception {
		return dao.find_pw(email);
	}

	public MemberVO user(MemberVO vo) {
		return dao.user(vo);
	}

	
}