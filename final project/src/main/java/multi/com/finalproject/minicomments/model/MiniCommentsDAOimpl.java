package multi.com.finalproject.minicomments.model;

import java.util.ArrayList;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MiniCommentsDAOimpl implements MiniCommentsDAO {
	
	@Autowired
	MongoCollection<Document> MiniComments;
	
	@Override
	public List<MiniCommentsVO> selectAll() {
		log.info("selectAll()...");
		
		List<MiniCommentsVO> vos = new ArrayList<MiniCommentsVO>();
		
		Bson sort = new Document("mcnum", -1);
		
		FindIterable<Document> docs = MiniComments.find().sort(sort);
		
		for(Document doc : docs) {
			log.info("{}", doc);
			MiniCommentsVO vo = new MiniCommentsVO();
			vo.setMcnum(doc.getInteger("mcnum"));
			vo.setMccnum(doc.getInteger("mccnum"));
			vo.setMbnum(doc.getInteger("mbnum"));
			vo.setId(doc.getString("id"));
			vo.setWriter(doc.getString("writer"));
			vo.setContent(doc.getString("content"));
			vo.setVdate(doc.getDate("vdate"));
			vo.setSecret(doc.getInteger("secret"));
			vo.setReport(doc.getInteger("report"));
			
			vos.add(vo);
		}
		
		return vos;
	}

}
