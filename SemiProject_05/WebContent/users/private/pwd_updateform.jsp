<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<link href="../signin.css" rel="stylesheet">
<style>
	.bd-placeholder-img{
		font-size : 1.125rem;
		text-anchor : middle;
		-webkit-user-select : none;
		-moz-user-select:none;
		user-select:none;
	}
	@media (min-width:768px){
		.bd-placeholder-img-lg{
			font-size:3.5rem;
		}
	}
</style>
</head>
<body class="text-center">
	<div class="container form-signin my-4">
		<h1 class="fw-bold my-4">비밀번호 수정</h1>
		<form action="pwd_update.jsp" method="post" id="myForm">
			<div class="form-floating">
				<input class="form-control" type="password" name="pwd" id="pwd" />
				<label class="control-label" for="pwd">기존 비밀번호</label>
			</div>
			<div class="form-floating">				
				<input class="form-control" type="password" name="newPwd" id="newPwd" />
				<label class="control-label" for="newPwd">새 비밀번호</label>
				<small>비밀번호는 5~10자 이내여야 합니다. </small>	
				<div class="invalid-feedback">이 비밀번호는 사용할 수 없습니다.</div>
			</div>
			<div class="form-floating">			
				<input class="form-control" type="password" name="newPwd2" id="newPwd2" />
				<label class="control-label" for="newPwd2">새 비밀번호 확인</label>
			</div>
			<div class="my-4">
				<button class="me-2 btn btn-outline-success btn-sm" type="submit">수정</button>
				<button class="btn btn-outline-danger btn-sm" type="reset">내용 지우기</button>
			</div>
		</form>
	</div>
	<script>
		let isPwdValid=false;	
		const pwd1=document.querySelector("#newPwd");
		const pwd2=document.querySelector("#newPwd2");
		

		//newPwd, newPwd2 일치 확인하는 함수
		function checkPwd(){
			//pwd 에 부여된 class 초기화 
			document.querySelector("#newPwd").classList.remove("is-invalid");
			document.querySelector("#newPwd").classList.remove("is-valid");
			//5~10글자 검증하는 정규표현식 
			const reg_pwd=/^.{5,10}$/;
			if(!reg_pwd.test(pwd1.value)){ //정규표현식에 맞지 않으면 invalid
				isPwdValid=false;
				pwd1.classList.add("is-invalid");
				return;
			}
			if(pwd1.value!=pwd2.value){ //확인란과 일치하지 않으면 invalid
				isPwdValid=false;
				pwd1.classList.add("is-invalid");
			}else{
				isPwdValid=true;
				pwd1.classList.remove("is-invalid");
				pwd1.classList.add("is-valid");
			}
		}
		//pwd, pwd2에 input 이벤트 발생 시 함수 등록하기
		pwd1.addEventListener("input", checkPwd);
		pwd2.addEventListener("input", checkPwd);
		
		//폼에 submit 이벤트가 일어났을 때 실행할 함수를 등록하고
		document.querySelector("#myForm").addEventListener("submit",function(e){
			//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
			if(!isPwdValid){
				e.preventDefault();//폼 전송 막기
			}
		});	
		
	</script>
</body>
</html>