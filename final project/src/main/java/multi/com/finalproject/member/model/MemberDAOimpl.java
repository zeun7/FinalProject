package multi.com.finalproject.member.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

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
		log.info("insert()...", vo);
		return sqlSession.insert("M_INSERT", vo);
	}

	@Override
	public int update(MemberVO vo) {
		log.info("update()...", vo);
		return sqlSession.update("M_UPDATE", vo);
	}

	@Override
	public int delete(MemberVO vo) {
		log.info("delete()...{}", vo);
		return sqlSession.delete("M_DELETE", vo);
	}

	@Override
	public List<MemberVO> selectAll() {
		log.info("selectAll()...");

		return sqlSession.selectList("M_SELECT_ALL");
	}

	@Override
	public MemberVO selectOne(MemberVO vo) {
		log.info("selectOne()...{}", vo);
		return sqlSession.selectOne("M_SELECT_ONE", vo);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		log.info("login()...{}", vo);
		return sqlSession.selectOne("LOGIN", vo);
	}

	@Override
	public List<MemberVO> searchList(String searchKey, String searchWord) {
		log.info("searchList()...searchKey:{}", searchKey);
		log.info("searchList()...searchWord:{}", searchWord);

		String key = "";
		if (searchKey.equals("name")) {
			key = "M_SEARCH_LIST_NAME";
		} else {
			key = "M_SEARCH_LIST_TEL";
		}

		return sqlSession.selectList(key, "%" + searchWord + "%");
	}

	@Override
	public MemberVO idCheck(MemberVO vo) {
		log.info("idCheck()...{}", vo);
		return sqlSession.selectOne("M_ID_CHECK", vo);
	}

	@Override
	public MemberVO NickCheck(MemberVO vo) {
		log.info("NickCheck()...{}", vo);
		return sqlSession.selectOne("M_NICK_CHECK", vo);
	}

	@Override
	public MemberVO find_id(MemberVO vo)  {
		log.info("find_id()...{}", vo);
		
		return sqlSession.selectOne("FIND_ID_EMAIL", vo);
	}

	@Override
	public String find_pw(String email) {
		return sqlSession.selectOne("FIND_PW", email);
	}

	@Override

	public MemberVO TelCheck(MemberVO vo) {
		return sqlSession.selectOne("M_TEL_CHECK", vo);
	}

	@Override
	public int pwUdate_M(MemberVO vo) {
		return sqlSession.selectOne("PW_UPDATE_M", vo);
	}

	@Override
	public MemberVO selectMember(String email) {
		return sqlSession.selectOne("SELECT_MEMBER", email);

	}

	@Transactional
	public int update_pw(MemberVO vo) throws Exception {
		return sqlSession.update("PW_UPDATE", vo);
	}

	@Override
	public void pass_change(MemberVO vo) throws Exception {
		log.info("change password...{}", vo);

		sqlSession.update("PASS_CHANGE", vo);
	}

	@Override
	public MemberVO find_user(MemberVO vo) {

		return sqlSession.selectOne("FIND_USER", vo);
	}

	@Override
	public MemberVO findUser(String email) {
		return sqlSession.selectOne("FINDUSER", email);
	}

	@Override
	public MemberVO find_id_question(MemberVO vo) {
		return sqlSession.selectOne("FIND_ID_QUESTION", vo);
	}
	
	@Override
	public MiniBoardVO FindMiniBoard(MiniBoardVO vo) {
		return sqlSession.selectOne("FIND_MINI_BOARD", vo);
	}

	@Override
	public BoardVO FindBoard(BoardVO vo2) {
		return sqlSession.selectOne("FIND_BOARD", vo2);
	}
	
	@Override
	public String selectOneByNick(String bNick) {
		return sqlSession.selectOne("M_SELECT_ONE_BY_NICK", bNick);
	}

}