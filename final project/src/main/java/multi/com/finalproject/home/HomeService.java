package multi.com.finalproject.home;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

@Service
public class HomeService {
	
	@Autowired
	HomeDAO dao;
	
	public List<MiniBoardVO> friends_post(Map<String, Object> map) {
		return dao.friends_post(map);
	}

	public List<BoardVO> board_post(Map<String, Object> map) {
		return dao.board_post(map);
	}

}