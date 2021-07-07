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
</head>
<body>
	<div class="container">
		<form action="login.jsp" method="post">
			<%-- url 값 전달 --%>
			<input type="hidden" name="url" value="<%=url%>"/>
			<%-- id 값 전달 --%>
			<input type="text" name="id" id="id" />
			<label for="id">ID</label>
			<%-- pwd 값 전달 --%>
			<input type="password" name="pwd" id="pwd"/>
			<label for="pwd">Password</label>
			<%-- login.jsp로 요청하는 버튼 --%>
			<button type="submit">Log-in</button>
		</form>
	
	</div>
</body>
</html>