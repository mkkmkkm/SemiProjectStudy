<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//input hidden으로 넘어오는 url 값 읽어오기
	String url=request.getParameter("url");
	//로그인 실패 시 사용할 인코딩된 목적지
	String encodedUrl=URLEncoder.encode(url);
	
	//폼 전송된 id, pwd 읽어오기
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	//dto에 저장하고 db에서 실제 존재하는지 확인
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	boolean isValid = UsersDao.getInstance().isValid(dto);
	//존재하면 로그인 처리 / 존재하지 않으면 id나 pwd가 틀렸다고 응답
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/login.jsp</title>
<jsp:include page="../include/font.jsp"></jsp:include>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'로그인 성공',
		text: '<%=id %>님, 로그인 되었습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
		<%-- 원래 페이지로 넘겨주기 : url 값  --%>
		location.href="<%=url%>";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title: '로그인 실패',
		text: '아이디나 비밀번호가 일치하지 않습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
		<%-- 인코딩된 url값 가지고 loginform으로 돌려보내기 --%>
		location.href="<%=request.getContextPath()%>/users/loginform.jsp?=<%=encodedUrl%>";
	  }
	})
}
</script>
	<%if(isValid){ 
		//로그인 처리 : session영역에 "id" 키값으로 아이디 담기 (30분)
		session.setAttribute("id", id);
		session.setMaxInactiveInterval(60*30);
	%>
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


