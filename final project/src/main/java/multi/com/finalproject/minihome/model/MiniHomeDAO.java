package multi.com.finalproject.minihome.model;

import multi.com.finalproject.member.model.MemberVO;

public interface MiniHomeDAO {
	
	public MiniHomeVO selectOne(MiniHomeVO vo);
	
	public int update(MiniHomeVO vo);
	
	public void vcountUp(MiniHomeVO vo);

	public MemberVO selectProfilePic(MiniHomeVO vo);

	public void view_update(MiniHomeVO vo2);
}