package multi.com.finalproject.minicomments.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.mongodb.client.model.Sorts;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.model.ClikesVO;
import multi.com.finalproject.miniboard.model.MiniBoardVO;

@Slf4j
@Repository
public class MiniCommentsDAOimpl implements MiniCommentsDAO {
	
	@Autowired
	MongoCollection<Document> MiniComments;
	
	@Autowired
	SqlSession sqlSession;
	
	SimpleDateFormat sf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
	
	@Override
	public List<MiniCommentsVO> selectAll(MiniCommentsVO vo) {
		log.info("mc selectAll()...");
		
		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();
		
		Bson sort = new Document("mcnum", 1);
		Bson filter = Filters.and(
						Filters.eq("mbnum", vo.getMbnum()),
						Filters.eq("mccnum", 0));
				
		FindIterable<Document> docs = MiniComments.find(filter).sort(sort);
		
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
		
		return vos;
	}

	@Override
	public List<MiniCommentsVO> mcc_selectAll(MiniCommentsVO vo) {
		log.info("mcc_selectAll...{}", vo);
		
		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();
		
		Bson sort = new Document("mcnum", 1);
		Bson filter = Filters.eq("mccnum", vo.getMcnum());
				
		FindIterable<Document> docs = MiniComments.find(filter).sort(sort);
		
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
		
		return vos;
	}
	
	@Override
	public List<MiniCommentsVO> findAll(MiniCommentsVO vo) {
		log.info("findAll(vo)...{}", vo);
		String id = vo.getId();

		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();

		Bson sort = Sorts.descending("mcnum"); // sort by mcnum in descending order

		//방문한 미니홈피 주인의 방명록(or 댓글)들만 가져오기
		Bson filter = Filters.and(Filters.eq("id", id), Filters.eq("mccnum", 0), Filters.eq("mbnum", 0));

		FindIterable<Document> docs = MiniComments.find(filter).sort(sort).limit(4); // 최신순, 4개만 가져오기..

		for (Document doc : docs) {
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

			if(vo2.getMbnum()==0) vos.add(vo2); //방명록(mbnum!=0일 경우 댓글들임)만 가져오기...
		}
		return vos;
	}

	@Override
	public List<MiniCommentsVO> findAll2(Map<String, Object> map) {
		log.info("findAll2(map)...{}", map);
		MiniCommentsVO vo = (MiniCommentsVO) map.get("vo");
		String id = vo.getId();
		int page = (int) map.get("page");
		log.info("id : {}, page : {}", id, page);
		
		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();

		Bson sort = new Document("mcnum", -1);
		Bson filter = Filters.eq("id", id);
		FindIterable<Document> docs = MiniComments.find(filter).sort(sort).limit(10).skip((page-1)*10);
		
		for (Document doc : docs) {
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
			if (id.equals(vo2.getId()) && vo2.getMbnum() == 0)
				vos.add(vo2); // 방문한 페이지의 id의 방명록만 가져오기...
		}
		return vos;
	}
	
	@Override
	public MiniCommentsVO findOne(MiniCommentsVO vo) {
		log.info("findOne()...{}", vo);

		MiniCommentsVO vo2 = new MiniCommentsVO();
		Bson filter = new Document("mcnum", vo.getMcnum());

		Document doc = MiniComments.find(filter).first();

		if (doc != null) {
			vo2.setMcnum(doc.getInteger("mcnum"));
			vo2.setMccnum(doc.getInteger("mccnum"));
			vo2.setMbnum(doc.getInteger("mbnum"));
			vo2.setId(doc.getString("id"));
			vo2.setWriter(doc.getString("writer"));
			vo2.setContent(doc.getString("content"));
			vo2.setCdate(doc.getString("cdate"));
			vo2.setSecret(doc.getInteger("secret"));
			vo2.setReport(doc.getInteger("report"));
		}

		return vo2;
	}
	
	@Override
	public int count(MiniCommentsVO vo) {
		log.info("count(vo)...{}", vo);

	    Bson filter = Filters.and(Filters.eq("id", vo.getId()), Filters.eq("mbnum", 0));

	    int count = (int) MiniComments.count(filter);
		
		return count;
	}

