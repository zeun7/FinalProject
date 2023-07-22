package multi.com.finalproject.manage.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.member.model.MemberVO;
import multi.com.finalproject.minicomments.model.MiniCommentsVO;

@Slf4j
@Repository
public class ManageDAOimpl implements ManageDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	MongoCollection<Document> MiniComments;
	
	public ManageDAOimpl() {
		log.info("ManageDAOimpl()...");
	}
	
	@Override
	public List<FriendsVO> friends(FriendsVO vo) {
		log.info("friends()...{}", vo);
		
		return sqlSession.selectList("MNG_FRIENDS",vo);
	}
	
	@Override
	public int grade(FriendsVO vo) {
		log.info("update grade()...");
		
		return sqlSession.update("MNG_GRADE", vo);
	}

	@Override
	public List<MemberVO> searchUser(MemberVO vo, String searchWord) {
		log.info("searchUser()...{}", searchWord);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", vo.getNickname());
		map.put("searchWord", "%"+searchWord+"%");
		log.info("{}", map);
		
		return sqlSession.selectList("MNG_SEARCH_LIST_NICKNAME", map);
	}
	
	@Override
	public int addfriend(MemberVO vo, MemberVO vo2) {
		log.info("addfriend()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		int result = sqlSession.insert("MNG_ADD_FRIEND",map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public int delfriend(MemberVO vo, MemberVO vo2) {
		log.info("delfrined()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		int result = sqlSession.delete("MNG_DEL_FRIEND", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public List<FriendsVO> selectBan(FriendsVO vo) {
		log.info("selectBan()...{}", vo);
		
		return sqlSession.selectList("MNG_M_SELECT_BAN", vo);
	}
	
	@Override
	public List<FriendsVO> selectBanned(FriendsVO vo) {
		return sqlSession.selectList("MNG_M_SELECT_BANNED", vo);
	}
	
	
	@Override
	public int addBan(MemberVO vo, MemberVO vo2) {
		log.info("addBan()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		
		int result = sqlSession.update("MNG_M_ADD_BAN", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public int newBan(MemberVO vo, MemberVO vo2) {
		log.info("newBan()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		
		int result = sqlSession.update("MNG_M_NEW_BAN", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public int delBan(MemberVO vo, MemberVO vo2) {
		log.info("delBan()...{}, {}", vo.getNickname(), vo2.getNickname());
		Map<String, String> map = new HashMap<String, String>();
		map.put("nickname1", vo.getNickname());
		map.put("nickname2", vo2.getNickname());
		
		int result = sqlSession.delete("MNG_M_DEL_BAN", map);
		log.info("result: {}", result);
		
		return result;
	}
	
	@Override
	public List<MemberVO> member(Integer page) {
		log.info("member selectAll()...{}", page);
		
		return sqlSession.selectList("MNG_M_SELECT_MEMBER", page);
	}
	
	@Override
	public int mcount() {
		log.info("member count()...");
		
		return sqlSession.selectOne("MNG_MCOUNT");
	}
	
	@Override
	public int mclass(MemberVO vo) {
		log.info("mclass update()...");
		
		return sqlSession.update("MNG_MCLASS", vo);
	}

	@Override
	public List<ReportVO> board() {
		log.info("board select reported()...");
		
		List<ReportVO> vos = sqlSession.selectList("MNG_B_SELECT_REPORT");
		List<ReportVO> vos2 = sqlSession.selectList("MNG_MB_SELECT_REPORT");
		
		vos.addAll(vos2);
		
		return vos;
	}
	
	@Override
	public int bcount() {
		log.info("board count()...");
		int count1 = sqlSession.selectOne("MNG_BCOUNT");
		int count2 = sqlSession.selectOne("MNG_MBCOUNT");
		
		log.info("count1: {}, count2: {}", count1, count2);
		
		return count1 + count2;
	}
	
	@Override
	public int del_board(ReportVO vo) {
		log.info("delete board()...{}", vo);
		
		int result = sqlSession.delete("B_DELETE", vo);
		log.info("delete board result: {}", result);
		
		if(result == 1){
			if(vo.getBnum() != 0) {
				sqlSession.delete("B_DELETE", vo);	// 게시글 삭제
				return sqlSession.delete("MNG_DEL_REPORT_BY_BNUM", vo);	// 해당 게시글 신고 삭제
			}
			else {
				sqlSession.delete("MB_DELETE", vo);
				return sqlSession.delete("MNG_DEL_REPORT_BY_MBNUM", vo);
			}
		}
		else
			return 0;
	}

	@Override
	public List<ReportVO> comments() {
		log.info("comments select reported()...");
		
		return sqlSession.selectList("MNG_C_SELECT_REPORT");
	}
	
	@Override
	public List<ReportVO> minicomments() {
		log.info("minicomments select reported()...");
		
		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();
		List<ReportVO> vos3 = new ArrayList<ReportVO>();
		
		Bson sort = new Document("mcnum", 1);
		Bson filter = Filters.eq("report", 1);
				
		FindIterable<Document> docs = MiniComments.find(filter).sort(sort);	// minicomments에서 신고된 댓글 찾기
		
		try {
			for(Document doc : docs) {
				log.info("{}", doc);
				MiniCommentsVO vo2 = new MiniCommentsVO();
				vo2.setMcnum(doc.getInteger("mcnum"));
				vo2.setMccnum(doc.getInteger("mccnum"));
				vo2.setMbnum(doc.getInteger("mbnum"));
				vo2.setId(doc.getString("id"));
				vo2.setWriter(doc.getString("writer"));
				vo2.setContent(doc.getString("content"));
				vo2.setCdate(doc.getString("cdate"));
				vo2.setSecret(doc.getInteger("secret"));
				vo2.setReport(doc.getInteger("report"));
				
				vos.add(vo2);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		List<ReportVO> vos2 = sqlSession.selectList("MNG_MC_SELECT_REPORT"); // report 테이블에서 minicomments 찾기
		
		for(MiniCommentsVO vo : vos) {					// 두개의 테이블 join
			ReportVO vo3 = new ReportVO();
			for(ReportVO vo2 : vos2) {
				if(vo.getMcnum() == vo2.getMcnum()) {
					vo3.setRnum(vo2.getRnum());
					vo3.setMcnum(vo2.getMcnum());
					vo3.setMccnum(vo2.getMccnum());
					vo3.setMbnum(vo2.getMbnum());
					vo3.setId(vo.getId());
					vo3.setWriter(vo.getWriter());
					vo3.setContent(vo.getContent());
					vo3.setReason(vo2.getReason());
					
					vos3.add(vo3);
				}
			}
		}
		
		return vos3;
	}

	@Override
	public int ccount() {
		log.info("comments count()...");
		
		int count1 = sqlSession.selectOne("MNG_CCOUNT");
		
		Bson filter = Filters.eq("report", 1);
		
		long count2 = MiniComments.count(filter);
		
		return count1 + Long.valueOf(count2).intValue();
	}
	
	@Override
	public int del_comments(ReportVO vo) {
		log.info("delete comments()...{}", vo);
		
		sqlSession.delete("MNG_DEL_REPORT_BY_CNUM", vo);	// manage 테이블에서 삭제
		sqlSession.delete("C_DEL_CLIKE", vo);			// clikes 테이블에서 삭제
		return sqlSession.delete("C_DELETE", vo);		// comments 테이블에서 삭제


	}

	@Override
	public int del_b_report(ReportVO vo) {
		log.info("delete board report()...{}", vo);
		
		if(vo.getBnum() != 0)
			return sqlSession.delete("MNG_DEL_B_REPORT", vo);
		else
			return sqlSession.delete("MNG_DEL_MB_REPORT", vo);
	}
	
	@Override
	public int del_c_report(ReportVO vo) {
		log.info("delete comments report()...{}", vo);
		
		int result = sqlSession.delete("MNG_DEL_C_REPORT", vo);	// 신고 완료 처리
		int count = sqlSession.selectOne("MNG_COUNT_C_REPORT", vo);	// 해당 댓글에 남은 신고가 있는지 확인
		
		if(count == 0)
			sqlSession.update("MNG_RESOLVED_C_REPORT", vo);	// 해당 댓글에 남은 신고가 없으면 댓글의 report를 0으로 만듬
			 
		return result;
	}

	@Override
	public ReportVO select_report(ReportVO vo) {
		log.info("select report()...{}", vo);
		
		return sqlSession.selectOne("MNG_SELECT_REPORT", vo);
	}
	
	@Override
	public List<FriendsVO> ilchon_selectAll(MemberVO m_attr) {
		log.info("ilchon_selectAll(m_attr)...", m_attr);
		
		return sqlSession.selectList("ILCHON_SELECT_ALL", m_attr);
	}

	@Override
	public void update_nickname(Map<String, String> map) {
		log.info("update nickname()...{}", map);
		
		int result1 = sqlSession.update("MNG_UPDATE_NICKNAME1", map);
		int result2 = sqlSession.update("MNG_UPDATE_NICKNAME2", map);
		log.info("result1: {}", result1);
		log.info("result2: {}", result2);
	}

	@Override
	public void delfriendAll(MemberVO vo) {
		log.info("delete frineds All()...{}", vo);
		
		int result = sqlSession.delete("MNG_DEL_FRIENDS_ALL", vo);
		log.info("result: {}", result);
	}
}
