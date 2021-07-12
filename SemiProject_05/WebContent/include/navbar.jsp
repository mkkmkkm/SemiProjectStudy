<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>/navbar.jsp</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
	.profileImage{
		border-radius: 50%;
		width:30px;
		height:30px;
	}
</style>
<%
	//thisPage 파라미터 명으로 전달되는 문자열 읽어오기
	String thisPage = request.getParameter("thisPage");
	//null 이면 빈 문자열 대입
	if(thisPage==null){
		thisPage="";
	}	
	//로그인 된 아이디 읽어오기
	String id = (String)session.getAttribute("id");
	UsersDto dto = new UsersDto();
	if(id!=null){ //id가 null이 아니면 db에서 가입 정보 얻어오기
		dto=UsersDao.getInstance().getData(id);
	}
	//로그인필터에서 넘겨주는 url 값 읽어오기
	String url=request.getParameter("url");
	//넘어오는 값이 없다면 index로 가도록 경로구성
	if(url==null){
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
%>
	<div class="container2 d-flex justify-content-end align-items-center" style="background-color: #014618;">
		<%if(id==null){ %>
				<a class="btn btn-outline-light btn-sm m-1" 
				href="<%=request.getContextPath()%>/users/signupform.jsp">
					회원가입
				</a>
				<a class="btn btn-outline-warning btn-sm m-1" 
				href="<%=request.getContextPath()%>/users/loginform.jsp">
					로그인
				</a>
			<%}else{ %>
				<div>
					<%if(dto.getProfile()==null) {%>
						<svg class="me-2 profileImage" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle me-2" viewBox="0 0 16 16">
							<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
							<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
						</svg>
					<%}else{ %>
						<img class="me-2 profileImage" 
						src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
					<%} %>
				</div>
				<span class="navbar-text me-2" style="color:#ffffff;">
					<a class="text-decoration-none" href="${pageContext.request.contextPath}/users/private/info.jsp" >
						<%=id %>
					</a>님 로그인 중 
				</span>
					<a class="btn btn-danger btn-sm m-2" href="${pageContext.request.contextPath}/users/logout.jsp">
					로그아웃
				</a>
			<%} %>
		</div>
	<nav class="navbar navbar-light navbar-expand-sm " style="background-color: #ffffff;">
		<div class="container">
			<a class="navbar-brand me-5 " href="<%=request.getContextPath()%>/">
				<img src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="30" height="30"/>
				High-clear!
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse me-5" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item me-5">
					<a class="nav-link <%=thisPage.equals("") ? "active" : "" %>" href="<%=request.getContextPath() %>/">홈</a>
				</li>
				<li class="nav-item me-5">
					<a class="nav-link <%=thisPage.equals("club") ? "active" : "" %>" href="<%=request.getContextPath() %>/info/aboutClub.jsp">소개</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 <%=thisPage.equals("notice") ? "active" : "" %>" href="<%=request.getContextPath() %>/board/notice/list.jsp">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 <%=thisPage.equals("cafe") ? "active" : "" %>" href="<%=request.getContextPath() %>/cafe/list.jsp">자유게시판</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 <%=thisPage.equals("gallery") ? "active" : "" %>" href="<%=request.getContextPath() %>/gallery/list.jsp">갤러리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 <%=thisPage.equals("faq") ? "active" : "" %>" href="<%=request.getContextPath() %>/faq/faq.jsp">FAQ</a>
				</li>
			</ul>
			</div>
      </div>
   </nav>
	<a class="text-decoration-none" href="javascript: window.scrollTo(0,0);"
		style="cursor:pointer;
		position:fixed;
		right: 2%;
		bottom: 5px;
		z-index: 9999;
		color:#198754;">
		<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-up-circle" viewBox="0 0 16 16">
			<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
		</svg>
   </a>
<jsp:include page="resource.jsp"></jsp:include>
<jsp:include page="font.jsp"></jsp:include>


