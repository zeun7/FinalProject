package multi.com.finalproject.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {
	
//	@Autowired
//	HttpSession session;
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, 
//			HttpServletResponse response, Object handler)
//			throws Exception {
//		log.info("preHandle()....");
//		
//		String sPath = request.getServletPath();
//		log.info("preHandle()....{}",sPath);
//		
//		String user_id = (String) session.getAttribute("user_id");
//		log.info("preHandle()....user_id : {}",user_id);
//		
//		
//		if(sPath.equals("/b_selectAll.do")
//				|| sPath.equals("/m_selectAll.do")
//				|| sPath.equals("/b_selectOne.do")
//				|| sPath.equals("/m_selectOne.do")
//				|| sPath.equals("/b_update.do")
//				|| sPath.equals("/m_update.do")
//				|| sPath.equals("/mv_insert.do")
//				|| sPath.equals("/r_selectOne.do")
//				|| sPath.equals("/r_selectAll.do")) {
//			
//			if(user_id == null) {
//				response.sendRedirect("login.do");
//				return false;
//			}
//		}
//		
//		return true;
//	}
	
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		log.info("postHandle()....");
//	}
	
}
