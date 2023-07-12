package multi.com.finalproject.member.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {

	private String id;
	private String pw;
	private String nickname;
	private String profilepic;
	private String question;
	private String answer;
	private String miniaddr;
	private String name;
	private String tel;
	private String email;
	private int peach;
	private int mclass;
	private MultipartFile m_file;
	public boolean isUseCookie ;
	public String verification_code;
	
}