package multi.com.finalproject.miniboard.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

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
	private int report;
	private MultipartFile file;
	private int likes;
	private int isFileExist;
	
}