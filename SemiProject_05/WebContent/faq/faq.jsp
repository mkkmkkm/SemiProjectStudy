<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/faq.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="faq" name="thisPage"/>
	</jsp:include>
	<div class="container my-4">
		<h1 class="fw-bold my-4">자주 하는 질문</h1>
		<div class="accordion" id="accordion">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
						하이클리어 동호회에 가입하고 싶습니다. 어떻게 하면 되나요? 
					</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	우선 상단의 회원가입 버튼을 클릭하시어 하이클리어 회원이 되어 주세요!
			        	<br />
			        	정기 모임에 참가하시려면 자유게시판 글 목록의 최상단에 있는 모임 공지사항을 읽으신 후, 자유게시판에 참가 의사를 알려주시면 동호회장이 취합하여 별도 연락을 드립니다. 
			        	<br />
			        	모임 장소, 시간, 인원수는 매 회마다 다르기 때문에, 공지사항을 꼭 참고해 주세요. 
					</div>
			    </div>
			</div>	
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						배드민턴 공식 경기 일정을 알고 싶습니다. 
					</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	경기 일정은<br />
			        	대한배드민턴 협회 홈페이지 <a href="http://www.koreabadminton.org/">http://www.koreabadminton.org/</a><br />
			        	전국배드민턴대회 홈페이지 <a href="http://www.badmintongame.co.kr/">http://www.badmintongame.co.kr/</a><br />
			        	네이버, 다음 포탈 국내 배드민턴란 등에서도 확인이 가능합니다.<br /><br />
			        	또한, 저희 동호회 공지사항에도 일정을 따로 게시해 놓고 있습니다. 			        	
					</div>
			    </div>
			</div>
	
		</div>
		
	</div>

</body>
</html>



