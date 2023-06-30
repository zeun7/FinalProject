package multi.com.finalproject.home;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;

@Slf4j
@Repository
public class HomeDAOimpl implements HomeDAO {
	
	@Autowired
	SqlSession session;
	
	@Override
	public List<BoardVO> friends_post() {
		log.info("friends_post()...");
		
		return null;
	}

}
