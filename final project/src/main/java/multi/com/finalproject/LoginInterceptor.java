package multi.com.finalproject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	HttpSession session;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler )
			throws Exception {
		log.info("preHandle()....");
		
		String sPath = request.getServletPath();
		log.info("preHandle()....{}",sPath);
		
		String user_id = (String) session.getAttribute("user_id");
		log.info("preHandle()....user_id : {}",user_id);
		
		
		if(sPath.equals("/selectAll.do")
				|| sPath.equals("/selectOne.do") //
				//minihome
				|| sPath.equals("/mini_home.do") // 미니홈피
				|| sPath.equals("/mini_game.do") // 게임
				|| sPath.equals("/mini_jukebox.do") // 쥬크박스
				|| sPath.equals("/mini_peachPay.do") // Peach 결제하기 페이지
				|| sPath.equals("/json_peachPay.do") // Peach 구매
				|| sPath.equals("/musicPay_selectAll.do") // Peach 결제
				|| sPath.equals("/json_jukebox_check.do") // jukebox에 보유했는지 체크
				|| sPath.equals("/musicPay_selectOne.do") // jukebox에 보유했는지 체크
				|| sPath.equals("/json_jukebox_insertOK.do") // 음악 구매
				//miniboard
				|| sPath.equals("/select_mb_deleteOK.do") // mb 선택삭제
				|| sPath.equals("/diary_insertOK.do") // mb 입력
				|| sPath.equals("/diary_updateOK.do") // mb 수정
				|| sPath.equals("/diary_deleteOK.do") // mb 삭제
				|| sPath.equals("/json_mb_like.do") // mb 좋아요
				|| sPath.equals("/json_mb_like_delete.do") // mb 좋아요 취소
				|| sPath.equals("/mb_reportOK.do") // mb 신고
				//minicomments
				|| sPath.equals("/json_mc_insertOK.do") // 댓글 입력
				|| sPath.equals("/json_mc_updateOK.do") // 댓글 수정
				|| sPath.equals("/json_mc_deleteOK.do") // 댓글 삭제
				|| sPath.equals("/json_mc_clike.do") // 댓글 좋아요
				|| sPath.equals("/json_mc_cancel_clike.do") // 댓글 좋아요 취소
				|| sPath.equals("/mc_reportOK.do") // 댓글 신고
				//member
				|| sPath.equals("/m_selectOne.do") // 회원정보  
				|| sPath.equals("/m_update.do") // 회원정보 수정
				|| sPath.equals("/m_deleteOK.do") // 회원탈퇴
				|| sPath.equals("/m_friends.do") // 친구목록
				//board
				|| sPath.equals("/b_insert.do") // 게시판 입력
				|| sPath.equals("/b_update.do") // 게시판 수정
				|| sPath.equals("/b_deleteOK.do") // 게시판 삭제
				|| sPath.equals("/json_b_like.do") // 게시판 좋아요
				|| sPath.equals("/json_b_like_delete.do") // 게시판 좋아요 취소
				|| sPath.equals("/b_reportOK.do") // 게시판 신고
				//comments
				|| sPath.equals("/json_c_insertOK.do") // 댓글 입력
				|| sPath.equals("/json_c_updateOK.do") // 댓글 수정
				|| sPath.equals("/json_c_deleteOK.do.do") // 댓글 삭제
				|| sPath.equals("/c_reportOK.do") // 댓글 신고 
				|| sPath.equals("/json_c_clike.do") // 댓글 좋아요
				|| sPath.equals("/json_c_cancel_clike.do") // 댓글 좋아요 취소 
				){
			
			if(user_id == null || user_id.isBlank()) {
				response.sendRedirect("login.do");
				return false;
			}
		}
		
		return true;
	
	}
}
