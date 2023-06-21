package multi.com.finalproject.miniboard.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MiniBoardVO {
	
	private int mbnum;
	private String mbname;
	private String writer;
	private String title;
	private String content;
	private Timestamp wdate;
	private String filepath;
	
}