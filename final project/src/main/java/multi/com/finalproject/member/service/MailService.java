package multi.com.finalproject.member.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import multi.com.finalproject.member.model.MemberDAO;

@Service
public interface MailService {


		/** 메일 전송
	     *  @param subject 제목
	     *  @param text 내용
	     *  @param from 보내는 메일 주소
	     *  @param to 받는 메일 주소  **/
	    public boolean send(String subject, String text, String from, String to) ;
			
	    	
	    


}