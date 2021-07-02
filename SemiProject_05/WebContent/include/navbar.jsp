<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<nav class="navbar navbar-light navbar-expand-sm" style="background-color: #79E5CB;">
		<div class="container">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/">
				High-clear!
			</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
					<a class="nav-link" href="">홈</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="">자유게시판</a>
				</li>
			</ul>
				<a class="btn btn-info btn-sm me-2" href="<%=request.getContextPath()%>/users/signup_form.jsp">sign-up</a>
				<a class="btn btn-success btn-sm me-2" href="<%=request.getContextPath()%>/users/loginform.jsp">log-in</a>
			</div>
      </div>
   </nav>
