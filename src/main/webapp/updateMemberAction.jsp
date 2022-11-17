<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="vo.Member"%>
<%@ page import="java.util.*"%>
<%
	// 1. 요청분석
	
	request.setCharacterEncoding("utf-8");

	String memberName = request.getParameter("memberName");
	String memberId = request.getParameter("memberId");
	String msg = null;
	
	if(request.getParameter("memberName") == null || request.getParameter("memberName").equals("")){ // 이름값이 공백이나 없을 경우
		msg = URLEncoder.encode("이름을 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	// 2. 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println(conn + "--> updateAction.jsp db접속 확인");
	String sql = "UPDATE member SET member_name=? WHERE member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, memberName);
	stmt.setString(2, memberId);
	int row = stmt.executeUpdate();
	
	if(row == 1){
		System.out.println("수정 성공");
		msg = URLEncoder.encode("수정되었습니다.", "utf-8");
	} else {
		System.out.println("수정 실패");
	}
	
	response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
	// 3. 요청출력
%>