<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1
	// 로그인이 되어 있을 때에는 접근 불가
	if(session.getAttribute("loginMemberId") != null){
	response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
	return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
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
		<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post" class="align_middle">
			<table class="table table-borderless table-light rounded-3 shadow p-4 bg-white">
				<tr>
					<td colspan="2">
						<h3><strong>회원가입</strong></h3>
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
					<td><input type="text" name="memberName" class="form-control w-75 mx-auto"></td>
				</tr>
				<tr>
					<td>회원 ID</td>
					<td><input type="text" name="memberId" class="form-control w-75 mx-auto"></td>
				</tr>
				<tr>
					<td>회원 PW</td>
					<td><input type="password" name="memberPw" class="form-control w-75 mx-auto"></td>
				</tr>
				<tr>
					<td colspan="2">
						<a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-outline-primary float-start">BACK</a>
						<button type="submit" class="btn btn-outline-primary float-end">회원가입</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>