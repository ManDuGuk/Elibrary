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

<meta charset="UTF-8">
<meta name="description" content="전자도서관 홈페이지">
<title>전자도서관 홈페이지</title>

<!-- css  -->
<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css"
	rel="stylesheet">
<!-- 헤더css -->
<link href="${pageContext.request.contextPath}/css/header.css"
	rel="stylesheet">
<!-- 홈css -->
<link href="${pageContext.request.contextPath}/css/home_container.css"
	rel="stylesheet">
<!-- 푸터css -->
<link href="${pageContext.request.contextPath}/css/footer.css"
	rel="stylesheet">
<!-- 슬라이드 css -->
<link href="${pageContext.request.contextPath}/css/slide.css"
	rel="stylesheet">
<!-- 퀵메뉴버튼 css -->
<link href="${pageContext.request.contextPath}/css/quickmenu.css"
	rel="stylesheet">
<!-- 카드css -->
<link href="${pageContext.request.contextPath}/css/card.css"
	rel="stylesheet">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<!-- 파비콘 링크-->
<link rel="icon" type="image/png" sizes="32x32"
	href="${pageContext.request.contextPath}/images/favicon-32x32.png">

<!-- 부트트랩css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">


</head>

<body>

	<jsp:include page="/WEB-INF/jsp/board/Header3.jsp" />

	contrast 화면
	<ul>
		<li>입력박스1-->${userVo.registId}</li>
		<li>입력박스2-->${userVo.registPw}</li>
		<li>추가정보3-->${userVo.registName}</li>
		<li>추가정보4-->${userVo.grant}</li>
		
	</ul>
	
	
	
	<c:forEach var="registList" items="${registList}" varStatus="status">
	
	<ol>
		<li>회원아이디-->${registList.registId}</li>
		<li>회원비밀번호-->${registList.registPw}</li>
		<li>회원이름-->${registList.registName}</li>
	</ol>		
			
	</c:forEach>
	
	<h1>${result}</h1>
</body>
</html>