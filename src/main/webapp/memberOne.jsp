<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.Member"%>
<%@ page import="java.util.*"%>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null){
	// 로그인 되지 않은 상태
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}

	//회원정보 가져오기 위해 session에 저장된 정보(loginMemberId) 가져오기
	String loginMemberId = (String)(session.getAttribute("loginMemberId"));
		System.out.println("loginMemberId--> "+loginMemberId);
	// 2. 요청처리
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		System.out.println(conn + "--> updateAction.jsp db접속 확인");
	String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, loginMemberId);
	ResultSet rs = stmt.executeQuery();
	
	Member member = null;
	if(rs.next()){
		member = new Member();
		member.memberId = rs.getString("memberId");
		member.memberName = rs.getString("memberName");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login Form</title>
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			table{
				text-align: center;
			}
			#verticalMiddle{
			    position: absolute;
			    top: 40%;
			    left: 50%;
			    transform: translate(-50%, -50%);
			}
		</style>
	</head>
	<body>
	<div class="container w-50">
		<table class="table table-borderless">
			<tr>
				<td colspan="2">
					<h3><strong>내 정보</strong></h3>
				</td>
			</tr>
			<tr>
				<td>회원 이름</td>
				<td><%=member.memberName%></td>
			</tr>
			<tr>
				<td>회원 ID</td>
				<td><%=member.memberId%></td>
			</tr>
			<tr>
				<td colspan="2">		
					<a href="<%=request.getContextPath()%>/memberIndex.jsp" class="btn btn-outline-primary">BACK</a>
					<a href="<%=request.getContextPath()%>/updateMemberForm.jsp" class="btn btn-outline-primary">회원정보 수정</a>
					<!-- updateMemberAction.jsp 비밀번호수정은 안됨-->
					<a href="<%=request.getContextPath()%>/updateMemberPwForm.jsp" class="btn btn-outline-primary">비밀번호 수정</a>
					<!-- updateMemberPwAction.jsp 수정전 비밀번호, 변경할 비밀번호를 입력받아야 함-->
					<a href="<%=request.getContextPath()%>/deleteMemberForm.jsp" class="btn btn-outline-primary">회원 탈퇴</a>
					<!-- deleteMemberAction.jsp 비밀번호 확인 후 삭제 후 session.invalidatemem()-->
				</td>
			</tr>
		</table>
	</div>
	</body>
</html>