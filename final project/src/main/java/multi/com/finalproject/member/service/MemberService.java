package multi.com.finalprojects.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalprojects.member.model.MemberDAO;
import multi.com.finalprojects.member.model.MemberVO;
@Service
public class MemberService {
@Autowired
MemberDAO dao;

	public int insert(MemberVO vo) {
		return dao.insert(vo) ;
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

}
