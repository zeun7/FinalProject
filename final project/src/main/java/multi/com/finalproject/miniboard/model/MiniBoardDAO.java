package multi.com.finalproject.miniboard.model;

import java.util.List;

public interface MiniBoardDAO {
	
	public List<MiniBoardVO> selectAll();

	public MiniBoardVO selectOne(MiniBoardVO vo);

	public int insert(MiniBoardVO vo);
	
}
