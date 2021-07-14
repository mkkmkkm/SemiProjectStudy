
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	int likeCounter=Integer.parseInt(request.getParameter("likeCounter"));
	boolean isSuccess=GalleryDao.getInstance().addLikeCount(num);

%>
{"isSuccess":<%=isSuccess %>}