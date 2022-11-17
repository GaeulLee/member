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
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>delete Member</title>
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
		<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post" class="align_middle">
			<table class="table table-borderless table-light rounded-3 shadow p-4 bg-white">
				<tr>
					<td>
						<h3><strong>회원탈퇴</strong></h3>
					</td>
				</tr>
				<!-- 메세지 출력 -->
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
					%>
						<tr>
							<td class="text-primary"> &#10069;<%=msg%></td>
						</tr>
					<%
					}
				%>
				<tr>
					<td>회원 탈퇴를 위해 현재 비밀번호를 입력해주세요.</td>
				</tr>
				<tr>
					<td><input type="password" name="memberPw" class="form-control w-75 mx-auto" placeholder="비밀번호 입력"></td>
				</tr>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-outline-primary float-start">BACK</a>
						<button type="submit" class="btn btn-outline-primary float-end">회원탈퇴</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>