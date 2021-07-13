<%@page import="notice.dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// ?num=x   num 이라는 파라미터명으로 전달되는 문자열을 읽어와서 숫자로 바꾼다. 
   int num=Integer.parseInt(request.getParameter("num"));   
   NoticeDao dao=NoticeDao.getInstance();
   boolean isSuccess=dao.delete(num);
   //2. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/delete.jsp</title>
<jsp:include page="../../../include/resource.jsp"></jsp:include>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'삭제 성공',
		text: '공지 삭제에 성공하였습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
			location.href="${pageContext.request.contextPath}/board/notice/list.jsp";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title:'삭제 실패',
		text: '공지 삭제에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
			location.href="detail.jsp?num=<%=num%>";
	  }
	})
}
</script>

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





