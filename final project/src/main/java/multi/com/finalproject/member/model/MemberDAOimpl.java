package multi.com.finalproject.member.model;

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
		log.info("MemberDAOimpl...");
	}
	
	@Override
	public MemberVO selectOne(MemberVO vo) {
		log.info("selectOne(vo)...{}", vo);
		return sqlSession.selectOne("M_SELECT_ONE", vo);
	}

}
