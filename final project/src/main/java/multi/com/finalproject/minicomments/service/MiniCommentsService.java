package multi.com.finalproject.minicomments.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.comments.model.ClikesVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;
import multi.com.finalproject.minicomments.model.MiniCommentsDAO;
import multi.com.finalproject.minicomments.model.MiniCommentsVO;

@Service
public class MiniCommentsService {
	
	@Autowired
	MiniCommentsDAO dao;

	public List<MiniCommentsVO> selectAll(MiniCommentsVO vo) {
		return dao.selectAll(vo);
	}

	public List<MiniCommentsVO> mcc_selectAll(MiniCommentsVO vo) {
		return dao.mcc_selectAll(vo);
	}
	
	public List<MiniCommentsVO> findAll(MiniCommentsVO vo) {
		return dao.findAll(vo);
	}

	public List<MiniCommentsVO> findAll2(Map<String, Object> map) {
		return dao.findAll2(map);
	}
	
	public MiniCommentsVO findOne(MiniCommentsVO vo) {
		return dao.findOne(vo);
	}
	
	public int count(MiniCommentsVO vo) {
		return dao.count(vo);
	}

	public int insert(MiniCommentsVO vo) {
		return dao.insert(vo);
	}

	public int update(MiniCommentsVO vo) {
		return dao.update(vo);
	}

	public int delete(MiniCommentsVO vo) {
		return dao.delete(vo);
	}

	public int report(Map<String, Object> map) {
		return dao.report(map);
	}

	public ClikesVO is_clike(ClikesVO vo) {
		return dao.is_clike(vo);
	}

	public int count_clikes(ClikesVO vo) {
		return dao.count_clikes(vo);
	}

	public int clike(ClikesVO vo) {
		return dao.clike(vo);
	}

	public int cancel_clike(ClikesVO vo) {
		return dao.cancel_clike(vo);
	}

	public void update_nickname(Map<String, String> map) {
		dao.update_nickname(map);
	}

	public int deleteAll(MiniBoardVO vo2) {
		return dao.deleteAll(vo2);
	}

}
