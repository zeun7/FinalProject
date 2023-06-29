package multi.com.finalproject.minicomments.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MiniCommentsVO {
	private int mcnum;
	private int mccnum;
	private int mbnum;
	private String writer;
	private String content;
	private Timestamp cdate;
	private int secret;
	private int report;
}
