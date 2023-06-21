package multi.com.finalproject.member.model;

import java.util.List;

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
		return sqlSession.insert("M_INSERT");
	}

	@Override
	public int update(MemberVO vo) {
		log.info("update()....",vo);
		return sqlSession.update("M_UPDATE");
	}

	@Override
	public int delete(MemberVO vo) {
		log.info("/delete()....",vo);
		return sqlSession.delete("M_DELETE");
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
		return sqlSession.selectOne("M_LOGIN");
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
		return sqlSession.selectOne("M_Nick_CHECK",vo);
	}


}
