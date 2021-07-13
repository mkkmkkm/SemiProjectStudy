
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
		
	NoticeDto dto1=new NoticeDto();
	dto1.setStartRowNum(startRowNum);
	dto1.setEndRowNum(endRowNum);
	
	List<NoticeDto> list1=NoticeDao.getInstance().getList(dto1);
	
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
	body{
		height: 100vh;
		background-image: linear-gradient(rgba(255,255,255,0.5), rgba(255,255,255,0.5)), url("images/badminton_illust_up.png"); /*2가지 이미 images/badmintonillust1.png*/
		background-repeat: no-repeat;
		background-position: center;
		background-size: cover;
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
	h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
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
	
	/*4장 미니 앨범 carousel css*/
	.col-md-3{
	  display: inline-block;
	  margin-left:-4px;
	}
	.col-md-3 img{
	  width:100%;
	  height:auto;
	}
	body .carousel-indicators li{
	  background-color:green;
	}
	body .carousel-control-prev-icon,
	body .carousel-control-next-icon{
	  background-color:green;
	}
	body .no-padding{
	  padding-left: 0;
	  padding-right: 0;
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
	<div id="carouselExampleControls" class="col carousel slide" data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="images/badminton01.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="images/Badminton_name.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="images/badminton02.jpg" class="d-block w-100" alt="...">
			</div>
		</div>
	</div>
	       <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Previous</span>
           </button>
           <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true"></span>
             <span class="visually-hidden">Next</span>
           </button>
	</div>
	<div class="container mt-5" style="margin:0 auto; padding:5px;">
	<div class="m-3">
	<div class="row">
		<div class="col">
			<h2 class="fw-bold text-center my-4 ">공지사항</h2>
		    <table class="table table-hover">
		      <thead>
		         <tr>
		            <th>번호</th>
		            <th>제목</th>
		            <th>조회수</th>
		            <th>날짜</th>   
		         </tr>
		      </thead>
		      <tbody>
	 	      <% for(NoticeDto tmpN:list1){%>
		         <tr>
		            <td><%=tmpN.getNum() %></td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="detail.jsp?num==tmpN.getNum()%>"><%=tmpN.getTitle() %></a>
					</td>
		            <td><%=tmpN.getRegdate() %></td>
		            <td><%=tmpN.getViewCount() %></td>
		         </tr>
		      <% } %>				
		      </tbody>
​			</table> 
		</div>
		<div class="col">
			<h2 class="fw-bold text-center my-4 ">자유게시판</h2>
			<table class="table table-hover">
		      <thead>
		         <tr>
		            <th>번호</th>
		            <th>카테고리</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>날짜</th>
		            <th>조회수</th>     
		         </tr>
		      </thead>
		      <tbody>
		      <%for(CafeDto tmp:list){%>
		         <tr>
		            <td><%=tmp.getNum() %></td>
		            <td><%=tmp.getCategory() %></td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a>
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
	<div class="col">
		<h2 class="fw-bold text-center my-4 ">갤러리</h2>
		<!-- 4개 캐로셀 -->
		<div id="demo" class="carousel slide" data-ride="carousel">
		  <!-- Indicators -->
		  <ul class="carousel-indicators">
		    <li data-target="#demo" data-slide-to="0" class="active"></li>
		    <li data-target="#demo" data-slide-to="1"></li>
		    <li data-target="#demo" data-slide-to="2"></li>
		  </ul>
		  <!-- The slideshow -->
		  <div class="container carousel-inner no-padding">
		    <div class="carousel-item active">
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>    
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		    </div>
		    <div class="carousel-item">
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>    
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>  
		    </div>
		    <div class="carousel-item">
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>    
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>   
		      <div class="col-xs-3 col-sm-3 col-md-3">
		        <img src="https://image.shutterstock.com/z/stock-photo-sleeping-disorders-as-a-reason-for-insomnia-293777093.jpg">
		      </div>  
		    </div>
		  </div>
		  <!-- Left and right controls -->
		  <a class="carousel-control-prev" href="#demo" data-slide="prev">
		    <span class="carousel-control-prev-icon"></span>
		  </a>
		  <a class="carousel-control-next" href="#demo" data-slide="next">
		    <span class="carousel-control-next-icon"></span>
		  </a>
		</div>
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