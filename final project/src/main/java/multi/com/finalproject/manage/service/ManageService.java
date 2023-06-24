package multi.com.finalproject.manage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.manage.model.ManageDAO;
import multi.com.finalproject.manage.model.ManageFriendsVO;
import multi.com.finalproject.member.model.MemberVO;

@Service
public class ManageService {
	
	@Autowired
	ManageDAO dao;

	public List<ManageFriendsVO> friends(ManageFriendsVO vo) {
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
	
	public List<MemberVO> member() {
		return dao.member();
	}

	public List<BoardVO> board() {
		return dao.board();
	}

	public List<CommentsVO> comments() {
		return dao.comments();
	}
}
