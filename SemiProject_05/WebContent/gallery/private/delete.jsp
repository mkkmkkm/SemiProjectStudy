
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. GET 방식 파라미터로 전달되는 삭제할 글번호를 읽어와서 
	int num=Integer.parseInt(request.getParameter("num"));

	//2. 삭제할 글의 작성자와 로그인 아이디가 같은지 비교를 해서 
	String writer=GalleryDao.getInstance().getData(num).getWriter();
	String id=(String)session.getAttribute("id");

	//3. 같으면 DB 에서 삭제하고 응답 
	boolean isSuccess=GalleryDao.getInstance().delete(num);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cafe/private/delete.jsp</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'삭제 성공',
		text: '글 삭제에 성공하였습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
			location.href="${pageContext.request.contextPath}/gallery/list.jsp";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title:'삭제 실패',
		text: '글 삭제에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
			location.href="${pageContext.request.contextPath}/gallery/detail.jsp?num=<%=num%>";
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

</body>
</html>