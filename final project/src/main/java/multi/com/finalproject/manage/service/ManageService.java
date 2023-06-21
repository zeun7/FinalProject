package multi.com.finalproject.manage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.manage.model.ManageDAO;
import multi.com.finalproject.member.model.MemberVO;

@Service
public class ManageService {
	
	@Autowired
	ManageDAO dao;

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
