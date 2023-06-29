package multi.com.finalproject.minicomments.model;

import org.bson.Document;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class MiniCommentsConfig {
//	@Bean
//	public MongoDatabase mongoDatabase() {
//		
//		MongoClient client = new MongoClient("FINAL", 27017);
//		MongoDatabase db = client.getDatabase("jieun");	// db name
//		log.info("Create Bean MognoDatabase...");
//		return db;
//	}
//	
//	@Bean
//	public MongoCollection<Document> MiniComments(){
//		MongoCollection<Document> collection = mongoDatabase().getCollection("minicomments");
//		log.info("Create Bean MiniComments...");
//		return collection;
//	}
}
