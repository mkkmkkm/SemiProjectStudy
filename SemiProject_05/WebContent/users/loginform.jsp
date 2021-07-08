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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body class="text-center position-relative">
	<div class="position-absolute top-50 start-50 translate-middle-x">
		<form action="login.jsp" method="post">
		  <img class="m-5" src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="60" height="60"/>
          <h1 class="h3 mb-3 fw-normal">High-clear!</h1>
			<%-- url 값 전달 --%>
			<input type="hidden" name="url" value="<%=url%>"/>
			<%-- id 값 전달 --%>
			<div class="form-floating m-3">
			<input type="text" name="id" class="form-control" id="id" />
			<label for="id">ID</label>
			</div>
			<%-- pwd 값 전달 --%>
			<div class="form-floating m-3">
			<input type="password" name="pwd" class="form-control" id="pwd" />
			<label for="pwd">Password</label>
			</div>
			<%-- login.jsp로 요청하는 버튼 --%>
			<button type="submit" class="btn btn-outline-secondary">Login</button>
		</form>
	
	</div>
</body>
</html>