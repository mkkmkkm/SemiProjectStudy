<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	*{
		font-family: 'Noto Sans KR', sans-serif;
	}
</style>
</head>
<body>
	<div class="container pt-5">
		<h1>비밀번호 수정 폼</h1>
				<form action="pwd_update.jsp" method="post" id="myForm">
			<div >
				<label for="pwd" class="form-label">기존 비밀번호</label>
				<input type="password" class="form-control" name="pwd" id="pwd" />
			</div>
			<div>
				<label for="newPwd" class="form-label">새 비밀번호</label>
				<input type="password" class="form-control" name="newPwd" id="newPwd" />
			</div>
			<div>
				<label for="newPwd2" class="form-label">새 비밀번호 확인</label>
				<input type="password" class="form-control" name="newPwd2" id="newPwd2" />
			</div>
			<button type="submit" class="btn btn-secondary mt-3 me-2">confirm</button>
			<button type="reset" class="btn btn-outline-secondary mt-3 me-2">reset</button>
		</form>
	</div>
	<script>
		//폼에 submit 이벤트가 일어났을 때 실행할 함수를 등록하고
		document.querySelector("#myForm").addEventListener("submit",function(e){
			let pwd1=document.querySelector("#newPwd").value;
			let pwd2=document.querySelector("#newPwd2").value;
			//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
			if(pwd1!=pwd2){
				e.preventDefault();//폼 전송 막기
			}
		});		
	</script>
</body>
</html>