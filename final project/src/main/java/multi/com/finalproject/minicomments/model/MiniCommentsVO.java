package multi.com.finalproject.minicomments.model;

import lombok.Data;

@Data
public class MiniCommentsVO {
	private int mcnum;
	private int mccnum;
	private int mbnum;
	private String id;
	private String writer;
	private String content;
	private String cdate;
	private int secret;
	private int report;
}
