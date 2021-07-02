<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   // isPopup 이라는 파라미터명으로 넘어오는 값이 있는지 읽어와 본다. 
   String isPopup=request.getParameter("isPopup");
   //만일 null 이 아니면 팝업을 띄우지 않겠다고 체크 한것이다.
   if(isPopup != null){
      //팝업을 일정시간 띄우지 않겠다는 정보를 쿠키에 저장한다.
      Cookie cook=new Cookie("isPopup", isPopup);
      cook.setMaxAge(60);//초단위
      //응답할때 쿠키도 같이 응답한다. 
      response.addCookie(cook);
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nopopup.jsp</title>
</head>
<body>
	nopopup.jsp 페이지
	<script>
		//팝업창 닫기
		self.close();
	</script>
</body>
</html>