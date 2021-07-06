<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/popup.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>★배드민턴 용품 여름 세일★</h1>
	<p>
		<img src="<%=request.getContextPath() %>/images/badminton02.jpg" width=400px />
		<br />
		<a href="http://www.badmintonmart.com/shop/main/index.php">
			배드민턴 용품 구매하러 가기
		</a>
	</p>
	<form action="nopopup.jsp" method="post">
		<label>
		<input type="checkbox" name="isPopup" value="no"/>
		1분동안 팝업 띄우지 않기
		</label>
		<button type="submit">닫기</button>
	</form>
</div>
</body>
</html>