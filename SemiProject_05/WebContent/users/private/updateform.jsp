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
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<style>
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
	.form-control{
		text-align: center;
	}
	.profileText{
		font-size: 0.875rem;
	}

</style>
</head>
<body class="text-center">
	<div class="container my-4">
		<h1 class="fw-bold my-4">회원 정보 수정</h1>
		<div class="profile my-3">
			<a id="profileLink" href="javascript:">
				<%-- 저장된 profile이 있으면 value 가져오기, 없으면 "empty" --%>
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
			<p class="profileText text-muted my-2">프로필 사진을 누르면 변경할 수 있습니다.</p>
		</div>
		
		
		<form action="update.jsp" method="post">			
			<input type="hidden" name="profile" 
			value="<%=dto.getProfile()==null? "empty" : dto.getProfile()%>"/>
			<div class="d-flex d-inline-flex flex-column justify-content-center">
				<div>
					<label class="form-label" for="id">아이디</label>
				</div>
				<div class="mb-4">
					<input class="form-control form-control-sm" type="text" id="id" value="<%=id %>" disabled/>
				</div>
				<div>
					<label class="form-label" for="pwd">비밀번호</label>
					<a href="<%=request.getContextPath()%>/users/private/pwd_updateform.jsp">
						<svg class="text-decoration-none" style="color:#198754" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
							<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
						</svg>
					</a>
				</div>
				<div class="mb-4">
					<input class="form-control form-control-sm" type="password" id="pwd" value="<%=dto.getPwd() %>" disabled/>
				</div>
				<div class="mb-4">
					<button class="btn btn-outline-success btn-sm" type="submit">적용</button>
				</div>
			</div>
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



