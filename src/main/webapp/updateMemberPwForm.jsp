<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.Member"%>
<%@ page import="java.util.*"%>
<%
	// 1. 요청분석
	
	request.setCharacterEncoding("utf-8");
	
	// 로그인 되지 않은 상태에서는 다시 로그인창으로 돌아가게
	if(session.getAttribute("loginMemberId") == null){
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	return;
	}
	
	// 회원정보 가져오기 위해 session에 저장된 정보(loginMemberId) 가져오기
	String loginMemberId = (String)(session.getAttribute("loginMemberId"));
	
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
	
	// 3. 요청출력
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>update Member pw</title>
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
	<div class="container w-25" id="verticalMiddle">
		<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post" class="align_middle">
			<table class="table table-borderless table-light rounded-3 shadow p-4 bg-white">
				<tr>
					<td colspan="2">
						<h3><strong>비밀번호 수정</strong></h3>
					</td>
				</tr>
				<!-- 메세지 출력 -->
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
					%>
						<tr>
							<td colspan="2" class="text-primary"> &#10069;<%=msg%></td>
						</tr>
					<%
					}
				%>
				<tr>
					<td>회원 이름</td>
					<td><input type="text" name="memberName" value="<%=member.memberName%>" class="form-control w-75 mx-auto" readonly="readonly"></td>
				</tr>
				<tr>
					<td>회원 ID</td>
					<td><input type="text" name="memberId" value="<%=member.memberId%>"class="form-control w-75 mx-auto" readonly="readonly"></td>
				</tr>
				<tr>
					<td>현재 PW</td>
					<td><input type="password" name="oldMemberPw" class="form-control w-75 mx-auto" placeholder="현재 비밀번호 입력"></td>
				</tr>
				<tr>
					<td>바꿀 PW</td>
					<td><input type="password" name="newMemberPw" class="form-control w-75 mx-auto" placeholder="바꿀 비밀번호 입력"></td>
				</tr>
				<tr>
					<td colspan="2">
						<a href="<%=request.getContextPath()%>/memberOne.jsp" class="btn btn-outline-primary float-start">BACK</a>
						<button type="submit" class="btn btn-outline-primary float-end">정보수정</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>