package multi.com.finalproject.home;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.board.model.BoardVO;

public interface HomeDAO {

	public List<BoardVO> friends_post();

	public List<BoardVO> board_post(Map<String, Object> map);

}