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
   <%if(isSuccess){ %>
   <script>
      alert("새 공지가 추가 되었습니다.");
      location.href="${pageContext.request.contextPath}/board/notice/list.jsp";
   </script>
   <%}else{ %>
   <script>
      alert("새 공지 저장 실패!");
      location.href="${pageContext.request.contextPath}/board/notice/private/insertform.jsp";
   </script>
   <%} %>
</body>
</html>




