package multi.com.finalproject.jukebox;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.member.model.MemberVO;

@Service
public class JukeboxService {

	@Autowired
	JukeboxDAO dao;
	
	public int pcountUp(MemberVO vo) {
		return dao.pcountUp(vo);
	}

}