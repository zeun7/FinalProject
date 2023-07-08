package multi.com.finalproject.minihome.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class JukeboxVO {
	
	private String id;
	private String bgm;
	private Timestamp jdate;
	
}