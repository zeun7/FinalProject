package multi.com.finalproject.comments.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.comments.model.ClikesVO;
import multi.com.finalproject.comments.model.CommentsDAO;
import multi.com.finalproject.comments.model.CommentsVO;
import multi.com.finalproject.member.model.MemberVO;

@Service
public class CommentsService {
	
	@Autowired
	CommentsDAO dao;
	
	public List<CommentsVO> selectAll(CommentsVO vo) {
		return dao.selectAll(vo);
	}
	
	public List<CommentsVO> cc_selectAll(CommentsVO vo) {
		return dao.cc_selectAll(vo);
	}

	public int insert(CommentsVO vo) {
		return dao.insert(vo);
	}

	public int update(CommentsVO vo) {
		return dao.update(vo);
	}

	public int delete(CommentsVO vo) {
		return dao.delete(vo);
	}

	public int report(Map<String, Object> map) {
		return dao.report(map);
	}

	public ClikesVO is_clike(ClikesVO vo) {
		return dao.is_clike(vo);
	}

	public int count_clikes(ClikesVO vo) {
		return dao.count_clikes(vo);
	}

	public int clike(ClikesVO vo) {
		return dao.clike(vo);
	}

	public int cancel_clike(ClikesVO vo) {
		return dao.cancel_clike(vo);
	}

	public void update_nickname(Map<String, String> map) {
		dao.update_nickname(map);
	}

	public int deleteAll(BoardVO vo2) {
		return dao.deleteAll(vo2);
	}

	public void deleteClikesAll(MemberVO vo) {
		dao.deleteClikesAll(vo);
	}

	public void deleteWriter(MemberVO vo) {
		dao.deleteWriter(vo);
	}

}