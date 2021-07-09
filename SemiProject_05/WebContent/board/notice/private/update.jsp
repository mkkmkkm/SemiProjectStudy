<%@page import="notice.dao.NoticeDao"%>
<%@page import="notice.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int num=Integer.parseInt(request.getParameter("num"));
   String title=request.getParameter("title");
   String content=request.getParameter("content");
   
   NoticeDto dto=new NoticeDto();
   dto.setNum(num);
   dto.setTitle(title);
   dto.setContent(content);

   //3. DB 에 수정반영하고 
   boolean isSuccess=NoticeDao.getInstance().update(dto);
   //4. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/update.jsp</title>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'수정 성공',
		text: '공지 수정에 성공하였습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
		location.href="../detail.jsp?num=<%=dto.getNum()%>";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title: '수정 실패',
		text: '공지 수정에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
		location.href="updateform.jsp?num=<%=dto.getNum()%>";
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