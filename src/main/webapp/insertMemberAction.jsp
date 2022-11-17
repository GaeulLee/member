<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="vo.Member"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("utf-8");

	// 1) 요청분석
	String memberName = request.getParameter("memberName");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
		System.out.println("memberId-> "+memberId+", memberPw-> "+memberPw+", memberName-> "+memberName);
	
	if(request.getParameter("memberName") == null ||  memberName.equals("")){ // 이름이 공백이거나 값이 없을 경우
		String msg = URLEncoder.encode("이름을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}	
	if(request.getParameter("memberId") == null || memberId.equals("")){ // 아이디가 공백이거나 값이 없을 경우
		String msg = URLEncoder.encode("아이디를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}
	if(request.getParameter("memberPw") == null ||  memberPw.equals("")){ // 비밀번호가 공백이거나 값이 없을 경우
			String msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
			response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
			return;
	}

	// 2) 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println(conn + "--> db접속 성공");
		
	// 2-1) 아이디 중복확인
	String idSql = "SELECT member_id FROM member WHERE member_id = ?";
	PreparedStatement idStmt = conn.prepareStatement(idSql);
	idStmt.setString(1, memberId);
	ResultSet rs = idStmt.executeQuery();
	if(rs.next()){
		String msg = URLEncoder.encode("아이디가 중복되었습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}

	// 2-2) 회원정보 등록
	String sql = "INSERT INTO member (member_id, member_pw, member_name) VALUES (?,PASSWORD(?),?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberId);
	stmt.setString(2, memberPw);
	stmt.setString(3, memberName);
	int row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("회원정보 등록 성공");
	} else {
		System.out.println("회원정보 등록 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	// 3) 요청출력
%>