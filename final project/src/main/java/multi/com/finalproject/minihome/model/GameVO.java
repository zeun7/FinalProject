package multi.com.finalproject.minihome.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class GameVO {
	
	private int score;
	private String id;
	private Timestamp gdate;
	
}