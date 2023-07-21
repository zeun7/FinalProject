package multi.com.finalproject.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.board.model.BoardVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.minicomments.service.MiniCommentsService;

@Slf4j
@Repository
public class HomeDAOimpl implements HomeDAO {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	MiniCommentsService minicomments_service;
	
	@Override
	public List<BoardVO> board_post(Map<String, Object> map) {
		log.info("board_post()...{}", map);
		
		if(map.get("bname").equals("hot")) {
			if(map.get("sortKey").equals("wdate")) {
				return session.selectList("BP_SELECT_ALL_WDATE", map);
			}else {
				return session.selectList("BP_SELECT_ALL_VCOUNT", map);
			}
		}else {
			if(map.get("sortKey").equals("wdate")) {
				return session.selectList("BOARD_POST_WDATE", map);
			}else {
				return session.selectList("BOARD_POST_VCOUNT", map);
			}
		}
	}

	@Override
	public List<MiniBoardVO> friends_post(Map<String, Object> map) {
		log.info("friends_post()...{}", map);
		
		List<MiniBoardVO> vos = new ArrayList<MiniBoardVO>();
		
		if(map.get("sortKey").equals("wdate")) {
			vos = session.selectList("FRIENDS_POST_WDATE", map);
		}else {
			vos = session.selectList("FRIENDS_POST_VCOUNT", map);
		}
		
		for(MiniBoardVO vo : vos) {
			vo.setCcount(minicomments_service.mb_ccount(vo));
		}
		
		return vos;
	}

}