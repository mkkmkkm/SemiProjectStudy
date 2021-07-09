<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<jsp:include page="include/icon.jsp"></jsp:include>
<style>

	body{
		height: 100vh;
		background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url("images/badminton01.jpg");
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
		window.open("popup.jsp","창의제목","width=450,height=480,top=100,left=100");
	</script>
<%}%>

</body>

</html>