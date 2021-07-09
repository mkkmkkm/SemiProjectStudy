<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//id로 정보 불러오기
	String id=(String)session.getAttribute("id");
	UsersDto dto=UsersDao.getInstance().getData(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
   *{
		font-family: 'Noto Sans KR', sans-serif;
	}
	/* 프로필 이미지 표시 */
	#profileImage{
		width: 100px;
		height: 100px;
		border: 1px solid gray;
		border-radius: 80%
	}
	#image{
		display: none;
	}
</style>
</head>
<body>
	<div class="container pt-5">
		<h1>회원 정보 수정 폼</h1>
		<a id="profileLink" href="javascript:">
			<%if(dto.getProfile()==null){ %>
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
			<%}else{ %>
				<img id="profileImage" 
				src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
			<%} %>
		</a>
		<form action="update.jsp" method="post">
			<%-- 저장된 profile이 있으면 value 가져오기, 없으면 "empty" --%>
			<input type="hidden" name="profile" 
			value="<%=dto.getProfile()==null? "empty" : dto.getProfile()%>"/>
			<div class="mt-3">
				<label for="id">아이디</label>
				<input type="text" id="id" value="<%=id %>" disabled/>
			</div>
			<p class="mt-3">
				<a href="<%=request.getContextPath()%>/users/private/pwd_updateform.jsp">
					비밀번호 수정
				</a>
			</p>
			<button type="submit" class="btn btn-secondary">적용</button>
		</form>
		<%-- 프로필 이미지 업로드용 폼 --%>
		<form action="ajax_profile_upload.jsp" method="post"
			id="imageForm" enctype="multipart/form-data">
			<input type="file" name="image" id="image"
				accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
		</form>
	</div>
	<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>	
	<script>
		//프로필 이미지 링크를 클릭하면 강제로 file input 이 클릭되도록 설정
		document.querySelector("#profileLink").addEventListener("click",function(){
			document.querySelector("#image").click();
		});
		//이미지를 선택했을 때(change) 실행할 함수
		document.querySelector("#image").addEventListener("change",function(){
			//폼의 참조값을 전달하면서 ajax 요청
			ajaxFormPromise(document.querySelector("#imageForm"))
			.then(function(response){
				return response.json();
			})
			.then(function(data){ //{imagePath:"/upload/~.jpg"}
				console.log(data);
				let img=`<img id="profileImage" src="<%=request.getContextPath()%>\${data.imagePath}"/>`
				document.querySelector("#profileLink").innerHTML=img;
				//input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
				document.querySelector("input[name=profile]").value=data.imagePath;
				
			});
		});
	
	</script>
</body>
</html>



