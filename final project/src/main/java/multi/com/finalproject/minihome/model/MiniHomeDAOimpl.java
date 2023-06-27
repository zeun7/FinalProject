package multi.com.finalproject.minihome.model;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;

@Slf4j
@Repository
public class MiniHomeDAOimpl implements MiniHomeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public MiniHomeDAOimpl() {
		log.info("MiniHomeDAOimpl...");
	}
	
	@Override
	public MiniHomeVO selectOne(MiniHomeVO vo) {
		log.info("selectOne(vo)...{}", vo);
		return sqlSession.selectOne("MINI_SELECT_ONE", vo);
	}
	
	@Override
	public int update(MiniHomeVO vo) {
		log.info("update(vo)...{}", vo);
		return sqlSession.update("MINI_UPDATE",vo);
	}

	@Override
	public void vcountUp(MiniHomeVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberVO selectProfilePic(MiniHomeVO vo) {
		log.info("selectProfilePic(vo)...{}", vo);
		return sqlSession.selectOne("PROFILE_PIC_SELECT", vo);
	}

	@Override
	public void view_update(MiniHomeVO vo2) {
		log.info("update(vo2)...{}", vo2);
		sqlSession.update("VIEW_UPDATE",vo2);
	}

}