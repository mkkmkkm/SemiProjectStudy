<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="test.cafe.dto.CafeDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/> 
<%
	/*

	
	1. 폼 전송되는 수정할 글의 번호, 제목, 내용을 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	2. CafeDto 객체를 생성해서 담는다.
	CafeDto dto=new CafeDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	*/
   
   //3. DB 에 수정반영하고 
   boolean isSuccess=CafeDao.getInstance().update(dto);
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