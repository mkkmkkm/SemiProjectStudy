<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼에서 전송되는 회원 정보 : id, pwd
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	//dto 에 담아서 db에 저장
	UsersDto dto = new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	boolean isSuccess = UsersDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup.jsp</title>
</head>
<body>
	<div class="container">
		<%if(isSuccess){ %>
			<p><%=id %>님, 회원가입 되었습니다. </p>
			<a href="<%=request.getContextPath()%>/users/loginform.jsp">로그인</a>
		<%}else{ %>
			<p>회원가입에 실패하였습니다.</p>
			<a href="<%=request.getContextPath()%>/users/signupform.jsp">다시 시도하기</a>
		<%} %>
	</div>
</body>
</html>