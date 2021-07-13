<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />

<jsp:include page="../include/resource.jsp"></jsp:include>
<jsp:include page="../include/font.jsp"></jsp:include>
<link href="<%=request.getContextPath() %>/users/form.css" rel="stylesheet">
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
	<div class="container form-signin">
		
		<form action="signup.jsp" method="post" id="signupForm">
		<img class="mb-4" src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="100" height="100"/>
		<h1 class="fw-bold my-4">회원가입</h1>	
			<div class="form-floating">
				<input class="form-control" type="text" name="id" id="id" />
				<label class="control-label" for="id">아이디</label>				
				<small>아이디는 5~10자 이내의 영문 소문자여야 합니다. </small>
				<div class="invalid-feedback">이 아이디는 사용할 수 없습니다.</div>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="pwd" id="pwd" />	
				<label class="control-label" for="pwd">비밀번호</label>				
				<small>비밀번호는 5~10자 이내여야 합니다. </small>	
				<div class="invalid-feedback">이 비밀번호는 사용할 수 없습니다.</div>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="pwd2" id="pwd2" />
				<label class="control-label" for="pwd2">비밀번호 확인</label>					
			</div>
			<button class="mt-4 w-50 btn btn-sm btn-outline-success" type="submit">가입하기</button>	
			<a class="mt-1 w-50 btn btn-sm btn-outline-success" href="<%=request.getContextPath()%>/">메인으로</a>	
		</form>
	</div>
	<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
	<script>
		//id, pwd 유효성 관리할 변수
		let isIdValid=false;
		let isPwdValid=false;
		
		//id, pwd, pwd2 요소 선택
		const id=document.querySelector("#id");
		const pwd=document.querySelector("#pwd");
		const pwd2=document.querySelector("#pwd2");
		
		//id input 시 실행할 함수 등록
		document.querySelector("#id").addEventListener("input",function(){
			//입력한 id value값 읽어와서 정규표현식과 일치하는지 검증
			let inputId=this.value;
			const reg_id=/^[a-z].{4,9}$/;
			if(!reg_id.test(inputId)){ //매칭되지 않으면 ajax 전송 막기
				isIdValid=false; //일치하지 않는다고 표시
				id.classList.add("is-invalid");	
				return; 
			}
			//id 검증: checkid.jsp로 ajax 전송하기  - 입력한 id값을 get 방식으로 전송
			ajaxPromise("checkid.jsp","get","inputId="+inputId)
			.then(function(response){
				return response.json(); 
			})
			.then(function(data){ 
				if(data.isExist){//{isExist:true}일 경우 사용할 수 없다고 하기
					isIdValid=false;
					id.classList.add("is-invalid");
				}else{//{isExist:false}일 경우 사용할 수 없다는 표시 숨기기
					isIdValid=true;
					id.classList.remove("is-invalid");
					id.classList.add("is-valid");
				}
			})
		});
		
		//pwd, pwd2 일치 확인하는 함수
		function checkPwd(){
			//pwd 에 부여된 class 초기화 
			document.querySelector("#pwd").classList.remove("is-invalid");
			document.querySelector("#pwd").classList.remove("is-valid");
			//5~10글자 검증하는 정규표현식 
			const reg_pwd=/^.{5,10}$/;
			if(!reg_pwd.test(pwd.value)){ //정규표현식에 맞지 않으면 invalid
				isPwdValid=false;
				pwd.classList.add("is-invalid");
				return;
			}
			if(pwd.value!=pwd2.value){ //확인란과 일치하지 않으면 invalid
				isPwdValid=false;
				pwd.classList.add("is-invalid");
			}else{
				isPwdValid=true;
				id.classList.remove("is-invalid");
				pwd.classList.add("is-valid");
			}
		}
		//pwd, pwd2에 input 이벤트 발생 시 함수 등록하기
		pwd.addEventListener("input", checkPwd);
		pwd2.addEventListener("input", checkPwd);
		
		//폼 전체의 유효성 확인해서 제출하도록 하기
		document.querySelector("#signupForm").addEventListener("submit",function(e){
			let isFormValid= isIdValid && isPwdValid;
			if(!isFormValid){
				e.preventDefault();
			}
		});
		
	</script>
</body>
</html>






