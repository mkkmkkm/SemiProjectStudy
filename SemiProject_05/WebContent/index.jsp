
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@page import="notice.dao.NoticeDao"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="notice.dto.NoticeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=5;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=10;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
	CafeDto dto=new CafeDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);

	//CafeDao 객체의 참조값 얻어와서 
	CafeDao dao=CafeDao.getInstance();
	//회원목록 얻어오기 
	List<CafeDto> list=dao.getList(dto);
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	
	//전체 row 의 갯수 
	int totalRow=dao.getCount();
	//전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다.
	}
	
	//공지사항 게시판
	NoticeDto dto1=new NoticeDto();
	dto1.setStartRowNum(startRowNum);
	dto1.setEndRowNum(endRowNum);
	List<NoticeDto> list1=NoticeDao.getInstance().getList(dto1);
	
	//갤러리 게시판
	GalleryDto dto2=new GalleryDto();
	dto2.setStartRowNum(startRowNum);
	dto2.setEndRowNum(endRowNum);
	List<GalleryDto> list2=GalleryDao.getInstance().getList(dto2);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<style>
   .modal {
   	  margin-top: -200px !important;
      top: 50% !important;	
      margin-left: -120px !important;	
      left: 50% !important;	
   	  position: fixed;
   	  height: 400px !important;
   	  width: 300px !important;
   	  }
    .modal-content {
    	margin-top: -200px !important;
      	top: 50% !important;
      	margin-left: -120px !important;	
      	left: 50% !important;	
     	height: 300px !important;
    	width: 240px !important;
    	}

	/*글자 css*/
	.page-ui a{
      text-decoration: none;
      color: rgb(2,38,94);
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: rgb(2,38,94);
      font-weight: bold;
      text-decoration: underline;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
	th{
		color: rgb(0,136,236); 
	}
	td{
		color:rgb(2,38,94);
		font-size: 1em; 
	}
	a{
		color:rgb(2,38,94);
		text-decoration: none;
	}

	/* 갤러리 carousel css*/
	.col-md-3{
	  display: inline-block;
	}
	.col-md-3 img{
	  width:100%;
	  height:auto;
	}
</style>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	

<%
	//쿠키 읽어오기
	Cookie[] cookies=request.getCookies();
	//팝업을 띄울지 여부
	boolean isPopup=true;
	if(cookies != null){
		//반복문 돌면서 저장된 쿠키를 얻어내서
		for(Cookie tmp:cookies){
			//isPopup이라는 이름으로 저장된 쿠키가 있으면
			if(tmp.getName().equals("isPopup")){
				//팝업을 띄우지 않게 한다.
				isPopup=false;
			}
		}
	}
%>
<%if(isPopup){%>
	<script>
		window.open("popup.jsp","창의제목","width=420,height=470,top=100,left=100");
	</script>
<%}%>
<!-- 메인 carousel -->
	<div>
		<img src="images/baaaaadminton.jpg" class="d-block w-100" alt="...">
	</div>
	<div class="container-fluid mt-5" style="margin:0 auto; padding:5px;">
	<div class="row">
		<div class="col">
			<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">공지사항</h2>
		    <table class="table table-hover text-center">
		      <thead>
		         <tr>
		            <th style="color: #48a697;">번호</th>
		            <th style="color: #48a697;">제목</th>
		            <th style="color: #48a697;">조회수</th>
		            <th style="color: #48a697;">날짜</th>   
		         </tr>
		      </thead>
		      <tbody>
	 	      <% for(NoticeDto tmpN:list1){%>
		         <tr>
		            <td><%=tmpN.getNum() %></td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="board/notice/detail.jsp?num=<%=tmpN.getNum()%>"><%=tmpN.getTitle() %></a>
					</td>
		            <td><%=tmpN.getRegdate() %></td>
		            <td><%=tmpN.getViewCount() %></td>
		         </tr>
		      <% } %>				
		      </tbody>
		     </table> 
		</div>
		<div class="col">
			<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">자유게시판</h2>
			<table class="table table-hover text-center">
		      <thead>
		         <tr>
		            <th style="color: #48a697;">번호</th>
		            <th style="color: #48a697;">카테고리</th>
		            <th style="color: #48a697;">제목</th>
		            <th style="color: #48a697;">작성자</th>
		            <th style="color: #48a697;">날짜</th>
		            <th style="color: #48a697;">조회수</th>     
		         </tr>
		      </thead>
		      <tbody>
		      <%for(CafeDto tmp:list){%>
		         <tr>
		            <td><%=tmp.getNum() %></td>
		            <td><%=tmp.getCategory() %></td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="cafe/detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a>
						<%-- 댓글 개수 출력 --%>
						<span class="mx-2" style="color:#198754;"><%=CafeCommentDao.getInstance().getCount(tmp.getNum())%></span>
		            </td>
		            <td><%=tmp.getWriter() %></td>
		            <td><%=tmp.getRegdate() %></td>
		            <td><%=tmp.getViewCount() %></td>
		         </tr>
		      <%} %>
		      </tbody>
		   </table>
		</div>
	</div>
	
	<div class="row pt-3">
		<h2 class="fw-bold text-center my-4 "></h2>
		<div class="col">
			<div class="card">
                 <iframe height="235" src="https://www.youtube.com/embed/TdeBlsehb6g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">스텝</h5>
                   <p class="card-text">배드민턴 스텝의 모든것</p>
                 </div>
           </div>	
           </div>		
		<div class="col">
			<div class="card">
                 <iframe height="235" src="https://www.youtube.com/embed/gAl4cW4r3vw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">드롭샷</h5>
                   <p class="card-text">깎기드롭부터 백드롭까지</p>
                 </div>
            </div>
		</div>
		<div class="col">
			<div class="card">
                 <iframe height="235" src="https://www.youtube.com/embed/oPgFINcuOVQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">포핸드그립 백핸드그립 준비그립</h5>
                   <p class="card-text">필수로 알고 시작해야하는 3종 그립</p>
                 </div>
            </div>						
		</div>
		<div class="col">
			<div class="card">
                 <iframe height="235" src="https://www.youtube.com/embed/2a2ESf7SN9g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">배드민턴꿀팁</h5>
                   <p class="card-text">배드민턴 꿀팁 특별강습</p>
                 </div>
            </div>						
		</div>
	</div>
	
	<div class="row pt-3">
	<div class="col" >
		<h2 class="fw-bold text-center my-4 "></h2>
            <div class="col">
            	<td>
            		<img class="mb-4 p-2" src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="50" height="50"/>
            	</td>
	            <%for(GalleryDto tmpG:list2){%>
	            <td class="col">
	              <a href="gallery/detail.jsp?num=<%=tmpG.getNum() %>">
	              <img src="${pageContext.request.contextPath }<%=tmpG.getImagePath() %>" 
							onerror="this.src='${pageContext.request.contextPath}/images/frown-face.png'" 
							class="col-xs-12 col-sm-8 col-md-2 col-xg-2 img-rounded"/>
				</td>
	            <%} %>
	            <td>
            		<img class="mb-4 p-2" src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="50" height="50"/>
            	</td>
            </div> 
          	</div>
          </div>
        </div>
<jsp:include page="include/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
    <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="color: green; font-size: 24pt;">*JOIN US~~*</span></b></span></p>
      <a href="http://www.badmintonmart.com/shop/main/index.php"> <img src="<%=request.getContextPath() %>/images/notice.jpg" class="card-img-top" height=300px width=240px; />
                </a>
    <div style="cursor:pointer;background-color:black; color:white; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 12pt;" >
                     5초후 자동으로 사라집니다^^
                </span>
            </div>
      </div> 
    </div>
        <!--End Modal--> 
    <script type="text/javascript">      
        jQuery(document).ready(function() {
                $('#myModal').show();
        });
        //팝업 Close 기능
        function close_pop(flag) {
             $('#myModal').hide();             
        };
        //5초후 자동으로 사라지기 
        setTimeout(function() { $('#myModal').hide();}, 5000)
      </script>
</body>
</html>