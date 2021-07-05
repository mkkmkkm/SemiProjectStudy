<%@page import="notice.dto.NoticeDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	String option=request.getParameter("option");

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
      
   //NoticeDto 객체에 startRowNum 과 endRowNum 을 담는다.
   NoticeDto dto=new NoticeDto();
   dto.setStartRowNum(startRowNum);
   dto.setEndRowNum(endRowNum);

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
   
%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/list.jsp</title>
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
</style>
</head>
<body>
<div class="container">
	<%if(id == "admin"){ %>
   		<a href="notice/insertform.jsp">새글 작성</a>
   	<%} %>
   <h1>공지사항</h1>
   <table>
      <thead>
         <tr>
            <th>글번호</th>
            <th>옵션</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>등록일</th>
         </tr>
      </thead>
      <tbody>
      <%for(NoticeDto tmp:list){%>
         <tr>
            <td><%=tmp.getNum() %></td>
            <td><%= 여기다 옵션값을 넣자%></td>
            <td>
               <a href="detail.jsp?num=<%=tmp.getNum()%>&keyword=<%=encodedK %>&condition=<%=condition%>"><%=tmp.getTitle() %></a>
            </td>
            <td><%=tmp.getWriter() %></td>
            <td><%=tmp.getViewCount() %></td>
            <td><%=tmp.getRegdate() %></td>
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
</div>
</body>
</html>











