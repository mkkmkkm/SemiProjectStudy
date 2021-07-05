<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	CafeDto dto=new CafeDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	boolean isSuccess=CafeDao.getInstance().update(dto);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/free/update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
			<script>
				alert("수정했습니다.");
				location.href="../detail.jsp?num=<%=dto.getNum()%>";
			</script>
		<%}else{ %>
			<h1>알림</h1>
			<p>
				글 수정 실패!
				<a href="updateform.jsp?num=<%=dto.getNum()%>">다시 시도</a>
			</p>
		<%} %>
</body>
</html>