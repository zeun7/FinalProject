package multi.com.finalproject.minicomments.model;

import java.util.List;
import java.util.Map;

import multi.com.finalproject.comments.model.ClikesVO;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

public interface MiniCommentsDAO {

	public List<MiniCommentsVO> selectAll(MiniCommentsVO vo);

	public List<MiniCommentsVO> mcc_selectAll(MiniCommentsVO vo);
	
	public List<MiniCommentsVO> findAll(MiniCommentsVO vo);

	public List<MiniCommentsVO> findAll2(Map<String, Object> map);
	
	public MiniCommentsVO findOne(MiniCommentsVO vo);
	
	public int count(MiniCommentsVO vo);

	public int insert(MiniCommentsVO vo);

	public int update(MiniCommentsVO vo);

	public int delete(MiniCommentsVO vo);

	public int report(Map<String, Object> map);

	public ClikesVO is_clike(ClikesVO vo);

	public int count_clikes(ClikesVO vo);

	public int clike(ClikesVO vo);

	public int cancel_clike(ClikesVO vo);

	public void update_nickname(Map<String, String> map);

	public int deleteAll(MiniBoardVO vo2);

	public void deleteClikesAll(MemberVO vo);

	public void deleteWriter(MemberVO vo);

	public int mb_ccount(MiniBoardVO vo);
	
	public int select_delete(MiniCommentsVO vo);

}
