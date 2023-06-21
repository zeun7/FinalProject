package multi.com.finalproject.board.model;

import java.sql.Timestamp;

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
}
