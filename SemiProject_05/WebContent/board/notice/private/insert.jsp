<%@page import="notice.dao.NoticeDao"%>
<%@page import="notice.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
   //로그인된 아이디를 session 영역에서 얻어내기
   String writer=(String)session.getAttribute("id");
   //1. 폼 전송되는 글제목과 내용을 읽어와서
   String title=request.getParameter("title");
   String content=request.getParameter("content");
   //2. DB 에 저장하고
   NoticeDto dto=new NoticeDto();
   dto.setWriter(writer);
   dto.setTitle(title);
   dto.setContent(content);
   boolean isSuccess=NoticeDao.getInstance().insert(dto);
   //3. 응답하기 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/notice/private/insert.jsp</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'공지 작성 성공',
		text: '새 공지 작성에 성공하였습니다.',
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
		title: '작성 실패',
		text: '새 공지 작성에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
		location.href="${pageContext.request.contextPath}/board/notice/private/insertform.jsp";
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




