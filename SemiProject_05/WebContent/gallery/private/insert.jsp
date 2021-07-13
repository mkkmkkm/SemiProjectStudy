<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //폼 전송되는 imagePath 와 caption 을 추출해서 DB 에 저장하고
   String imagePath=request.getParameter("imagePath");
   String title=request.getParameter("title");
   String content=request.getParameter("content");
   //업로드 아이디
   String id=(String)session.getAttribute("id");
   
   GalleryDto dto=new GalleryDto();
   dto.setImagePath(imagePath);
   dto.setTitle(title);
   dto.setContent(content);
   dto.setWriter(id);
   
   boolean isSuccess=GalleryDao.getInstance().insert(dto);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'작성 성공',
		text: '새 글 작성에 성공하였습니다.',
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
		title:'작성 실패',
		text: '새 글 작성에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
			location.href="${pageContext.request.contextPath}/gallery/private/ajax_form.jsp";
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