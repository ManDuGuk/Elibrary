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

<body id="home-background">

	<jsp:include page="/WEB-INF/jsp/board/Header3.jsp" />

	<jsp:include page="/WEB-INF/jsp/board/Search.jsp" />

	<div class="home-content wrapper">
		<div class="page-title">
			<h2 class="main-title" style="text-shadow: 2px 2px 5px white; font-size: 4rem;" >전자
				도서관에 오신걸 환영합니다.</h2>
		</div>


	</div>


	<jsp:include page="/WEB-INF/jsp/board/Slide.jsp" />

	<img alt="테스트 이미지" src="/images/anounce.png" class="banner-anounce">

	<div class="rec">
   		<h3 class="rec-books">최신도서</h3>
   	</div>

	<div class="card-position">

	
		<!--  -->
		<c:forEach var="result" items="${resultList}" varStatus="status" begin="0" end="2" step="1">

			<!-- 카드 테스트중 -->

			<div class="card" style="width: 18rem;">
				<c:if test="${not empty result.atchFileNm}">
					<c:url var="thumbUrl" value="/cmm/fms/getThumbImage.do">
						<c:param name="thumbYn" value="Y" />
						<c:param name="atchFileNm" value="${result.atchFileNm}" />
					</c:url>
					<img src="${thumbUrl}" class="card-img-top" alt="테스트중" id="my-cardimage"/>
				</c:if>

				<div class="card-body">
					<h5 class="card-title">${result.boardSj}</h5>
					<p class="card-text">${result.boardCn}</p>
					<a href="/board/select.do?boardId=${result.boardId}&pageIndex=1&menuNo=50" class="btn btn-primary">해당 도서 조회하기</a>
				</div>

			</div>

		</c:forEach>

	</div>



	<jsp:include page="/WEB-INF/jsp/board/Quickmenu.jsp" />


	<jsp:include page="/WEB-INF/jsp/board/Footer.jsp" />



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>
</body>
</html>