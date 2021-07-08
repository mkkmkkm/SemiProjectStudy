
<%@page import="notice.dao.NoticeDao"%>
<%@page import="notice.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
   //자세히 보여줄 글번호를 읽어온다. 
   int num=Integer.parseInt(request.getParameter("num"));
	//조회수 올리기
	NoticeDao.getInstance().addViewCount(num);
   //글하나의 정보를 DB 에서 불러온다. 
   NoticeDto dto=NoticeDao.getInstance().getData(num);
   //글정보를 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/board/notice/private/detail.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container pt-5">
   <h1>공지사항</h1>
   <table class="table">
   	  <tr style="height:38px; line-height:38px;border-top:2px solid #7d7d7d;border-bottom:1px solid #e6e6e6;">
         <th scope="row">제목</th>
         <td><%=dto.getTitle() %></td>
      </tr>
      <tr style="display:none;">
         <th scope="row">글번호</th>
         <td><%=dto.getNum() %></td>
      </tr>
      <tr>
         <th scope="row">작성자</th>
         <td><%=dto.getWriter() %></td>
      </tr>
      <tr>
         <th scope="row">조회수</th>
         <td><%=dto.getViewCount() %></td>
      </tr>
      <tr>
         <th scope="row">등록일</th>
         <td><%=dto.getRegdate() %></td>
      </tr>
      <tr>
         <td colspan="2" scope="row"><textarea class="form-control"><%=dto.getContent() %></textarea></td>
      </tr>
   </table>
   	  <div><a href="list.jsp">목록으로 가기</a></div>
      <ul>
      <%if(dto.getWriter().equals(id)){ %>
         <li><a href="private/updateform.jsp?num=<%=dto.getNum()%>">수정</a></li>
         <li><a href="private/delete.jsp?num=<%=dto.getNum()%>">삭제</a></li>
      <%} %>
      
   </ul>
</div>
</body>
</html>


