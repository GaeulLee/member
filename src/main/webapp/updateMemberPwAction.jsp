<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*"%>
<%
	// 1. 요청분석
	
	request.setCharacterEncoding("utf-8");

	String memberId = request.getParameter("memberId");
	String oldMemberPw = request.getParameter("oldMemberPw");
	String newMemberPw = request.getParameter("newMemberPw");
	String msg = null;
	
	if(request.getParameter("oldMemberPw") == null || request.getParameter("oldMemberPw").equals("") ||
		request.getParameter("newMemberPw") == null || request.getParameter("newMemberPw").equals("")){ // 이름값이 공백이나 없을 경우
		msg = URLEncoder.encode("비밀번호를 모두 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	// 2. 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println(conn + "--> updatePwAction.jsp db접속 확인");
	
	// 2-1. 비밀번호가 일치하는지 확인
	String checkSql = "SELECT member_pw FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement checkStmt = conn.prepareStatement(checkSql);
	checkStmt.setString(1, memberId);
	checkStmt.setString(2, oldMemberPw);
	ResultSet rs = checkStmt.executeQuery();
	if(rs.next()){
		System.out.println("비밀번호 일치");
	} else {
		msg = URLEncoder.encode("현재 비밀번호가 일치하지 않습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	
	// 2-2. 일치하면 비밀번호 변경
	String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, newMemberPw);
	stmt.setString(2, memberId);
	int row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("수정 성공");
		msg = URLEncoder.encode("수정되었습니다.", "utf-8");
	} else {
		System.out.println("수정 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/updateMemberPwForm.jsp?msg="+msg);
	// 3. 요청출력
%>