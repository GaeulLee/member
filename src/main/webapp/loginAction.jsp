<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="vo.Member"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("utf-8");

	// 1) 요청분석
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")){ // 아이디가 공백이거나 값이 없을 경우
		String msg = URLEncoder.encode("아이디를 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}
	if(request.getParameter("memberPw") == null ||  request.getParameter("memberPw").equals("")){ // 비밀번호가 공백이거나 값이 없을 경우
		String msg = URLEncoder.encode("비밀번호를 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// 묶어서 저장
	Member member = new Member();
	member.memberId = request.getParameter("memberId");
	member.memberPw = request.getParameter("memberPw");
		System.out.println("memberId-> "+member.memberId+", memberPw-> "+member.memberPw);

	// 2) 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println(conn + "--> db접속 성공");
	String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, member.memberId);
	stmt.setString(2, member.memberPw);
	ResultSet rs = stmt.executeQuery();
	// resultset의 실행 결과가 있다면 로그인 성공 아니면 실패
	
	/*
	if(rs.next()){ // 로그인 성공
		rs.close();
		stmt.close();
		conn.close();
		response.sendRedirect(request.getContextPath()+"/loginMemberIndex.jsp");
		return;
	} else { // 로그인 실패
		rs.close();
		stmt.close();
		conn.close();
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
		위와 같은 코드를 아래 처럼 수정 */
	String targetPage = "/loginForm.jsp";
	if(rs.next()){
		// 로그인 성공
		targetPage = "/memberIndex.jsp";
		// 로그인 성공했다는 값을 저장 -> session
		session.setAttribute("loginMemberId", rs.getString("memberId"));
		// Object loginMemberId = rs.getString("memberId");
		
		// 불러올 땐 session.getAttribute("loginMemberId") -> Object 타입을 리턴함
		// --> 따라서 String loginMemberId = (String)(session.getAttribute("loginMemberId")); 의 형태로..(다형성)
	}
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetPage);
	
%>