<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//id 읽어와서 가입 정보 얻기
	String id = (String)session.getAttribute("id");
	UsersDto dto = UsersDao.getInstance().getData(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/info.jsp</title><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
	/* 프로필 이미지 표시 */
	#profileImage{
		width: 100px;
		height: 100px;
		border: 1px solid gray;
		border-radius: 80%
	}
</style>
</head>
<body>
	<div class="container pt-5">
		<h1>회원 정보</h1>
		<table class="table">
			<tr style="height:38px; line-height:38px;border-top:2px solid #7d7d7d;border-bottom:1px solid #e6e6e6;">
				<th>아이디</th>
				<td><%=id %></td>
			</tr>
			<tr>
				<th>프로필 이미지</th>
				<td>
					<%if(dto.getProfile()==null){ %>
						<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
							<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
							<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
						</svg>
					<%}else{ %>
						<img id="profileImage" src="<%=request.getContextPath() %>
						<%=dto.getProfile()%>"/>
					<%} %>
				</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><%=dto.getRegdate()%></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath() %>/users/private/updateform.jsp">회원 정보 수정하기</a>
		<a href="javascript:deleteConfirm()">회원 탈퇴하기</a>
	</div>
	<script>
		function deleteConfirm(){
			const isDelete = confirm("<%=id%>님, 정말 탈퇴하시겠습니까?");
			if(isDelete){ //회원 탈퇴 시 delete.jsp로 요청
				location.href="delete.jsp";
			}
		}
	</script>
</body>
</html>




