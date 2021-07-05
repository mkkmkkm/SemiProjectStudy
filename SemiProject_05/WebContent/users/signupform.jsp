<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signupform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
	<div class="container">
		<h1>회원 가입 폼</h1>
		<form action="singup.jsp" method="post" id="signupForm">
			<div>
				<label class="control-label" for="id">아이디</label>
				<input class="form-control" type="text" name="id" id="id" />
				<small>아이디는 5~10자 이내의 영문 소문자여야 합니다. </small>
				<div class="invalid-feedback">이 아이디는 사용할 수 없습니다.</div>
			</div>
			<div>
				<label class="control-label" for="pwd">비밀번호</label>
				<input class="form-control" type="text" name="pwd" id="pwd" />	
				<small>비밀번호는 5~10자 이내여야 합니다. </small>	
				<div class="invalid-feedback">이 비밀번호는 사용할 수 없습니다.</div>
			</div>
			<div>
				<label class="control-label" for="pwd2">비밀번호 확인</label>
				<input class="form-control" type="text" name="pwd2" id="pwd2" />	
			</div>
			<button type="submit">가입하기</button>	
		</form>
	</div>
	<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
	<script>
		//id, pwd 유효성 관리할 변수
		let isIdValid=false;
		let isPwdValid=false;
		
		//id, pwd 요소 선택
		const id=document.querySelector("#id");
		const pwd=document.querySelector("#pwd");
		
		//id input 시 실행할 함수 등록
		document.querySelector("#id").addEventListener("input",function(){
			//입력한 id value값 읽어와서 정규표현식과 일치하는지 검증
			let inputId=this.value;
			const reg_id=/^[a-z].{4,9}$/;
			if(!reg_id.text(inputId)){ //매칭되지 않으면 ajax 전송 막기
				isIdValid=false; //일치하지 않는다고 표시
				id.classList.add("is-invalid");	
				return; 
			}
			//id 검증: checkid.jsp로 ajax 전송하기  - 입력한 id값을 get 방식으로 전송
			ajaxPromise("checkid.jsp","get","inputId="+inputId)
			
		});
	</script>
</body>
</html>






