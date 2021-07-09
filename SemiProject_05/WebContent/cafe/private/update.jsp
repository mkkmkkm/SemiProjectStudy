<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="test.cafe.dto.CafeDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/> 
<%

  boolean isSuccess=CafeDao.getInstance().update(dto);

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
		text: '글 수정에 성공하였습니다.',
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
		text: '글 수정에 실패하였습니다.',
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