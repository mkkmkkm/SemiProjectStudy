<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<nav class="navbar navbar-dark navbar-expand-sm" style="background-color: #198754">
		<div class="container">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/">
				<img src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="20" height="20"/>
				High-clear!
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
					<a class="nav-link <%=thisPage.equals("") ? "active" : "" %>" href="<%=request.getContextPath() %>/">홈</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <%=thisPage.equals("notice") ? "active" : "" %>" href="<%=request.getContextPath() %>/board/notice/list.jsp">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <%=thisPage.equals("cafe") ? "active" : "" %>" href="<%=request.getContextPath() %>/cafe/list.jsp">자유게시판</a>
				</li>
				<li class="nav-item">
					<a class="nav-link <%=thisPage.equals("faq") ? "active" : "" %>" href="<%=request.getContextPath() %>/faq/faq.jsp">FAQ</a>
				</li>
			</ul>
			<%if(id==null){ %>
				<a class="btn btn-outline-light btn-sm me-2" 
				href="<%=request.getContextPath()%>/users/signupform.jsp">
					회원가입
				</a>
				<a class="btn btn-outline-light btn-sm me-2" 
				data-bs-toggle="modal" data-bs-target="#loginModal">
					로그인
				</a>
			<%}else{ %>
				<%if(dto.getProfile()==null) {%>
					<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle me-2" viewBox="0 0 16 16">
						<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
						<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
					</svg>
				<%}else{ %>
					<img class="me-2" id="profileImage" 
					src="<%=request.getContextPath() %><%=dto.getProfile() %>" width="50" height="50" />
				<%} %>
				<span class="navbar-text me-2">
					<a href="${pageContext.request.contextPath}/users/private/info.jsp">
						<%=id %>
					</a>님 로그인 중
				</span>
				<a class="btn btn-light btn-sm me-2" href="${pageContext.request.contextPath}/users/logout.jsp">
					로그아웃
				</a>
			<%} %>
			</div>
      </div>
   </nav>
	<a class="topBtn" href="javascript: window.scrollTo(0,0);"
		style="cursor:pointer;
		position:fixed;
		right: 2%;
		bottom: 5px;
		z-index: 9999;
		color:#198754;">
		<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-caret-up-fill" viewBox="0 0 16 16">
		  <path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
		</svg>
   </a>
<jsp:include page="resource.jsp"></jsp:include>
<jsp:include page="font.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>

<!-- Modal -->
<div class="text-center modal fade" id="loginModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			
			<form id="submitForm" action="../users/login.jsp" method="post">
				<div class="modal-body">				
					<%-- url 값 전달 --%>
					<input type="hidden" name="url" value="<%=url%>"/>
					<div class="form-floating mb-3">
						<%-- id 값 전달 --%>
						<input class="form-control" type="text" name="id" id="id" />
						<label class="control-label" for="id">ID</label>
					</div>
					<div class="form-floating mb-3">
						<%-- pwd 값 전달 --%>
						<input class="form-control" type="password" name="pwd" id="pwd"/>
						<label class="control-label" for="pwd">Password</label>
					</div>
					<%-- login.jsp로 요청하는 버튼 --%>
					<button id="submitBtn" type="submit" class="mt-4 w-50 btn btn-outline-success">로그인</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
	document.querySelector("#submitBtn").addEventListener("click",function(e){
		e.preventDefault();
		let modal=new bootstrap.Modal(document.querySelector("#loginModal"));
		ajaxFormPromise(document.querySelector("submitForm"))
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			if(data.isValid){
				alert("로그인 되었습니다.");
				modal.hide();
			}else{
				modal.hide();
			}
		});
	});
</script>





