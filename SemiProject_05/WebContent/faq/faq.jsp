<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />

<style>
   	h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
	}
	html {
	  	height: 100%;
	}

	#ccontainer{
		margin:0 auto; 
		padding:5px; 
		background-color:rgb(255,255,255, 0.9); 
		border-radius: 30px
	}
</style>
</head>
<body>
	<jsp:include page="../include/navbar.jsp">
		<jsp:param value="faq" name="thisPage"/>
	</jsp:include>
	<div class="container my-4" id="ccontainer">
		<h1 class="fw-bold my-4 text-center">자주 하는 질문</h1>
		<div class="accordion" id="accordion">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
						High clear가 무엇인가요?
					</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	배드민턴에서 가장 기초가 되는 기술이자 가장 중요한 기술입니다.<br>
			        	하이클리어는 상대방 코트 엔드라인 근처까지 솟구쳐 날아가다 엔드라인 끝에서 뚝 떨어져야 합니다.<br><br />
			        	★구사 방법 <br />
			        	<img src="../images/high-clear.jpg"/><br />
			        	라켓을 든 팔과 다른 한 쪽 팔로 삼각형 모양을 그린 뒤, 그 상태에서 그대로 오른쪽 발을 왼쪽 발 뒤로 빼고, 상체도 같이 오른쪽으로 돌린다. <br />
			        	왼쪽 팔은 셔틀콕을 가리키거나, 가슴을 펴주기 위해 왼쪽 위에 두고,오른쪽 팔은 뒤로 당겨준다. 이 때 체중을 오른쪽 다리에 실어준 후, 다시 몸을 왼쪽으로 회전시키면서 라켓을 등 뒤로 떨어트렸다가, 오른발에 실었던 체중을 앞으로 이동시키면서 스윙한다. 
					</div>
			    </div>
			</div>	
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						하이클리어 동호회에 가입하고 싶습니다. 어떻게 하면 되나요? 
					</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
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
				<h2 class="accordion-header" id="headingThree">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						배드민턴 공식 경기 일정을 알고 싶습니다. 
					</button>
		    </h2>
				<div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordion">
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
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>



