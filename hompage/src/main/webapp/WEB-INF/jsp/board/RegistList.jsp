<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta charset="UTF-8">
<title>회원 게시판</title>

<!-- css  -->
<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css"
	rel="stylesheet">
<!-- 헤더css -->
<link href="${pageContext.request.contextPath}/css/header.css"
	rel="stylesheet">
<!-- 푸터css -->
<link href="${pageContext.request.contextPath}/css/footer.css"
	rel="stylesheet">
<!-- 파비콘 링크-->
<link rel="icon" type="image/png" sizes="32x32"
	href="${pageContext.request.contextPath}/images/favicon-32x32.png">
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/board/Header.jsp" />


	<h1>입력한 정보</h1>
	<c:forEach var="registList" items="${registList}" varStatus="status">
	
	<ol>
		<li>회원아이디-->${registList.registId}</li>
		<li>회원비밀번호-->${registList.registPw}</li>
		<li>회원이름-->${registList.registName}</li>
		<li>고유번호-->${registList.id}<li>
		<li>사용여부-->${registList.registAt}<li>
	</ol>		
			
	</c:forEach>
	
	<hr>
	<h1>보드리스트 모든글</h1>
	<c:forEach var="result" items="${myboardselectlist}" varStatus="status">
		<ol>
			<li>고유번호-->${result.boardId}</li>
			<li>게시물명-->${result.boardSj}</li>
			<li>사용여부->${result.useAt}</li>
			<li>찜목록 관리-->${result.memoId}<li>
		</ol>	
	</c:forEach>
	
	



	<jsp:include page="/WEB-INF/jsp/board/Footer.jsp" />
</body>
</html>