	@Override
	public int insert(MiniCommentsVO vo) {
		log.info("insert()...{}", vo);
		int flag = 0;
		
		try {
			// 마지막 mcnum 찾기. 없으면 0
	        Document lastDoc = MiniComments.find().sort(Sorts.descending("mcnum")).first();
	        int lastMcnum = lastDoc != null ? lastDoc.getInteger("mcnum") : 0;
			
	        // 마지막 mcnum +1
	        int newMcnum = lastMcnum + 1;
			
			Document doc = new Document();
			doc.put("mcnum", newMcnum);
			
			if(vo.getMccnum() == 0)	// 댓글일 경우
				doc.put("mccnum", 0);
			else					// 대댓글일 경우
				doc.put("mccnum", vo.getMccnum());
			
			doc.put("mbnum", vo.getMbnum());
			doc.put("id", vo.getId());
			doc.put("writer", vo.getWriter());
			doc.put("content", vo.getContent());
			doc.put("cdate", sf.format(new Date()));
			doc.put("secret", vo.getSecret());
			doc.put("report", vo.getReport());
			MiniComments.insertOne(doc);
			flag = 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	@Override
	public int update(MiniCommentsVO vo) {
		log.info("update()...{}", vo);
		int flag = 0;
		
		try {
			Bson filter = Filters.eq("mcnum", vo.getMcnum());
			
			Bson bsons = new Document("$set", 
					new Document("content", vo.getContent())
					.append("cdate", sf.format(new Date()))
					.append("secret", vo.getSecret()));
			
			UpdateResult result = MiniComments.updateOne(filter, bsons);
			log.info("result: {}", result);
			flag = 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	@Override
	public int delete(MiniCommentsVO vo) {
		log.info("delete()...{}", vo);
		int flag = 0;
		
		try {
			Bson filter = Filters.or(
					Filters.eq("mcnum", vo.getMcnum()),
					Filters.eq("mccnum", vo.getMcnum()));
			
			DeleteResult result = MiniComments.deleteMany(filter);	// minicomments 테이블에서 삭제
			log.info("result: {}", result);
			flag = (int)result.getDeletedCount();
			
			sqlSession.delete("MNG_DEL_REPORT_BY_MCNUM", vo);	// report 테이블에서 삭제
			sqlSession.delete("MC_DEL_CLIKE", vo);			// clikes 테이블에서 삭제
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	@Override
	public int report(Map<String, Object> map) {
		log.info("report()...{}", map);
		
		MiniCommentsVO vo = (MiniCommentsVO)map.get("vo");
		
		try {
			Bson filter = Filters.eq("mcnum", vo.getMcnum());
			
			Bson bsons = new Document("$set", new Document("report", 1));
			
			UpdateResult result = MiniComments.updateOne(filter, bsons);
			log.info("result: {}", result);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return sqlSession.insert("MC_REPORT", map);
	}

	@Override
	public ClikesVO is_clike(ClikesVO vo) {
		log.info("check clike()...{}", vo);
		
		return sqlSession.selectOne("MC_IS_CLIKE", vo);
	}

	@Override
	public int count_clikes(ClikesVO vo) {
		log.info("count clikes()...{}", vo);
		
		return sqlSession.selectOne("MC_COUNT_CLIKES", vo);
	}

	@Override
	public int clike(ClikesVO vo) {
		log.info("clike()...{}", vo);
		
		return sqlSession.insert("MC_CLIKE", vo);
	}

	@Override
	public int cancel_clike(ClikesVO vo) {
		log.info("cancel clike()...{}", vo);
		
		return sqlSession.delete("MC_CANCEL_CLIKE", vo);
	}

	@Override
	public void update_nickname(Map<String, String> map) {
		log.info("update nickname()...{}", map);
		
		try {
			Bson filter = Filters.eq("writer", map.get("before"));
			
			Bson bsons = new Document("$set", new Document("writer", map.get("after")));
			
			UpdateResult result = MiniComments.updateMany(filter, bsons);
			log.info("result: {}", result);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int deleteAll(MiniBoardVO vo2) {
		log.info("delete All()...{}", vo2);
		int flag = 0;
		
		try {
			Bson filter = Filters.eq("mbnum", vo2.getMbnum());
					
			FindIterable<Document> docs = MiniComments.find(filter);
			
			for(Document doc : docs) {
				log.info("{}", doc);
				MiniCommentsVO vo = new MiniCommentsVO();
				vo.setMcnum(doc.getInteger("mcnum"));
				
				sqlSession.delete("MC_DELETE_CLIKES_ALL", vo);		// 댓글 좋아요 삭제
				sqlSession.delete("MNG_DEL_REPORT_BY_MCNUM", vo);	// 댓글 신고 삭제
			}
			
			DeleteResult result = MiniComments.deleteMany(filter);	// 댓글 삭제
			log.info("result: {}", result);
			flag = 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

}
