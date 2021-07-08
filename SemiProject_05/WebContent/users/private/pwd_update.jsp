<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session 영역에 저장된 id 읽어오기
	String id=(String)session.getAttribute("id");
	//폼 전송되는 구 비밀번호, 새 비밀번호 읽어오기
	String pwd=request.getParameter("pwd");
	String newPwd=request.getParameter("newPwd");
	//구 비밀번호가 유효한지 알아내기
	UsersDto dto = UsersDao.getInstance().getData(id);
	boolean isValid = pwd.equals(dto.getPwd());
	//비밀번호가 맞다면 dto에 새 비밀번호를 담아서 수정 반영하기
	if(isValid){
		dto.setPwd(newPwd);
		UsersDao.getInstance().updatePwd(dto);
		//로그아웃 처리하고 새로 로그인
		session.removeAttribute("id");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'수정 성공',
		text: '<%=id %>님, 로그인 되었습니다. 다시 로그인해 주세요.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
			location.href="<%=request.getContextPath()%>/users/loginform.jsp";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title: '수정 실패',
		text: '기존 비밀번호가 맞지 않습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
			location.href="<%=request.getContextPath()%>/users/private/pwd_updateform.jsp";
	  }
	})
}
</script>
	<%if(isValid){%>
	<script>
		swalSuccess();
	</script>
	<%}else{ %>
	<script>
		swalFail();
	</script>
	<%} %>

</body>
</html>