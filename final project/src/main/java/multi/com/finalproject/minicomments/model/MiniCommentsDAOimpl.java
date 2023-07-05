package multi.com.finalproject.minicomments.model;

import java.util.ArrayList;
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
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;

import lombok.extern.slf4j.Slf4j;
import multi.com.finalproject.comments.model.ClikesVO;

@Slf4j
@Repository
public class MiniCommentsDAOimpl implements MiniCommentsDAO {
	
	@Autowired
	MongoCollection<Document> MiniComments;
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<MiniCommentsVO> selectAll(MiniCommentsVO vo) {
		log.info("selectAll()...");
		
		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();
		
		Bson sort = new Document("mcnum", 1);
		Bson filter = Filters.eq("mbnum", vo.getMbnum());
				
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
			vo2.setCdate(doc.getDate("cdate"));
			vo2.setSecret(doc.getInteger("secret"));
			vo2.setReport(doc.getInteger("report"));
			
			vos.add(vo2);
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
			vo2.setCdate(doc.getDate("cdate"));
			vo2.setSecret(doc.getInteger("secret"));
			vo2.setReport(doc.getInteger("report"));
			
			vos.add(vo2);
		}
		
		return vos;
	}

	@Override
	public int insert(MiniCommentsVO vo) {
		log.info("insert()...{}", vo);
		int flag = 0;
		
		try {
			Document doc = new Document();
			doc.put("mcnum", vo.getMcnum());
			doc.put("mccnum", vo.getMccnum());
			doc.put("mbnum", vo.getMbnum());
			doc.put("id", vo.getId());
			doc.put("writer", vo.getWriter());
			doc.put("content", vo.getContent());
			doc.put("cdate", vo.getCdate());
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
					new Document("mcnum", vo.getMcnum())
					.append("mccnum", vo.getMccnum())
					.append("mbnum", vo.getMbnum())
					.append("id", vo.getId())
					.append("writer", vo.getWriter())
					.append("content", vo.getContent())
					.append("cdate", vo.getCdate())
					.append("secret", vo.getSecret())
					.append("report", vo.getReport()));
			
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
			
			DeleteResult result = MiniComments.deleteMany(filter);
			log.info("result: {}", result);
			flag = (int)result.getDeletedCount();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	@Override
	public int report(Map<String, Object> map) {
		log.info("report()...{}", map);
		
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

}
