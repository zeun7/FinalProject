package multi.com.finalproject.minihome.model;

import java.util.List;
import java.util.Map;
import multi.com.finalproject.member.model.MemberVO;

public interface MiniHomeDAO {
	
	public MiniHomeVO selectOne(MiniHomeVO vo);
	
	public int update(MiniHomeVO vo);
	
	public MemberVO selectNickPic(MemberVO vo);

	public void view_update(MiniHomeVO vo2);

	public int hasVisitedToday(VisitHistoryVO v_vo);

	public void vcountUp(MiniHomeVO vo);

	public void addVisitHistory(VisitHistoryVO v_vo);

	public void resetVTodayForALL();

	public MiniHomeVO getRandomMiniHome();

	public void insert(MemberVO vo);

	public int count(JukeboxVO vo);

	public List<JukeboxVO> j_selectAll(Map<String, Object> map);

	public JukeboxVO bgm_selectOnce(JukeboxVO vo);
	
	public int record_insert(GameVO vo);

	public List<GameVO> record_selectAll();

	public List<GameVO> record_selectAll_today();

	public GameVO record_selectOne(int gnum);

	public GameVO record_latest();

}