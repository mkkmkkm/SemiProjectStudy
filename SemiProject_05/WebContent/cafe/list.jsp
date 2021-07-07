<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>

<%@page import="test.cafe.dao.CafeCommentDao"%>
<%@page import="test.cafe.dto.CafeCommentDto"%>

<%@page import="notice.dto.NoticeDto"%>
<%@page import="notice.dao.NoticeDao"%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //한 페이지에 몇개씩 표시할 것인지
   final int PAGE_ROW_COUNT=5;
   //하단 페이지를 몇개씩 표시할 것인지
   final int PAGE_DISPLAY_COUNT=5;
   
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

   //특수기호를 인코딩한 키워드를 미리 준비한다. 
   String encodedK=URLEncoder.encode(keyword);
      
   //CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   CafeDto dto=new CafeDto();
   dto.setStartRowNum(startRowNum);
   dto.setEndRowNum(endRowNum);

   //ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
   List<CafeDto> list=null;
   //전체 row 의 갯수를 담을 지역변수를 미리 만든다.
   int totalRow=0;
   //만일 검색 키워드가 넘어온다면 
   if(!keyword.equals("")){
      //검색 조건이 무엇이냐에 따라 분기 하기
      if(condition.equals("title_content")){//제목 + 내용 검색인 경우
         //검색 키워드를 CafeDto 에 담아서 전달한다.
         dto.setTitle(keyword);
         dto.setContent(keyword);
         //제목+내용 검색일때 호출하는 메소드를 이용해서 목록 얻어오기 
         list=CafeDao.getInstance().getListTC(dto);
         //제목+내용 검색일때 호출하는 메소드를 이용해서 row  의 갯수 얻어오기
         totalRow=CafeDao.getInstance().getCountTC(dto);
      }else if(condition.equals("title")){ //제목 검색인 경우
         dto.setTitle(keyword);
         list=CafeDao.getInstance().getListT(dto);
         totalRow=CafeDao.getInstance().getCountT(dto);
      }else if(condition.equals("writer")){ //작성자 검색인 경우
         dto.setWriter(keyword);
         list=CafeDao.getInstance().getListW(dto);
         totalRow=CafeDao.getInstance().getCountW(dto);
      } // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
   }else{//검색 키워드가 넘어오지 않는다면
      //키워드가 없을때 호출하는 메소드를 이용해서 파일 목록을 얻어온다. 
      list=CafeDao.getInstance().getList(dto);
      //키워드가 없을때 호출하는 메소드를 이용해서 전제 row 의 갯수를 얻어온다.
      totalRow=CafeDao.getInstance().getCount();
   }
   
   //하단 시작 페이지 번호 
   int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
   //하단 끝 페이지 번호
   int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
   

   //전체 페이지의 갯수
   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
   //끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
   if(endPageNum > totalPageCount){
      endPageNum=totalPageCount; //보정해 준다.
   }
   
   NoticeDao dao1=NoticeDao.getInstance();

%>        

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
   .page-ui a{
      text-decoration: none;
      color: #000;
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: red;
      font-weight: bold;
      text-decoration: underline;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
   
   .page-ui ul > li{
      float: left;
      padding: 5px;
   }
   .listProfile{

   		width:15px;
   		height:15px;
   		border-radius:50%;

   }
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="container">
   <a href="private/insertform.jsp">새 글 작성</a>
   <h1>자유게시판</h1>
   <table class="table">
      <thead>
         <tr>
            <th scope="col">번호</th>
            <th scope="col">카테고리</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col">날짜</th>
            <th scope="col">조회수</th>     
         </tr>
      </thead>
      <tbody>
      	<tr class="table-light">
      		<td></td>
      		<td>공지</td>
      		<td>
      			<a href="../board/notice/detail.jsp?num=<%=dao1.getData1().getNum()%>&keyword=<%=encodedK %>&condition=<%=condition%>"><%=dao1.getData1().getTitle() %></a>
      		</td>
      		<td><%=dao1.getData1().getWriter() %></td>
      		<td ><%=dao1.getData1().getRegdate() %></td>
      		<td ><%=dao1.getData1().getViewCount() %></td>
      	</tr>
      </tbody>
      <tbody>
      <%for(CafeDto tmp:list){%>
         <tr>
            <td><%=tmp.getNum() %></td>
            <td><%=tmp.getCategory() %></td>
            <td>
               <a href="detail.jsp?num=<%=tmp.getNum()%>&keyword=<%=encodedK %>&condition=<%=condition%>"><%=tmp.getTitle() %></a>
				<%-- 댓글 개수 출력 --%>
				<span><%=CafeCommentDao.getInstance().getCount(tmp.getNum())%></span>
            	<%-- 이미지가 첨부되어 있을 시 아이콘 출력 --%>
            	<%CafeDto dto2=CafeDao.getInstance().getData(tmp.getNum());
            	if(dto2.getContent().contains("img")){ %>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
						<path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
						<path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
					</svg>
				<%} %>
            </td>
            <td>
            <%-- 작성자 왼쪽에 프로필 사진 출력 --%>
            <%
            UsersDto usersDto = UsersDao.getInstance().getData(tmp.getWriter());
            if(usersDto.getProfile()!=null){
            %>
            <img class="listProfile" src="<%=request.getContextPath()%><%=usersDto.getProfile()%>"/>
            <%}else{%>
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="listProfile bi bi-person-circle" viewBox="0 0 16 16">
				<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
			</svg>
            <%} %>
            <%=tmp.getWriter() %>
            </td>
            <td><%=tmp.getRegdate() %></td>
            <td><%=tmp.getViewCount() %></td>
         </tr>
      <%} %>
      </tbody>
   </table>
   <div class="page-ui clearfix">
      <ul>
         <%if(startPageNum != 1){ %>
            <li>
               <a href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Prev</a>
            </li>   
         <%} %>
         
         <%for(int i=startPageNum; i<=endPageNum ; i++){ %>
            <li>
               <%if(pageNum == i){ %>
                  <a class="active" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
               <%}else{ %>
                  <a href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>"><%=i %></a>
               <%} %>
            </li>   
         <%} %>
         <%if(endPageNum < totalPageCount){ %>
            <li>
               <a href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>">Next</a>
            </li>
         <%} %>
      </ul>
   </div>
   
   <div style="clear:both;"></div>
   
   <form action="list.jsp" method="get"> 
      <label for="condition">검색조건</label>
      <select name="condition" id="condition">
         <option value="title_content" <%=condition.equals("title_content") ? "selected" : ""%>>제목+내용</option>
         <option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
         <option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
      </select>
      <input type="text" id="keyword" name="keyword" placeholder="검색어..." value="<%=keyword%>"/>
      <button type="submit">검색</button>
   </form>   
   
   <%if(!condition.equals("")){ %>
      <p>
         <strong><%=totalRow %></strong> 개의 글이 검색 되었습니다.
      </p>
   <%} %>
</div>
</body>
</html>
