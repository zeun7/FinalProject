package multi.com.finalproject.minihome.model;

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
	private MultipartFile file;
}