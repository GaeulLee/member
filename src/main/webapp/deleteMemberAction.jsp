<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%
	// 1. 요청분석
	
	request.setCharacterEncoding("utf-8");

	String loginMemberId = (String)(session.getAttribute("loginMemberId")); //회원정보 가져오기 위해 session에 저장된 정보(loginMemberId) 가져오기
	String memberPw = request.getParameter("memberPw");
	String msg = null;
	
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")){ // 이름값이 공백이나 없을 경우
		msg = URLEncoder.encode("비밀번호를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 2. 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println(conn + "--> deleteAction.jsp db접속 확인");
	
	// 2-1. 비밀번호가 일치하는지 확인
	String checkSql = "SELECT member_pw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement checkStmt = conn.prepareStatement(checkSql);
	checkStmt.setString(1, loginMemberId);
	checkStmt.setString(2, memberPw);
	ResultSet rs = checkStmt.executeQuery();
	if(rs.next()){
		System.out.println("비밀번호 일치");
	} else {
		msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 2-2. 일치하면 회원정보 삭제
	String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, loginMemberId);
	stmt.setString(2, memberPw);
	int row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("삭제 성공");
	} else {
		System.out.println("삭제 실패");
	}
	
	session.invalidate(); // 삭제 후 세션 종료
	
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	// 3. 요청출력
%>