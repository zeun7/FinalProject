package multi.com.finalproject.manage.model;

import lombok.Data;

@Data
public class ReportVO {
	private int rnum;
	private int bnum;
	private int cnum;
	private int ccnum;
	private int mbnum;
	private int mcnum;
	private int mccnum;
	private String id;
	private String writer;
	private String title;
	private String content;
	private String reason;
}
