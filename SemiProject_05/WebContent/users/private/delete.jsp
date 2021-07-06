<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//id를 읽어와서 db에서 삭제, session 영역에서 삭제
	String id = (String)session.getAttribute("id");
	boolean isDelete = UsersDao.getInstance().delete(id);
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/delete.jsp</title>
</head>
<body>
	<div class="container">
		<h1>알림</h1>
		<p>
			<%=id %>님, 회원 탈퇴 되었습니다. 
			<a href="<%=request.getContextPath()%>/index.jsp">메인으로</a>
		</p>
	</div>
</body>
</html>