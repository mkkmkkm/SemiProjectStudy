<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //자세히 보여줄 글번호를 읽어온다. 
   int num=Integer.parseInt(request.getParameter("num"));
   //조회수 올리기
   CafeDao.getInstance().addViewCount(num);
   
   /*
      [ 검색 키워드에 관련된 처리 ]
      -검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.      
   */
   String keyword=request.getParameter("keyword");
   String condition=request.getParameter("condition");
   //만일 키워드가 넘어오지 않는다면 
   if(keyword==null){
      //키워드와 검색 조건에 빈 문자열을 넣어준다. 
      //클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
      keyword="";
      condition=""; 
   }
   //CafeDto 객체를 생성해서 
   CafeDto dto=new CafeDto();
   //자세히 보여줄 글번호를 넣어준다. 
   dto.setNum(num);
   //만일 검색 키워드가 넘어온다면 
   if(!keyword.equals("")){
      //검색 조건이 무엇이냐에 따라 분기 하기
      if(condition.equals("title_content")){//제목 + 내용 검색인 경우
         //검색 키워드를 CafeDto 에 담아서 전달한다.
         dto.setTitle(keyword);
         dto.setContent(keyword);
         dto=CafeDao.getInstance().getDataTC(dto);
      }else if(condition.equals("title")){ //제목 검색인 경우
         dto.setTitle(keyword);
         dto=CafeDao.getInstance().getDataT(dto);
      }else if(condition.equals("writer")){ //작성자 검색인 경우
         dto.setWriter(keyword);
         dto=CafeDao.getInstance().getDataW(dto);
      } // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
   }else{//검색 키워드가 넘어오지 않는다면
      dto=CafeDao.getInstance().getData(dto);
   }
   //특수기호를 인코딩한 키워드를 미리 준비한다. 
   String encodedK=URLEncoder.encode(keyword);
   
   
   //로그인된 아이디 (로그인을 하지 않았으면 null 이다)
   String id=(String)session.getAttribute("id");
   //로그인 여부
   boolean isLogin=false;
   if(id != null){
      isLogin=true;
   }
   
   /*
      [ 댓글 페이징 처리에 관련된 로직 ]
   */
   //한 페이지에 몇개씩 표시할 것인지
   final int PAGE_ROW_COUNT=10;
   
   //detail.jsp 페이지에서는 항상 1페이지의 댓글 내용만 출력한다. 
   int pageNum=1;
   
   //보여줄 페이지의 시작 ROWNUM
   int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
   //보여줄 페이지의 끝 ROWNUM
   int endRowNum=pageNum*PAGE_ROW_COUNT;
   
   //원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
   CafeCommentDto commentDto=new CafeCommentDto();
   commentDto.setRef_group(num);
   //1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
   commentDto.setStartRowNum(startRowNum);
   commentDto.setEndRowNum(endRowNum);
   
   //1페이지에 해당하는 댓글 목록만 select 되도록 한다. 
   List<CafeCommentDto> commentList=
         CafeCommentDao.getInstance().getList(commentDto);
   
   //원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
   int totalRow=CafeCommentDao.getInstance().getCount(num);
   //댓글 전체 페이지의 갯수
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   
   //글정보를 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
   .content{
      border: 1px dotted gray;
   }
   
   /* 댓글 프로필 이미지를 작은 원형으로 만든다. */
   .profile-image{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   /* ul 요소의 기본 스타일 제거 */
   .comments ul{
      padding: 0;
      margin: 0;
      list-style-type: none;
   }
   .comments dt{
      margin-top: 5px;
   }
   .comments dd{
      margin-left: 50px;
   }

   .comments li{
      clear: left;
   }

   .comment-form textarea{
      width: 100%;
      height: 80px;
      border: 1px solid #b8b8b8;
      resize: none;
   }

   /* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
   .comments .comment-form{
      display: none;
   }
   /* .reply_icon 을 li 요소를 기준으로 배치 하기 */
   .comments li{
      position: relative;
   }
   .comments .reply-icon{
      position: absolute;
      top: 1em;
      left: 1em;
      color: gray;
   }
   pre {
     display: block;
     padding: 9.5px;
     margin: 0 0 10px;
     line-height: 1.42857143;
     word-break: break-all;
     word-wrap: break-word;
     font-size: 1rem !important;
   }   
   
   .loader{
      /* 로딩 이미지를 가운데 정렬하기 위해 */
      text-align: center;
      /* 일단 숨겨 놓기 */
      display: none;
   }   
   .loader svg{
      animation: sizeAni 1s ease-out infinite;
      color: #198754;
   }
   
   @keyframes sizeAni{
      0%{
         transform: scale(0);
      }
      100%{
         transform: scale(1);
      }
   }

</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container my-4">
   <% if(!keyword.equals("")){ %>
      <p>   
         <strong><%=condition %></strong> 조건, 
         <strong><%=keyword %></strong> 검색어로 검색된 내용 자세히 보기 
      </p>
   <%} %>
	<div class="article-head mt-4">
		<div class="writerInfo1 d-flex mb-4">
			<div class="profile d-inline-flex me-2">
			<%
				UsersDto usersDto = UsersDao.getInstance().getData(dto.getWriter());
				if(usersDto.getProfile()==null){
			%>	
				<svg class="profile-image" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>			
			<%}else{ %>
				<img class="profile-image" src="<%=request.getContextPath() %><%=usersDto.getProfile()%>"/>
			<%} %>
			</div>
			<div class="writerInfo2 d-flex flex-column">
				<p class="writer fw-bold mb-0"> 
					<%=dto.getWriter() %>
				</p>				
				<p class="date text-muted mb-0">
					<%=dto.getRegdate() %>
				</p>
			</div>
		</div>
		<div class="category">
			<%=dto.getCategory() %>
		</div>
		<div class="title my-3">
			<h2 class="fw-bold">
				<%=dto.getTitle() %>
			</h2>
		</div>
		<div class="view my-4">
			<span class="mr-1 text-muted">조회수</span>
			<span class="fw-bold"><%=dto.getViewCount() %></span>
		</div>
		<div class="mainContent my-5">
			<%=dto.getContent() %>
		</div>
	</div>
	
	<ul class="d-flex flex-row ps-0 justify-content-end" style="list-style:none;">	
		<%if(dto.getWriter().equals(id)){ %>
		<li>
			<a class="link-dark text-decoration-none mx-1" href="private/updateform.jsp?num=<%=dto.getNum()%>">수정</a>
		</li>
		<li>
			<a class="link-dark text-decoration-none mx-1" href="private/delete.jsp?num=<%=dto.getNum()%>">삭제</a>
		</li>
		<%} %>  
	</ul>
	
	<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
	   <%if(dto.getPrevNum()!=0){ %>
		<li>
			<a class="link-success text-decoration-none" href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">
			&lt이전글
			</a>
		</li>  
	   <%} %>
	   	<li class="mx-3">
			<a class="fw-bold link-success text-decoration-none" href="list.jsp">목록보기</a>
		</li>
	   <%if(dto.getNextNum()!=0){ %>
		<li>			   
			<a class="link-success text-decoration-none" href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">
			다음글&gt	     	
	      </a>
		</li>	   
	   <%} %>  	    
	</ul>
	
   <%-- 댓글 목록 --%>
	<hr class="mb-3" style="border: solid 1px gray;">
	<p class="fs-5 mb-3"><strong><%=totalRow %></strong> 개의 댓글</p>
	
   <div class="comments">
      <ul>
         <%for(CafeCommentDto tmp: commentList){ %>
            <%if(tmp.getDeleted().equals("yes")){ %>
               <li>삭제된 댓글입니다.</li>
            <%continue;}%>         
            <%if(tmp.getNum() == tmp.getComment_group()){ %>
            <li id="reli<%=tmp.getNum()%>">
            <%}else{ %>
            <li id="reli<%=tmp.getNum()%>" style="padding-left:50px;">
               <svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
               </svg>
            <%} %>
               <dl>
                  <dt>
                  <%if(tmp.getProfile() == null){ %>
                     <svg class="profile-image me-2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                          <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                     </svg>
                  <%}else{ %>
                     <img class="profile-image me-2" src="${pageContext.request.contextPath}<%=tmp.getProfile()%>"/>
                  <%} %>
					<span class="fw-bold"><%=tmp.getWriter() %></span>
					<span class="fw-light text-muted mx-1"><%=tmp.getRegdate() %></span>

                  </dt>
                  <dd>
                  	<%if(tmp.getNum() != tmp.getComment_group()){ %>
                     <span class="p-1 m-1 text-muted" style="font-size:.875rem;">
                     	<i>@<%=tmp.getTarget_id() %></i>
                     </span>
                  <%} %>
					<pre id="pre<%=tmp.getNum()%>"><%=tmp.getContent() %></pre>  
					<a data-num="<%=tmp.getNum() %>" href="javascript:" class="reply-link text-decoration-none"
                     style="padding-left:9.5px; color:#198754;">댓글</a>    
					<%if(id != null && tmp.getWriter().equals(id)){ %>
						<a data-num="<%=tmp.getNum() %>" class="update-link text-decoration-none link-dark px-2" href="javascript:">수정</a>
						<a data-num="<%=tmp.getNum() %>" class="delete-link text-decoration-none link-dark" href="javascript:">삭제</a>
					<%} %>            
                  </dd>
				<dd>
	 				<%--대댓글 폼 --%>
					<form id="reForm<%=tmp.getNum() %>" class="animate__animated comment-form re-insert-form" 
					action="private/comment_insert.jsp" method="post">
						<input type="hidden" name="ref_group"
						value="<%=dto.getNum()%>"/>
						<input type="hidden" name="target_id"
	 					value="<%=tmp.getWriter()%>"/>
	 					<input type="hidden" name="comment_group"
						value="<%=tmp.getComment_group()%>"/>
						<textarea name="content"></textarea>
						<div align="right">
						<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
						</div>
					</form>                    
				</dd>   
				<dd>
					<%--대댓글 수정 폼 --%>
	 				<%if(tmp.getWriter().equals(id)){ %>   
					<form id="updateForm<%=tmp.getNum() %>" class="comment-form update-form" 
					action="private/comment_update.jsp" method="post">
						<input type="hidden" name="num" value="<%=tmp.getNum() %>" />
		 				<textarea name="content"><%=tmp.getContent() %></textarea>
						<div align="right">
						<button class="btn btn-sm btn-outline-success" type="submit">수정</button>
						</div>
					</form>
				</dd>         
			</dl>   
               <%} %>                  
            </li>
         <%} %>
      </ul>
   </div>
	<div class="loader my-4">
		<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-circle-fill" viewBox="0 0 16 16">
			<circle cx="8" cy="8" r="8"/>
		</svg>
	</div>
   <!-- 원글에 댓글을 작성할 폼 -->
   <form class="comment-form insert-form" action="private/comment_insert.jsp" method="post">
      <!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
      <input type="hidden" name="ref_group" value="<%=num%>"/>
      <!-- 원글의 작성자가 댓글의 대상자가 된다. -->
      <input type="hidden" name="target_id" value="<%=dto.getWriter()%>"/>
      
      <textarea name="content"><%if(!isLogin){%>댓글 작성을 위해 로그인이 필요합니다.<%}%></textarea>
      <div align="right">
      	<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
      </div>		
   </form>
</div>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
   
   //클라이언트가 로그인 했는지 여부
   let isLogin=<%=isLogin%>;
   
   document.querySelector(".insert-form")
      .addEventListener("submit", function(e){
         //만일 로그인 하지 않았으면 
         if(!isLogin){
            //폼 전송을 막고 
            e.preventDefault();
            //로그인 폼으로 이동 시킨다.
            location.href=
               "${pageContext.request.contextPath}/users/loginform.jsp?url=${pageContext.request.contextPath}/cafe/detail.jsp?num=<%=num%>";
         }
      });
   
   /*
      detail.jsp 페이지 로딩 시점에 만들어진 1 페이지에 해당하는 
      댓글에 이벤트 리스너 등록 하기 
   */
   addUpdateFormListener(".update-form");
   addUpdateListener(".update-link");
   addDeleteListener(".delete-link");
   addReplyListener(".reply-link");
   
   
   //댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
   let currentPage=1;
   //마지막 페이지는 totalPageCount 이다.  
   let lastPage=<%=totalPageCount%>;
   
   //추가로 댓글을 요청하고 그 작업이 끝났는지 여부를 관리할 변수 
   let isLoading=false; //현재 로딩중인지 여부 
   
   /*
      window.scrollY => 위쪽으로 스크롤된 길이
      window.innerHeight => 웹브라우저의 창의 높이
      document.body.offsetHeight => body 의 높이 (문서객체가 차지하는 높이)
   */
   window.addEventListener("scroll", function(){
      //바닥 까지 스크롤 했는지 여부 
      const isBottom = 
         window.innerHeight + window.scrollY  >= document.body.offsetHeight;
      //현재 페이지가 마지막 페이지인지 여부 알아내기
      let isLast = currentPage == lastPage;   
      //현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
      if(isBottom && !isLoading && !isLast){
         //로딩바 띄우기
         document.querySelector(".loader").style.display="block";
         
         //로딩 작업중이라고 표시
         isLoading=true;
         
         //현재 댓글 페이지를 1 증가 시키고 
         currentPage++;
         
         /*
            해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
            "pageNum=xxx&num=xxx" 형식으로 GET 방식 파라미터를 전달한다. 
         */
         ajaxPromise("ajax_comment_list.jsp","get",
               "pageNum="+currentPage+"&num=<%=num%>")
         .then(function(response){
            //json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
            return response.text();
         })
         .then(function(data){
            // beforebegin | afterbegin | beforeend | afterend
            document.querySelector(".comments ul")
               .insertAdjacentHTML("beforeend", data);
            //로딩이 끝났다고 표시한다.
            isLoading=false;
            //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
            addUpdateListener(".page-"+currentPage+" .update-link");
            addDeleteListener(".page-"+currentPage+" .delete-link");
            addReplyListener(".page-"+currentPage+" .reply-link");
            //새로 추가된 댓글 li 요소 안에 있는 댓글 수정폼에 이벤트 리스너 등록하기
            addUpdateFormListener(".page-"+currentPage+" .update-form");
            
            //로딩바 숨기기
            document.querySelector(".loader").style.display="none";
         });
      }
   });
   
   //인자로 전달되는 선택자를 이용해서 이벤트 리스너를 등록하는 함수 
   function addUpdateListener(sel){
      //댓글 수정 링크의 참조값을 배열에 담아오기 
      // sel 은  ".page-xxx  .update-link" 형식의 내용이다 
      let updateLinks=document.querySelectorAll(sel);
      for(let i=0; i<updateLinks.length; i++){
         updateLinks[i].addEventListener("click", function(){
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const num=this.getAttribute("data-num"); //댓글의 글번호
            document.querySelector("#updateForm"+num).style.display="block";
            
         });
      }
   }
   function addDeleteListener(sel){
      //댓글 삭제 링크의 참조값을 배열에 담아오기 
      let deleteLinks=document.querySelectorAll(sel);
      for(let i=0; i<deleteLinks.length; i++){
         deleteLinks[i].addEventListener("click", function(){
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const num=this.getAttribute("data-num"); //댓글의 글번호
            const isDelete=confirm("댓글을 삭제 하시겠습니까?");
            if(isDelete){
               // gura_util.js 에 있는 함수들 이용해서 ajax 요청
               ajaxPromise("private/comment_delete.jsp", "post", "num="+num)
               .then(function(response){
                  return response.json();
               })
               .then(function(data){
                  //만일 삭제 성공이면 
                  if(data.isSuccess){
                     //댓글이 있는 곳에 삭제된 댓글입니다를 출력해 준다. 
                     document.querySelector("#reli"+num).innerText="삭제된 댓글입니다.";
                  }
               });
            }
         });
      }
   }
   function addReplyListener(sel){
      //댓글 링크의 참조값을 배열에 담아오기 
      let replyLinks=document.querySelectorAll(sel);
      //반복문 돌면서 모든 링크에 이벤트 리스너 함수 등록하기
      for(let i=0; i<replyLinks.length; i++){
         replyLinks[i].addEventListener("click", function(){
            
            if(!isLogin){
               const isMove=confirm("로그인이 필요 합니다. 로그인 페이지로 이동 하시겠습니까?");
               if(isMove){
                  location.href=
                     "${pageContext.request.contextPath}/users/loginform.jsp?url=${pageContext.request.contextPath}/cafe/detail.jsp?num=<%=num%>";
               }
               return;
            }
            
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const num=this.getAttribute("data-num"); //댓글의 글번호
            
            const form=document.querySelector("#reForm"+num);
            
            //현재 문자열을 읽어온다 ( "댓글" or "취소" )
            let current = this.innerText;
            
            if(current == "댓글"){
               //번호를 이용해서 댓글의 댓글폼을 선택해서 보이게 한다. 
               form.style.display="block";
               form.classList.add("animate__fadeIn");
               this.innerText="취소";   
               form.addEventListener("animationend", function(){
                  form.classList.remove("animate__fadeIn");
               }, {once:true});
            }else if(current == "취소"){
               form.classList.add("animate__fadeOut");
               this.innerText="댓글";
               form.addEventListener("animationend", function(){
                  form.classList.remove("animate__fadeOut");
                  form.style.display="none";
               },{once:true});
            }
         });
      }
   }
   
   function addUpdateFormListener(sel){
      //댓글 수정 폼의 참조값을 배열에 담아오기
      let updateForms=document.querySelectorAll(sel);
      for(let i=0; i<updateForms.length; i++){
         //폼에 submit 이벤트가 일어 났을때 호출되는 함수 등록 
         updateForms[i].addEventListener("submit", function(e){
            //submit 이벤트가 일어난 form 의 참조값을 form 이라는 변수에 담기 
            const form=this;
            //폼 제출을 막은 다음 
            e.preventDefault();
            //이벤트가 일어난 폼을 ajax 전송하도록 한다.
            ajaxFormPromise(form)
            .then(function(response){
               return response.json();
            })
            .then(function(data){
               if(data.isSuccess){
                  /*
                     document.querySelector() 는 html 문서 전체에서 특정 요소의 
                     참조값을 찾는 기능
                     
                     특정문서의 참조값.querySelector() 는 해당 문서 객체의 자손 요소 중에서
                     특정 요소의 참조값을 찾는 기능
                  */
                  const num=form.querySelector("input[name=num]").value;
                  const content=form.querySelector("textarea[name=content]").value;
                  //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
                  document.querySelector("#pre"+num).innerText=content;
                  form.style.display="none";
               }
            });
         });
      }

   }
</script>
</body>
</html>
