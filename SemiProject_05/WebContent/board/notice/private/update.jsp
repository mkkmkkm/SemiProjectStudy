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