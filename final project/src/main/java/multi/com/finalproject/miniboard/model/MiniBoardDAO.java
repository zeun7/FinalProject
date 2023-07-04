package multi.com.finalproject.miniboard.model;

import java.util.List;

public interface MiniBoardDAO {
	
	public List<MiniBoardVO> mb_selectAll(MiniBoardVO vo);

	public MiniBoardVO mb_selectOne(MiniBoardVO vo);

	public int mb_insert(MiniBoardVO vo);
	
	public int diary_update(MiniBoardVO vo);

	public int gallery_update(MiniBoardVO vo);
	
	public int mb_delete(MiniBoardVO vo);
	
	public List<MiniBoardVO> mongo_findAll();

	public int mongo_insert(MiniBoardVO vo);

	public int mongo_update(MiniBoardVO vo);

	public int mongo_delete(MiniBoardVO vo);
	
}