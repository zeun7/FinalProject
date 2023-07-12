package multi.com.finalproject.jukebox.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.jukebox.model.JukeboxDAO;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minihome.model.JukeboxVO;

@Service
public class JukeboxService {

	@Autowired
	JukeboxDAO dao;
	
	public int pcountUp(MemberVO vo) {
		return dao.pcountUp(vo);
	}

	public int count() {
		return dao.count();
	}

	public List<JukeboxVO> selectAll(int page) {
		return dao.selectAll(page);
	}

	public MemberVO peachCount(MemberVO vo) {
		return dao.peachCount(vo);
	}

	public void pcountDown(MemberVO vo) {
		dao.pcountDown(vo);
	}

	public int insert(JukeboxVO jvo) {
		return dao.insert(jvo);
	}

	public JukeboxVO jukebox_check(JukeboxVO vo) {
		return dao.jukebox_check(vo);
	}

}