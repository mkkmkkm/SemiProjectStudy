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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container mt-5">
	<%if(isValid){ 
		//로그인 처리 : session영역에 "id" 키값으로 아이디 담기 (30분)
		session.setAttribute("id", id);
		session.setMaxInactiveInterval(60*30);
	%>
		<p><%=id %>님, 로그인 되었습니다. </p>
		<%-- 원래 페이지로 넘겨주기 : url 값  --%>
		<a href="<%=url%>">돌아가기</a>
	<%}else{ %>
		<p>아이디나 비밀번호가 일치하지 않습니다.</p>
		<%-- 인코딩된 url값 가지고 loginform으로 돌려보내기 --%>
		<a href="<%=request.getContextPath()%>/users/loginform.jsp?=<%=encodedUrl%>">다시 시도하기</a>
	<%} %>
	</div>
</body>
</html>