package multi.com.finalproject.minicomments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.minicomments.model.MiniCommentsDAO;
import multi.com.finalproject.minicomments.model.MiniCommentsVO;

@Service
public class MiniCommentsService {
	
	@Autowired
	MiniCommentsDAO dao;

	public List<MiniCommentsVO> selectAll() {
		return dao.selectAll();
	}

}
