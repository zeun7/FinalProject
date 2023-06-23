package multi.com.finalproject.miniboard.model;

import java.util.List;

public interface MiniBoardDAO {
	
	public List<MiniBoardVO> selectAll();

	public MiniBoardVO diary_selectOne(MiniBoardVO vo);

	public int insert(MiniBoardVO vo);
	
	public int diary_update(MiniBoardVO vo);

	public int diary_delete(MiniBoardVO vo);
	
	public List<MiniBoardVO> mongo_findAll();

	public int mongo_insert(MiniBoardVO vo);

	public int mongo_update(MiniBoardVO vo);

	public int mongo_delete(MiniBoardVO vo);
	
	public MiniBoardVO gallery_selectOne(MiniBoardVO vo);
	
	public int gallery_update(MiniBoardVO vo);

	public int gallery_delete(MiniBoardVO vo);
	
}