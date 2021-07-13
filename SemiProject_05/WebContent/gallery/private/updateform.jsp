
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num=Integer.parseInt(request.getParameter("num"));
GalleryDto dto=GalleryDao.getInstance().getData(num);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<style>
   .drag-area{
      width: 500px;
      height:100px;
      border: 1px solid gray;
      border-radius: 10px;
   }
   	#content{
		height: 200px;
		width: 650px;
		resize: none;
	}
</style>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<link href="<%=request.getContextPath() %>/users/form.css" rel="stylesheet">

</head>
<body>
	<div class="container">
		<h1 class="fw-bold my-4">글 수정</h1>
		
		<form action="update.jsp" method="post" id="updateForm">
			<input type="hidden" name="num" value="<%=num %>" />
			<input type="hidden" name="imagePath" id="imagePath" value="<%=dto.getImagePath()%>"/>
			<div class="d-flex d-inline-flex flex-column mb-3">
				<div>
					<label class="form-label" for="title">제목</label>
					<input class="form-control form-control-sm" type="text" name="title" id="title" value="<%=dto.getTitle()%>"/>
				</div>
			</div>	
			
				<div class="mb-3">
					<label class="form-label" for="content">내용</label>
					<textarea class="form-control form-control-sm" name="content" id="content"><%=dto.getContent()%></textarea>
				</div>
			<button type="reset" id="resetBtn1" style="display:none;"></button>						
		</form>
		
		<form action="ajax_upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data">
			<div class="d-flex d-inline-flex flex-column mb-3">
				<div>
					<div>
						<label class="form-label" for="image">이미지</label>
					</div>
					<small class="text-muted">이미지를 선택하거나 폴더에서 끌어다 놓으세요.</small>
					<div>
						<input class="my-2 form-control form-control-sm" type="file" name="image" id="image" 
						accept=".jpg, .jpeg, .png, .JPG, .JPEG" />
					</div>
					<div class="drag-area"></div>
				</div>
			</div>
		</form>
		<div class="img-wrapper">
			<p>이미지 미리보기 </p>
			<p><img id="myImage" src="<%=request.getContextPath()%><%=dto.getImagePath()%>"/></p>
		</div>

		<div class="mb-3" style="display:block;">
			<button class="btn btn-sm btn-outline-success" id="submitBtn">수정</button>
			<button class="btn btn-outline-danger btn-sm" type="reset" id="resetBtn2">원래대로</button>		
		</div>	
	</div>

<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
	//리셋 버튼 동작 
	document.querySelector("#resetBtn2").addEventListener("click",function(){
		document.querySelector("#resetBtn1").click();
	});

	//이미지를 선택했을 때 실행할 함수 등록
	document.querySelector("#image").addEventListener("change",function(){
		 ajaxImage();
	});	
   // dragenter 이벤트가 일어 났을때 실행할 함수 등록 
   document.querySelector(".drag-area")
      .addEventListener("dragenter", function(e){
         // drop 이벤트까지 진행될수 있도록 기본 동작을 막는다.
         e.preventDefault();
         e.stopPropagation();
      });
   
   // dragover 이벤트가 일어 났을때 실행할 함수 등록 
   document.querySelector(".drag-area")
   .addEventListener("dragover", function(e){
      // drop 이벤트까지 진행될수 있도록 기본 동작을 막는다.
      e.preventDefault();
      e.stopPropagation();
   });
	// dragover 이벤트가 일어 났을때 실행할 함수 등록 
	document.querySelector(".drag-area").addEventListener("drop", function(e){	      
		e.preventDefault();
		e.stopPropagation();
		//drop 된 파일의 여러가지 정보를 담고 있는 object 
		const data = e.dataTransfer;
		//drop 된 파일객체를 저장하고 있는 배열
		const files = data.files;
	      
	      // input 요소에 drop 된 파일정보를 넣어준다. 
	      document.querySelector("#image").files = files;
	      // 한개만 drop 했다는 가정하에서 drop 된 파일이 이미지 파일인지 여부 알아내기
	      const reg=/image.*/;
	      const file = files[0];
	      //drop 된 파일의 mime type 확인
	      if(file.type.match(reg)){
	         ajaxImage();
	      }else{
	         alert("이미지 파일만 업로드 가능합니다.");
	      }
	   });	   
	   
   function ajaxImage(){
       //id가 ajaxForm인 form을 ajax전송시킨다. 
 		const form=document.querySelector("#ajaxForm");
 		//util 함수를 이용해서 ajax 전송
 		ajaxFormPromise(form)
 		.then(function(response){
 			return response.json();
 		})
 		.then(function(data){//data는 {imagePath:"업로드된 이미지 경로"}
 			//이미지 경로에 context path 추가하기
 			const path="${pageContext.request.contextPath}"+data.imagePath;
 			//img 요소에 src 속성의 값 넣어주어서 이미지 출력하기
 			 document.querySelector(".img-wrapper img")
             .setAttribute("src", path);
 			//input type="hidden"인 요소에 value를 넣어준다.
 			 document.querySelector("#imagePath").value = data.imagePath;
 		});	         
      };

	//등록 버튼을 눌렀을 때 첫번째 form을 강제 submit 시키기
	document.querySelector("#submitBtn").addEventListener("click",function(){
		document.querySelector("#updateForm").submit();
	});
</script>
</body>
</html>

