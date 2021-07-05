<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- id가 존재하는지 여부를 json으로 응답해 주는 checkid.jsp --%>
<%
	//inputId 읽어오기
	String inputId=request.getParameter("inputId");
	//db에서 가입된 아이디가 존재하는지 여부 읽어오기
	boolean isExist = UsersDao.getInstance().isExist(inputId);
%>
{"isExist":<%=isExist%>}