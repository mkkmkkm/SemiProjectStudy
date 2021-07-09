
<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
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
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
   .profile-image{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
</style>

</head>
<body>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container my-4">
	<div class="article-head mt-4">
		<div class="writerInfo1 d-flex mb-4">
			<div class="profile d-inline-flex me-2">
			<%
				UsersDto usersDto = UsersDao.getInstance().getData(dto.getWriter());
				if(usersDto.getProfile()==null){
			%>	
				<svg class="profile-image" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>			
			<%}else{ %>
				<img class="profile-image" src="<%=request.getContextPath() %><%=usersDto.getProfile()%>"/>
			<%} %>
			</div>
			<div class="writerInfo2 d-flex flex-column">
				<p class="writer fw-bold mb-0"> 
					<%=dto.getWriter() %>
				</p>				
				<p class="date text-muted mb-0">
					<%=dto.getRegdate() %>
				</p>
			</div>
		</div>

		<div class="title mt-3 mb-3">
			<h2 class="fw-bold">
				<%=dto.getTitle() %>
			</h2>
		</div>
		<div class="view mb-5">
			<span class="mr-1 text-muted">조회수</span>
			<span class="fw-bold"><%=dto.getViewCount() %></span>
		</div>
		<div class="mainContent my-5">
			<%=dto.getContent() %>
		</div>
	</div>

	<ul class="d-flex flex-row ps-0 justify-content-end" 
	style="list-style:none;">
	<%if(dto.getWriter().equals(id)){ %>
		<li>
			<a class="link-dark text-decoration-none mx-1" href="private/updateform.jsp?num=<%=dto.getNum()%>">
        		 수정
			</a>
         </li>
		<li>
			<a class="link-dark text-decoration-none mx-1" href="private/delete.jsp?num=<%=dto.getNum()%>">
				삭제
			</a>
		</li>
      <%} %>	
	</ul> 
	<p class="mx-3">
		<a class="fw-bold link-success text-decoration-none" href="list.jsp">
			 목록보기
		</a>
	</p>
</div>
</body>
</html>


