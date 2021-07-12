<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@page import="notice.dao.NoticeDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="notice.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=5;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=10;
	
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
	
	//CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
	CafeDto dto=new CafeDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);

	//CafeDao 객체의 참조값 얻어와서 
	CafeDao dao=CafeDao.getInstance();
	//회원목록 얻어오기 
	List<CafeDto> list=dao.getList(dto);
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	
	//전체 row 의 갯수 
	int totalRow=dao.getCount();
	//전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다.
	
		
	NoticeDto dtoNo=new NoticeDto();
	dtoNo.setStartRowNum(startRowNum);
	dtoNo.setEndRowNum(endRowNum);
		
	NoticeDao daoNo=NoticeDao.getInstance();
	List<NoticeDto> list1=daoNo.getList(dtoNo);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<style>
	body{
		height: 100vh;
		background-image: url("images/badminton_illust_up.png"); /*2가지 이미 images/badmintonillust1.png*/
		background-repeat: no-repeat;
		background-position: center;
		background-size: cover;
	}
</style>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	
<%
	//쿠키 읽어오기
	Cookie[] cookies=request.getCookies();
	//팝업을 띄울지 여부
	boolean isPopup=true;
	if(cookies != null){
		//반복문 돌면서 저장된 쿠키를 얻어내서
		for(Cookie tmp:cookies){
			//isPopup이라는 이름으로 저장된 쿠키가 있으면
			if(tmp.getName().equals("isPopup")){
				//팝업을 띄우지 않게 한다.
				isPopup=false;
			}
		}
	}
%>
<%if(isPopup){%>
	<script>
		window.open("popup.jsp","창의제목","width=450,height=450,top=100,left=100");
	</script>
<%}%>

<div class="container mt-5">
	<div class="row">
		<div id="carouselExampleControls" class="col carousel slide" data-bs-ride="carousel">
			<div class="carousel-inner">
				 <div class="carousel-item active">
				      <img src="images/backg-Badminton.jpg" class="d-block w-100" alt="...">
				 </div>
				 <div class="carousel-item">
				      <img src="images/Badminton_name.jpg" class="d-block w-100" alt="...">
				 </div>
				 <div class="carousel-item">
				      <img src="images/badminton01.jpg" class="d-block w-100" alt="...">
				 </div>
				 <div class="carousel-item">
				      <img src="images/badminton02.jpg" class="d-block w-100" alt="...">
				 </div>
			</div>
		</div>
	<div class="row">
		<div class="col">
			<h2>공지사항</h2>
		    <table class="table table-hover">
		      <thead>
		         <tr>
		            <th>번호</th>
		            <th>제목</th>
		            <th>조회수</th>
		            <th>날짜</th>   
		         </tr>
		      </thead>
		      <tbody>
		      <%for(NoticeDto tmpN:list){%>
		         <tr>
		            <td><%=tmpN.getNum() %></td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="detail.jsp?num=<%=tmpN.getNum()%>"><%=tmpN.getTitle() %></a>
					</td>
		            <td><%=tmpN.getWriter() %></td>
		            <td><%=tmpN.getRegdate() %></td>
		            <td><%=tmpN.getViewCount() %></td>
		         </tr>
		      <%} %>
		      </tbody>
​			</table>
		</div>
		<div class="col">
			<h2>자유게시판</h2>
			<table class="table table-hover">
		      <thead>
		         <tr>
		            <th>번호</th>
		            <th>카테고리</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>날짜</th>
		            <th>조회수</th>     
		         </tr>
		      </thead>
		      <tbody>
		      <%for(CafeDto tmp:list){%>
		         <tr>
		            <td><%=tmp.getNum() %></td>
		            <td><%=tmp.getCategory() %></td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a>
						<%-- 댓글 개수 출력 --%>
						<span class="mx-2" style="color:#198754;"><%=CafeCommentDao.getInstance().getCount(tmp.getNum())%></span>
		            </td>
		            <td><%=tmp.getWriter() %></td>
		            <td><%=tmp.getRegdate() %></td>
		            <td><%=tmp.getViewCount() %></td>
		         </tr>
		      <%} %>
		      </tbody>
		   </table>
		</div>
	</div>
	<div class="row">
		갤러리
	</div>
	<div class="row">
		<div class="col">
		카드정보
		</div>
	</div>

</div>
</div>

</body>
</html>