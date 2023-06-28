package multi.com.finalproject.manage.model;

import lombok.Data;

@Data
public class ReportVO {
	private int rnum;
	private int bnum;
	private int cnum;
	private int mbnum;
	private int mcnum;
	private String writer;
	private String title;
	private String content;
	private String reason;
}
