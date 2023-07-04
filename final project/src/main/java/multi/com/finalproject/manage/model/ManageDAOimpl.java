package multi.com.finalproject.manage.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;

@Slf4j
@Repository
public class ManageDAOimpl implements ManageDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public ManageDAOimpl() {
		log.info("ManageDAOimpl()...");
	}
	
	@Override
	public List<FriendsVO> friends(FriendsVO vo) {
		log.info("friends()...{}", vo);
		
		return sqlSession.selectList("MNG_FRIENDS",vo);
	}
	
	@Override
	public int grade(FriendsVO vo) {
		log.info("update grade()...");
		
		return sqlSession.update("MNG_GRADE", vo);
	}

	@Override
	public List<MemberVO> searchUser(MemberVO vo, String searchWord) {
		log.info("searchUser()...{}", searchWord);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", vo.getNickname());
		map.put("searchWord", "%"+searchWord+"%");
		log.info("{}", map);
		
		return sqlSession.selectList("MNG_SEARCH_LIST_NICKNAME", map);
	}
	
	@Override
	public int addfriend(MemberVO vo, MemberVO vo2) {
		log.info("addfriend()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		int result = sqlSession.insert("MNG_ADD_FRIEND",map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public int delfriend(MemberVO vo, MemberVO vo2) {
		log.info("delfrined()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		int result = sqlSession.delete("MNG_DEL_FRIEND", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public List<FriendsVO> selectBan(FriendsVO vo) {
		log.info("selectBan()...{}", vo);
		
		return sqlSession.selectList("MNG_M_SELECT_BAN", vo);
	}
	
	@Override
	public int addBan(MemberVO vo, MemberVO vo2) {
		log.info("addBan()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		
		int result = sqlSession.update("MNG_M_ADD_BAN", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public int newBan(MemberVO vo, MemberVO vo2) {
		log.info("newBan()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		
		int result = sqlSession.update("MNG_M_NEW_BAN", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public int delBan(MemberVO vo, MemberVO vo2) {
		log.info("delBan()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		
		int result = sqlSession.delete("MNG_M_DEL_BAN", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public List<MemberVO> member(Integer page) {
		log.info("member selectAll()...{}", page);
		
		return sqlSession.selectList("MNG_M_SELECT_MEMBER", page);
	}
	
	@Override
	public int mcount() {
		log.info("member count()...");
		
		return sqlSession.selectOne("MNG_MCOUNT");
	}
	
	@Override
	public int mclass(MemberVO vo) {
		log.info("mclass update()...");
		
		return sqlSession.update("MNG_MCLASS", vo);
	}

	@Override
	public List<ReportVO> board() {
		log.info("board select reported()...");
		
		List<ReportVO> vos = sqlSession.selectList("MNG_B_SELECT_REPORT");
		List<ReportVO> vos2 = sqlSession.selectList("MNG_MB_SELECT_REPORT");
		
		for(ReportVO vo : vos2) {
			vos.add(vo);
		}
		
		return vos;
	}
	
	@Override
	public int bcount() {
		log.info("board count()...");
		int count1 = sqlSession.selectOne("MNG_BCOUNT");
		int count2 = sqlSession.selectOne("MNG_MBCOUNT");
		
		log.info("count1: {}, count2: {}", count1, count2);
		
		return count1 + count2;
	}
	
	@Override
	public int del_board(ReportVO vo) {
		log.info("delete board()...{}", vo);
		
		int result = sqlSession.delete("B_DELETE", vo);
		log.info("delete board result: {}", result);
		
		if(result == 1){
			if(vo.getBnum() != 0)
				return sqlSession.delete("MNG_DEL_B_REPORT", vo);
			else
				return sqlSession.delete("MNG_DEL_MB_REPORT", vo);
		}
		else
			return 0;
	}

	@Override
	public List<ReportVO> comments() {
		log.info("comments select reported()...");
		
		return sqlSession.selectList("MNG_C_SELECT_REPORT");
	}

	@Override
	public int ccount() {
		log.info("comments count()...");
		
		int count1 = sqlSession.selectOne("MNG_CCOUNT"); 
		
		return count1; 
	}
	
	@Override
	public int del_comments(ReportVO vo) {
		log.info("delete comments()...{}", vo);
		int result = 0;
		
		if(vo.getCcnum() != 0)
			result = sqlSession.delete("C_DELETE", vo);
		else
			result = sqlSession.delete("CC_DELETE", vo);
		
		if(result == 1) {
			if(vo.getCcnum() == 0)
				return sqlSession.delete("MNG_DEL_C_REPORT", vo);
			else
				return sqlSession.delete("MNG_DEL_CC_REPORT", vo);
		}
		else
			return 0;
	}

	@Override
	public int del_b_report(ReportVO vo) {
		log.info("delete board report()...{}", vo);
		
		if(vo.getBnum() != 0)
			return sqlSession.delete("MNG_DEL_B_REPORT", vo);
		else
			return sqlSession.delete("MNG_DEL_MB_REPORT", vo);
	}
	
	@Override
	public int del_c_report(ReportVO vo) {
		log.info("delete comments report()...{}", vo);
		
		return sqlSession.delete("MNG_DEL_C_REPORT", vo);
	}

	@Override
	public ReportVO select_report(ReportVO vo) {
		log.info("select report()...{}", vo);
		
		return sqlSession.selectOne("MNG_SELECT_REPORT", vo);
	}
	
	@Override
	public List<FriendsVO> ilchon_selectAll(MemberVO m_attr) {
		log.info("ilchon_selectAll(m_attr)...", m_attr);
		
		return sqlSession.selectList("ILCHON_SELECT_ALL", m_attr);
	}
	
}
