<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //한 페이지에 몇개씩 표시할 것인지
   final int PAGE_ROW_COUNT=8;
   //하단 페이지를 몇개씩 표시할 것인지
   final int PAGE_DISPLAY_COUNT=5;
   
   //보여줄 페이지의 번호를 일단 1이라고 초기값 지정
   int pageNum=1;
   //페이지 번호가 파라미터로 전달되는지 읽어와 본다.
   String strPageNum=request.getParameter("pageNum");
   //만일 페이지 번호가 파라미터로 넘어 온다면
   if(strPageNum != null){
      //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
      pageNum=Integer.parseInt(strPageNum);
   }
   
   //보여줄 페이지의 시작 ROWNUM
   int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
   //보여줄 페이지의 끝 ROWNUM
   int endRowNum=pageNum*PAGE_ROW_COUNT;
   
   //startRowNum 과 endRowNum  을 GalleryDto 객체에 담고
   GalleryDto dto=new GalleryDto();
   dto.setStartRowNum(startRowNum);
   dto.setEndRowNum(endRowNum);
   
   //GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
   List<GalleryDto> list=GalleryDao.getInstance().getList(dto);
   
   //하단 시작 페이지 번호 
   int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
   //하단 끝 페이지 번호
   int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
   
   //전체 row 의 갯수
   int totalRow=GalleryDao.getInstance().getCount();
   //전체 페이지의 갯수 구하기
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   //끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
   if(endPageNum > totalPageCount){
      endPageNum=totalPageCount; //보정해 준다. 
   }
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<style>
   .img-wrapper{
      height: 300px;
      transition: transform 0.3s ease-out;
   }
   .img-wrapper:hover{
      transform: scale(1.05);
   }   
   .card .card-text{
      /* 한줄만 text가 나오고  한줄 넘는 길이에 대해서는 ... 처리하는 css */
      display:block;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
   }
   .img-wrapper img{
   		width: 90%;
   		height: 90%;
   		object-fit: contain; 
   }
     h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
	}
	html {
	  	height: 100% !important;
	}

	#ccontainer{
		margin:0 auto; 
		padding:5px; 
		background-color:rgb(255,255,255, 0.9); 
		border-radius: 30px;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<div class="container my-4" id="ccontainer">
	<h1 class="fw-bold my-4 text-center">갤러리</h1>

   	<%-- 새 글 작성 링크 --%>
	<div class="mb-2 d-flex justify-content-end">
		<a class="link-success text-decoration-none" href="private/ajax_form.jsp">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
				<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
			</svg>
			새 사진 올리기
		</a>
	</div>
	<div class="row row-cols-1 row-cols-md-3 g-4">
		<%for(GalleryDto tmp:list){ %>
		<div class="col align-middle">
			<div class="card text-center mb-3">
				<a href="detail.jsp?num=<%=tmp.getNum() %>">
					<div class="img-wrapper d-flex justify-content-center align-items-center">
						<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" 
						onerror="this.src='${pageContext.request.contextPath}/images/frown-face.png'"/>
	               </div>
				</a>
				<div class="card-body">
					<p class="card-text fs-3 fw-bold"><%=tmp.getTitle() %></p>
					<p class="card-text">by <strong><%=tmp.getWriter() %></strong></p>
					<p><small class="text-muted" style="font-size:0.875rem;"><%=tmp.getRegdate() %></small></p>
					<p>
						<svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="me-2 bi bi-heart-fill" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
						<span class="text-muted"><%=tmp.getLikeCount()%></span>
					</p>
				</div>
			</div>
		</div>
		<%} %>
	</div>
   <div class="page-ui">
      <ul class="pagination justify-content-center">
         <%if(startPageNum != 1){ %>
            <li class="page-item">
               <a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">&lt;</a>
            </li>   
         <%}else{ %>
         	<li class="page-item disabled">
               <a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>">&lt;</a>
            </li>   
         <%} %>
         
         <%for(int i=startPageNum; i<=endPageNum ; i++){ %>
            <li class="page-item">
               <%if(pageNum == i){ %>
                  <a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
               <%}else{ %>
                  <a class="page-link" href="list.jsp?pageNum=<%=i %>"><%=i %></a>
               <%} %>
            </li>   
         <%} %>
         <%if(endPageNum < totalPageCount){ %>
            <li class="page-item">
               <a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">&gt;</a>
            </li>
         <%}else{ %>
         	<li class="page-item disabled">
               <a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>">&gt;</a>
            </li>
         <%} %>
      </ul>
   </div>
</div>


</body>
</html>




