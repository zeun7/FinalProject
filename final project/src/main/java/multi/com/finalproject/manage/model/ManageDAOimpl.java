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
	
	@Override
	public List<FriendsVO> friends(FriendsVO vo) {
		log.info("friends()...{}", vo);
		
		return sqlSession.selectList("MNG_FRIENDS",vo);
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
	public List<ReportVO> board() {
		log.info("board select reported()...");
		
		return sqlSession.selectList("MNG_B_SELECT_REPORT");
	}
	
	@Override
	public int bcount() {
		log.info("board count()...");
		
		return sqlSession.selectOne("MNG_BCOUNT");
	}

	@Override
	public List<ReportVO> comments() {
		log.info("comments select reported()...");
		
		return sqlSession.selectList("MNG_C_SELECT_REPORT");
	}

	@Override
	public int ccount() {
		log.info("comments count()...");
		
		return sqlSession.selectOne("MNG_CCOUNT");
	}

	@Override
	public int del_report(ReportVO vo) {
		log.info("delete report()...{}", vo);
		
		return sqlSession.delete("MNG_DEL_REPORT", vo);
	}
	
}
