package multi.com.finalproject.board.model;

import java.util.List;
import java.util.Map;

public interface BoardDAO {

	public List<BoardVO> selectAll(Map<String, Object> map);

	public BoardVO selectOne(BoardVO vo);

	public List<BoardVO> searchList(String searchKey, String searchWord);

	public void vcountUp(BoardVO vo);

	public int insert(BoardVO vo);

	public int update(BoardVO vo);

	public int delete(BoardVO vo);
	
	public int like(BoardVO vo);
	
	public int report(BoardVO vo);

}
