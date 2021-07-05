<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
	#mainImg {
	  position: fixed; 
	  top: 56px; 
	  left: 0; 
	  opacity: 0.5;
	  /* Preserve aspet ratio */
	  min-width: 100%;
	  min-height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<img id="mainImg" src="<%=request.getContextPath()%>/images/badminton01.jpg" alt="" />

	
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
		window.open("popup.jsp","창의제목","width=420,height=420,top=100,left=200");
	</script>
<%}%>
</body>
</html>