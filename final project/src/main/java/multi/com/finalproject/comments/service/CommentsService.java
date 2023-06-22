package multi.com.finalproject.comments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.comments.model.CommentsDAO;
import multi.com.finalproject.comments.model.CommentsVO;

@Service
public class CommentsService {
	
	@Autowired
	CommentsDAO dao;

	public int insert(CommentsVO vo) {
		return dao.insert(vo);
	}

	public int update(CommentsVO vo) {
		return dao.update(vo);
	}

	public int delete(CommentsVO vo) {
		return dao.delete(vo);
	}

	public List<CommentsVO> selectAll() {
		return dao.selectAll();
	}
}