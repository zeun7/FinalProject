package multi.com.finalproject.minihome.model;

public interface MiniHomeDAO {
	
	public MiniHomeVO selectOne(MiniHomeVO vo);
	
	public int update(MiniHomeVO vo);
	
	public void vcountUp(MiniHomeVO vo);
}
