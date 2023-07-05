package multi.com.finalproject.minicomments.model;

import java.util.Date;

import lombok.Data;

@Data
public class MiniCommentsVO {
	private int mcnum;
	private int mccnum;
	private int mbnum;
	private String id;
	private String writer;
	private String content;
	private Date vdate;
	private int secret;
	private int report;
}
