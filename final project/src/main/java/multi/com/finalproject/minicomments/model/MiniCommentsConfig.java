package multi.com.finalproject.minicomments.model;

import org.bson.Document;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class MiniCommentsConfig {
	@Bean
	public MongoDatabase mongoDatabase() {
		String connectionString = "mongodb://back11_01:hi123456!@h8rgi.pub-vpc.mg.naverncp.com:17017/admin?readPreference=primary&directConnection=true";

		MongoClientURI uri = new MongoClientURI(connectionString);
		MongoClient client = new MongoClient(uri);
		MongoDatabase db = client.getDatabase("admin");//db name
		log.info("Create Bean MongoDatabase...admin");
		return db;
	}
	
	@Bean
	public MongoCollection<Document> MiniComments(){
		MongoCollection<Document> collection = mongoDatabase().getCollection("miniComments");
		log.info("Create Bean MiniComments...");
		return collection;
	}
}
