package multi.com.finalproject.manage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.manage.model.FriendsVO;
import multi.com.finalproject.manage.model.ManageDAO;
import multi.com.finalproject.manage.model.ReportVO;
import multi.com.finalproject.member.model.MemberVO;

@Service
public class ManageService {
	
	@Autowired
	ManageDAO dao;

	public List<FriendsVO> friends(FriendsVO vo) {
		return dao.friends(vo);
	}

	public List<MemberVO> searchUser(MemberVO vo, String searchWord) {
		return dao.searchUser(vo, searchWord);
	}

	public int addfriend(MemberVO vo, MemberVO vo2) {
		return dao.addfriend(vo, vo2);
	}
	
	public int delfriend(MemberVO vo, MemberVO vo2) {
		return dao.delfriend(vo, vo2);
	}
	
	public List<MemberVO> member(Integer page) {
		return dao.member(page);
	}
	
	public int mcount() {
		return dao.mcount();
	}

	public List<ReportVO> board() {
		return dao.board();
	}
	
	public int bcount() {
		return dao.bcount();
	}

	public List<ReportVO> comments() {
		return dao.comments();
	}
	
	public List<ReportVO> minicomments() {
		return dao.minicomments();
	}
	
	public int ccount() {
		return dao.ccount();
	}

	public List<FriendsVO> selectBan(FriendsVO vo) {
		return dao.selectBan(vo);
	}
	
	public int addBan(MemberVO vo, MemberVO vo2) {
		return dao.addBan(vo, vo2);
	}
	
	public int newBan(MemberVO vo, MemberVO vo2) {
		return dao.newBan(vo, vo2);
	}
	
	public int delBan(MemberVO vo, MemberVO vo2) {
		return dao.delBan(vo, vo2);
	}

	public int del_b_report(ReportVO vo) {
		return dao.del_b_report(vo);
	}
	
	public int del_c_report(ReportVO vo) {
		return dao.del_c_report(vo);
	}

	public int mclass(MemberVO vo) {
		return dao.mclass(vo);
	}

	public int grade(FriendsVO vo) {
		return dao.grade(vo);
	}

	public int del_board(ReportVO vo) {
		return dao.del_board(vo);
	}

	public int del_comments(ReportVO vo) {
		return dao.del_comments(vo);
	}

	public ReportVO select_report(ReportVO vo) {
		return dao.select_report(vo);
	}

	public List<FriendsVO> ilchon_selectAll(MemberVO m_attr) {
		return dao.ilchon_selectAll(m_attr);
	}

	public void update_nickname(Map<String, String> map) {
		dao.update_nickname(map);
	}

	public void delfriendAll(MemberVO vo) {
		dao.delfriendAll(vo);
	}

}
