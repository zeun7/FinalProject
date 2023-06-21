package multi.com.finalproject.member.service;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import multi.com.finalproject.member.model.MemberDAO;
import multi.com.finalproject.member.model.MemberVO;
@Service
public class MemberService {
@Autowired
MemberDAO dao;

	public int insert(MemberVO vo) {
		return dao.insert(vo) ;
	}

	public int update(MemberVO vo) {
		return dao.update(vo);
	}

	public int delete(MemberVO vo) {
		return dao.delete(vo);
	}

	public List<MemberVO> selectAll() {
		return dao.selectAll();
	}

	public MemberVO selectOne(MemberVO vo) {
		return dao.selectOne(vo);
	}
	
	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}

	public List<MemberVO> searchList(String searchKey, String searchWord) {
		return dao.searchList(searchKey, searchWord);
	}

	public MemberVO idCheck(MemberVO vo) {
		return dao.idCheck(vo);
	}
	public MemberVO NickCheck(MemberVO vo) {
		return dao.NickCheck(vo);
	}

	public String find_id(HttpServletResponse response, String email) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		 String url = "jdbc:oracle:thin:@localhost:1521:xe";
		    String username = "final";
		    String password = "hi123456";

		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;

		    try {
		        Class.forName("com.mysql.jdbc.Driver");
		        conn = DriverManager.getConnection(url, username, password);

		        // 사용자 아이디 조회 쿼리
		        String query = "select id from users where email = ?";
		        pstmt = conn.prepareStatement(query);
		        pstmt.setString(1, email);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            String id = rs.getString("id");
		            return id;
		        } else {
		            out.println("<script>");
		            out.println("alert('가입된 아이디가 없습니다.');");
		            out.println("history.go(-1);");
		            out.println("</script>");
		            out.close();
		            return null;
		        }
		    } finally {
		        if (rs != null) {
		            rs.close();
		        }
		        if (pstmt != null) {
		            pstmt.close();
		        }
		        if (conn != null) {
		            conn.close();
		        }
		    }
		}
	}

