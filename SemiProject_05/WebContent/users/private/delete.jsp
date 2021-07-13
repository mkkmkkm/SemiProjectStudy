<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//id를 읽어와서 db에서 삭제, session 영역에서 삭제
	String id = (String)session.getAttribute("id");
	boolean isDelete = UsersDao.getInstance().delete(id);
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'회원 탈퇴 성공',
		text: '<%=id %>님, 회원 탈퇴 되었습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
		<%-- 원래 페이지로 넘겨주기 : url 값  --%>
		location.href="<%=request.getContextPath()%>/index.jsp";
	  }
	})
}
</script>
	<%if(isDelete){ %>
	<script>
		swalSuccess();
	</script>
	<%} %>
</body>
</html>