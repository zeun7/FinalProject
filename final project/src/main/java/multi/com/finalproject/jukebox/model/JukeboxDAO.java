package multi.com.finalproject.jukebox.model;

import java.util.List;

import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minihome.model.JukeboxVO;

public interface JukeboxDAO {

	int pcountUp(MemberVO vo);

	int count();

	List<JukeboxVO> selectAll(int page);

	MemberVO peachCount(MemberVO vo);

	void pcountDown(MemberVO vo);

	int insert(JukeboxVO jvo);

	JukeboxVO jukebox_check(JukeboxVO vo);

}