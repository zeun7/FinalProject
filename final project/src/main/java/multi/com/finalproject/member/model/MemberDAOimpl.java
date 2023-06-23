package multi.com.finalproject.member.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Repository
public class MemberDAOimpl implements MemberDAO {

	@Autowired
	SqlSession sqlSession;
	
	public MemberDAOimpl() {
		log.info("MemberDAOimpl()...");
	}
	
	@Override
	public int insert(MemberVO vo) {
		log.info("insert()....",vo);
		return sqlSession.insert("M_INSERT",vo);
	}

	@Override
	public int update(MemberVO vo) {
		log.info("update()....",vo);
		return sqlSession.update("M_UPDATE",vo);
	}

	@Override
	public int delete(MemberVO vo) {
		log.info("/delete()....",vo);
		return sqlSession.delete("M_DELETE",vo);
	}

	@Override
	public List<MemberVO> selectAll() {
		log.info("selectAll()...");

		return sqlSession.selectList("M_SELECT_ALL");
	}

	@Override
	public MemberVO selectOne(MemberVO vo) {
		log.info("selectOne()....",vo);
		return sqlSession.selectOne("M_SELECT_ONE",vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		log.info("login()....",vo);
		return sqlSession.selectOne("LOGIN",vo);
	}

	@Override
	public List<MemberVO> searchList(String searchKey, String searchWord) {
		log.info("searchList()...searchKey:{}", searchKey);
		log.info("searchList()...searchWord:{}", searchWord);
		
		String key = "";
		if(searchKey.equals("name")) {
			key = "M_SEARCH_LIST_NAME";
		}else {
			key = "M_SEARCH_LIST_TEL";
		}
		
		return sqlSession.selectList(key,"%"+searchWord+"%");
	}

	@Override
	public MemberVO idCheck(MemberVO vo) {
		log.info("idCheck()...{}", vo);
		return sqlSession.selectOne("M_ID_CHECK",vo);
	}

	@Override
	public MemberVO NickCheck(MemberVO vo) {
		log.info("NickCheck()...{}", vo);
		return sqlSession.selectOne("M_NICK_CHECK",vo);
	}
	
	@Override
	public String find_id(String email) throws Exception{
		return sqlSession.selectOne("FIND_ID", email);
	}


	@Override
	public String find_pw(String email) throws Exception {
		return sqlSession.selectOne("FIND_PW", email);
	}

	@Override
	public int update_pw(MemberVO member) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MemberVO> friends(MemberVO vo) {
		log.info("friends()...{}", vo);
		
		return sqlSession.selectOne("M_FRIENDS",vo);
	}

	@Override
	public List<MemberVO> searchUser(MemberVO vo, String searchWord) {
		log.info("searchUser()...{}", searchWord);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", vo.getNickname());
		map.put("searchWord", "%"+searchWord+"%");
		return sqlSession.selectList("M_SEARCH_LIST_NICKNAME", map);
	}
	
	@Override
	public int addfriend(MemberVO vo, MemberVO vo2) {
		log.info("addfriend()...{}, {}", vo, vo2);
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		int result = sqlSession.insert("M_ADD_FRIEND",map);
		
		return result;
	}
}

