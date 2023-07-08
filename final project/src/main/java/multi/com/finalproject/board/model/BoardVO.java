package multi.com.finalproject.board.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {

	private int bnum;
	private String bname;
	private String caname;
	private String writer;
	private String title;
	private String content;
	private Timestamp wdate;
	private String filepath;
	private int vcount;
	private int likes;
	private int report;
	private String reason;
	private MultipartFile file;
	private int isFileExist;
	private int ccount;
}