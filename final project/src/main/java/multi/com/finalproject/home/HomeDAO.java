package multi.com.finalproject.home;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

public interface HomeDAO {

	public List<MiniBoardVO> friends_post(Map<String, Object> map);

	public List<BoardVO> board_post(Map<String, Object> map);

}