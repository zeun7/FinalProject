package multi.com.finalproject;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
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
				|| sPath.equals("/selectOne.do")
				|| sPath.equals("/mini_home.do")
				){
			
			if(user_id == null) {
				response.sendRedirect("login.do");
				return false;
			}
		}
		
		return true;
	
	}
//	@Override
//    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//    		
//    	log.info("interceptor postHandel");
//        HttpSession httpSession = request.getSession();
//        ModelMap modelMap = modelAndView.getModelMap();
//        Object memberVO =  modelMap.get("member");
//        
//        
//        if (memberVO != null) {
//            log.info("new login success");
//            httpSession.setAttribute(LOGIN, memberVO);
//           // response.sendRedirect("/board/list");
//            if(request.getParameter("useCookie")!=null) {
//            	log.info("remember me...");
//            	Cookie loginCookie = new Cookie("loginCookie",httpSession.getId());
//            	loginCookie.setPath("/");
//            	loginCookie.setMaxAge(60*60*24*7);
//            	response.addCookie(loginCookie);
//            }
//            
//            Object destination = httpSession.getAttribute("destination");
//            Object URL = httpSession.getAttribute("URL");
//            response.sendRedirect(destination != null ? (String) destination : (String) URL);
//        }
//
//    }
}