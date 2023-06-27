package multi.com.finalproject.minihome.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MiniHomeVO {
	
	private int hnum;
	private String id;
	private String title;
	private String message;
	private String miniaddr;
	private String backimg;
	private String bgm;
	private int vtotal;
	private int vtoday;
	private MultipartFile file;
	private MultipartFile musicFile;
	private Date visit_date;
	
}