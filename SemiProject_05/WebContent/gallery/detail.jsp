<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //자세히 보여줄 겔러리 item 번호를 읽어온다.
   int num=Integer.parseInt(request.getParameter("num"));
   //번호를 이용해서 겔러리 item 정보를 얻어온다.
   GalleryDto dto=GalleryDao.getInstance().getData(num);
   
   //로그인된 아이디 (로그인을 하지 않았으면 null 이다)
   String id=(String)session.getAttribute("id");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
   <jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<div class="container my-4">
   <div class="card mb-3">
      <img class="card-img-top" src="${pageContext.request.contextPath }<%=dto.getImagePath()%>"/>
      <div class="card-body">
         <p class="card-text"><%=dto.getTitle() %></p>
         <p class="card-text"><%=dto.getContent() %></p>
         <p class="card-text">by <strong><%=dto.getWriter() %></strong></p>
         <p><small><%=dto.getRegdate() %></small></p>
      </div>
   </div>
   <nav>
   
	<ul class="d-flex flex-row ps-0 justify-content-end" style="list-style:none;">	
		<%if(dto.getWriter().equals(id)){ %>
		<li>
			<a class="link-dark text-decoration-none mx-1" href="private/updateform.jsp?num=<%=dto.getNum()%>">수정</a>
		</li>
		<li>
			<a class="link-dark text-decoration-none mx-1" href="private/delete.jsp?num=<%=dto.getNum()%>">삭제</a>
		</li>
		<%} %>  
	</ul>

	<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
	   <%if(dto.getPrevNum()!=0){ %>
		<li>
			<a class="link-success text-decoration-none" href="detail.jsp?num=<%=dto.getPrevNum() %>">
			&lt이전글
			</a>
		</li>  
	   <%} %>
	   	<li class="mx-3">
			<a class="fw-bold link-success text-decoration-none" href="list.jsp">목록보기</a>
		</li>
	   <%if(dto.getNextNum()!=0){ %>
		<li>			   
			<a class="link-success text-decoration-none" href="detail.jsp?num=<%=dto.getNextNum() %>">
			다음글&gt	     	
	      </a>
		</li>	   
	   <%} %>  	    
	</ul>
   </nav>      
</div>
</body>
</html>

