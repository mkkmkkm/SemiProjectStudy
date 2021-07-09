
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	CafeDto dto=CafeDao.getInstance().getData(num);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<style>
	#content{
		height: 500px;
	}
</style>
</head>
<div class="container my-4">
	<h1 class="fw-bold my-4">글 수정</h1>
	<form action="update.jsp" method="post" id="insertForm">
		<input type="hidden" name="num" value="<%=num %>" />
		<div class="d-flex d-inline-flex flex-column mb-3">
			<div>
				<label class="form-label" for="writer">작성자</label>
			</div>	
			<div>
				<input class="form-control form-control-sm" type="text" id="writer" value="<%=dto.getWriter() %>" disabled/>
			</div>
		
			<div class="mb-3">
				<div>
					<label class="form-label" for="category">분류</label>
				</div>
				<div>
					<select class="form-select form-select-sm" name="category" id="category">
					<option value="잡담" <%=dto.getCategory().equals("잡담") ? "selected" : "" %>>잡담</option>
					<option value="후기" <%=dto.getCategory().equals("후기") ? "selected" : "" %>>후기</option>
					</select>
				</div>
			</div>	
			
			<div class="my-2">
				<label class="form-label" for="title">제목</label>
				<input class="form-control form-control-sm" type="text" name="title" id="title" value="<%=dto.getTitle()%>>"/>
				<small class="text-muted" style="font-size:0.875rem;">제목은 5글자 이상이어야 합니다.</small>
			</div>
		</div>
		<div>
			<label for="content">내용</label>
			<textarea name="content" id="content"><%=dto.getContent()%></textarea>
		</div>
		<button class="btn btn-sm btn-outline-success" type="submit" onclick="submitContents(this);">수정</button>
		<button class="btn btn-outline-danger btn-sm" type="reset">원래대로</button>
	</form>
</div>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>
var oEditors = [];

//추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
   oAppRef: oEditors,
   elPlaceHolder: "content",
   sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",   
   htParams : {
      bUseToolbar : true,            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
      bUseVerticalResizer : true,      // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
      bUseModeChanger : true,         // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
      //aAdditionalFontList : aAdditionalFontSet,      // 추가 글꼴 목록
      fOnBeforeUnload : function(){
         //alert("완료!");
      }
   }, //boolean
   fOnAppLoad : function(){
      //예제 코드
      //oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
   },
   fCreator: "createSEditor2"
});

function pasteHTML() {
   var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
   oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
   var sHTML = oEditors.getById["content"].getIR();
   alert(sHTML);
}
   
function submitContents(elClickedObj) {
   oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용됩니다.
   
   // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
   
   try {
      elClickedObj.form.submit();
   } catch(e) {}
}

function setDefaultFont() {
   var sDefaultFont = '궁서';
   var nFontSize = 24;
   oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
</body>
</html>

