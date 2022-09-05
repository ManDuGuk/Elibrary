<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


    
<div class="space"></div>
<div class="main-link">
	<div class="wrapper">
		<ul class="cf">
			<li>
				<a href="${pageContext.request.contextPath}/home.do">
					<span class="img"></span>
					<span>메인페이지로 이동</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/board/selectList.do">
					<span class="img"></span>
					<span>도서검색</span>
				</a>
			</li>
			<li class="main-nav">
				<a href="${pageContext.request.contextPath}/userlogin.do">
					<span class="img"></span>
					<span>회원로그인</span>
				</a>
			</li>
			<li>
				<a href="${pageContext.request.contextPath}/map.do">
					<span class="img"></span>
					<span>지도</span>
				</a>
			</li>
		</ul>
	</div>
</div>