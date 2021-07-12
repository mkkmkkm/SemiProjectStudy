<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼에서 전송되는 회원 정보 : id, pwd
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	//dto 에 담아서 db에 저장
	UsersDto dto = new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	boolean isSuccess = UsersDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup.jsp</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'회원가입 성공',
		text: '<%=id %>님, 회원가입 되었습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '로그인'
	}).then((result) => {
		if (result.value) {
		<%-- 원래 페이지로 넘겨주기 : url 값  --%>
		location.href="<%=request.getContextPath()%>/users/loginform.jsp";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title: '회원가입 실패',
		text: '회원가입에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
		<%-- 인코딩된 url값 가지고 loginform으로 돌려보내기 --%>
		location.href="<%=request.getContextPath()%>/users/signupform.jsp";
	  }
	})
}
</script>
	<div class="container">
		<%if(isSuccess){ %>
		<script>
			swalSuccess();
		</script>			
		<%}else{ %>
		<script>
			swalFail();
		</script>
		<%} %>
	</div>
</body>
</html>