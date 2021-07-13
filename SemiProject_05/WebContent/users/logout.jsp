<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<jsp:include page="../include/font.jsp"></jsp:include>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title: '로그아웃 성공',
		icon: 'warning',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
			location.href="<%=request.getContextPath()%>/index.jsp";
	  }
	})
}
</script>
	<script>
		swalSuccess();
	</script>
</body>
</html>