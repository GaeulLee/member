<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1. 요청분석 (session 정보가 null이면 이 화면이 보이면 안됨)
	if(session.getAttribute("loginMemberId") == null){
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
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
	<div class="container w-50" id="verticalMiddle">
		<h3><strong>회원 페이지</strong></h3>
			<div class="text-primary"><%=(String)(session.getAttribute("loginMemberId"))%>님 반갑습니다.</div>
			<a href="<%=request.getContextPath()%>/memberOne.jsp" class="btn btn-outline-primary">내 정보</a>
			<!-- 강제로 세션을 종료 -->
			<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-primary">로그아웃</a>
	</div>
	</body>
</html>