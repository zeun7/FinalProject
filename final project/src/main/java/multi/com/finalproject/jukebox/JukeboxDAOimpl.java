package multi.com.finalproject.jukebox;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;

@Repository
@Slf4j
public class JukeboxDAOimpl implements JukeboxDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int pcountUp(MemberVO vo) {
		log.info("pcountUp()...{}", vo);
		
		return sqlSession.update("PCOUNT_UP", vo);
	}

}