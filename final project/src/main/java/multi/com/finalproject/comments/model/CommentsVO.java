package multi.com.finalproject.comments.model;

import java.sql.Date;

import lombok.Data;

@Data
public class CommentsVO {
	private int cnum;
	private int ccnum;
	private int bnum;
	private String writer;
	private String content;
	private Date cdate;
	private int secret;
	private int report;
	private String reason;

}
