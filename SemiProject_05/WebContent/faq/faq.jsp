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
	<div class="container p-3">
		<h1>FAQ</h1>
		<div class="accordion mt-3" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
						high clear가 무엇인가요?
					</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					<div class="accordion-body">
			        	배드민턴에서 가장 기초가 되는 기술이자 가장 중요한 기술입니다.<br>
			        	하이클리어는 상대방 코트 엔드라인 근처까지 솟구쳐 날아가다 엔드라인 끝에서 뚝 떨어져야 합니다.<br>
			        	구사 방법은 라켓을 든 팔과 다른 한 쪽 팔로 삼각형 모양을 그린 뒤, 그 상태에서 그대로 오른쪽 발을 왼쪽 발 뒤로 빼고, 상체도 같이 오른쪽으로 돌린다. 
			        	왼쪽 팔은 셔틀콕을 가리키거나, 가슴을 펴주기 위해 왼쪽 위에 두고,오른쪽 팔은 뒤로 당겨준다. 이 때 체중을 오른쪽 다리에 싣어준 후, 다시 몸을 왼쪽으로 회전시키면서 라켓을 등 뒤로 떨어트렸다가, 오른발에 싣었던 체중을 앞으로 이동시키면서 스윙한다. 
					</div>
			    </div>
			</div>	
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						2
					</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					<div class="accordion-body">
			        	2
					</div>
			    </div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingThree">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						3
					</button>
		    </h2>
				<div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					<div class="accordion-body">
			        	3
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>



