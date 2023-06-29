package multi.com.finalproject.minihome.model;

import multi.com.finalproject.member.model.MemberVO;

public interface MiniHomeDAO {
	
	public MiniHomeVO selectOne(MiniHomeVO vo);
	
	public int update(MiniHomeVO vo);
	
	public MemberVO selectNickPic(MiniHomeVO vo);

	public void view_update(MiniHomeVO vo2);

	public int hasVisitedToday(VisitHistoryVO v_vo);

	public void vcountUp(MiniHomeVO vo);

	public void addVisitHistory(VisitHistoryVO v_vo);

	public void resetVTodayForALL();

	public MiniHomeVO getRandomMiniHome();

}