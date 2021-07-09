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
<title>/users/private/info.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>

<style>
	/* 프로필 이미지 표시 */
	#profileImage{
		width: 100px;
		height: 100px;
		border: 1px solid gray;
		border-radius: 80%
	}
</style>
</head>
<body class="text-center">
	<div class="container my-4">
		<h1 class="fw-bold my-4">회원 정보</h1>
		
		<div class="profile my-3">
			<%if(dto.getProfile()==null){ %>
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
			<%}else{ %>
				<img id="profileImage" src="<%=request.getContextPath() %>
				<%=dto.getProfile()%>"/>
			<%} %>
		</div>
		<div class="id">
			<p class="fw-bold"><%=id %></p>
		</div>
		<div class="date">
			<p class="text-muted"><%=dto.getRegdate()%></p>
		</div>
		<div class="configure">
			<a class="btn btn-outline-success btn-sm" href="<%=request.getContextPath() %>/users/private/updateform.jsp">회원 정보 수정</a>
			<a class="btn btn-outline-danger btn-sm" href="javascript:swalSuccess()">회원 탈퇴</a>
		</div>

	</div>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	function swalSuccess(seq){
		Swal.fire({
			title: '회원 탈퇴',
			text: '<%=id%>님, 정말 탈퇴하시겠습니까?',
			icon: 'warning',
			confirmButtonColor: '#198754',
			confirmButtonText: '탈퇴'
		}).then((result) => {
			if (result.value) {
				location.href="delete.jsp";
		  }
		})
	}
	</script>

</body>
</html>




