<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인필터에서 넘겨주는 url 값 읽어오기
	String url=request.getParameter("url");
	//넘어오는 값이 없다면 index로 가도록 경로구성
	if(url==null){
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/loginform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<jsp:include page="../include/font.jsp"></jsp:include>
<link href="signin.css" rel="stylesheet">
<style>
	.bd-placeholder-img{
		font-size : 1.125rem;
		text-anchor : middle;
		-webkit-user-select : none;
		-moz-user-select:none;
		user-select:none;
	}
	@media (min-width:768px){
		.bd-placeholder-img-lg{
			font-size:3.5rem;
		}
	}
	
</style>
</head>
<body class="text-center">
	<div class="container form-signin">
		<form action="login.jsp" method="post">
		<img class="mb-4" src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="100" height="100"/>
		<h1 class="h3 mb-3 fw-normal">로그인</h1>				
			<%-- url 값 전달 --%>
			<input type="hidden" name="url" value="<%=url%>"/>
			<div class="form-floating mb-2">
				<%-- id 값 전달 --%>
				<input class="form-control" type="text" name="id" id="id" />
				<label class="control-label" for="id">아이디</label>
			</div>
			<div class="form-floating">
				<%-- pwd 값 전달 --%>
				<input class="form-control" type="password" name="pwd" id="pwd"/>
				<label class="control-label" for="pwd">비밀번호</label>
			</div>
			<%-- login.jsp로 요청하는 버튼 --%>
			<button class="mt-4 w-50 btn btn-sm btn-outline-success" type="submit">로그인</button>
			<a class="mt-1 w-50 btn btn-sm btn-outline-success" href="<%=request.getContextPath()%>/">메인으로</a>	
		</form>	
	</div>

</body>
</html>