package multi.com.finalproject.home;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.board.model.BoardVO;

@Service
public class HomeService {
	
	@Autowired
	HomeDAO dao;
	
	public List<BoardVO> friends_post() {
		return dao.friends_post();
	}

}
