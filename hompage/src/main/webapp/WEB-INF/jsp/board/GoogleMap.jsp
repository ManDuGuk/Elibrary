<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    
    
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="description" content="전자도서관 홈페이지">
<title>전자도서관 홈페이지</title>

<!-- css  -->
<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css" rel="stylesheet">
<!-- 헤더css -->
<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
<!-- 푸터css -->
<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet">
<!-- 지도css -->
<link href="${pageContext.request.contextPath}/css/googlemap.css" rel="stylesheet">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- 파비콘 링크-->
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">


</head>

<body>

   <jsp:include page="/WEB-INF/jsp/board/Header3.jsp"/>

   <section id="locatioin">
   		<div class="wrapper">
   			<div class="location-info">
   				<h3 class="sub-title">대전 폴리텍 도서관</h3>
   				<p class="textLocation">
					<b>주소</b> 대전시 동구 우암로 352-21<br>
					<b>대표전화</b> 042) 670-0600<br>
					<b>팩스번호</b> 042) 670-0519<br>
					<b>학생회관</b> 3층 스마트라운지 도서관
					
				</p>
				<P class="naverForm">
					<h3 class="sub-title">네이버 지도</h3>
					<a href="http://naver.me/5X9BWl6c" target='_blank'><img src="/images/naverMap.png" alt="naverMapImage"></a>
				</P>
				
				
   			</div>
   			<div class="location-map">
	   			<h3 class="sub-title">구글지도</h3>
	   			<iframe class="map-property" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3121.9552484737164!2d127.45372078824546!3d36.35022890265998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35654865afaae0db%3A0x3fe8bede8780ef21!2z7ZWc6rWt7Y-066as7YWN64yA7ZWZIOuMgOyghOy6oO2NvOyKpA!5e0!3m2!1sko!2skr!4v1657069986423!5m2!1sko!2skr"
	   			 width="600" height="550" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
   			</div>
   		</div>
   		<div class="location-mapview">
   			<h3 class="sub-title">학교 전경</h3>
   		</div>
   		<ul id="map-view">
   			<li><img alt="학생회관" src="/images/student.jpg"><span>폴리텍 대전캠퍼스 학생회관 전경</span></li>
   			<li><img alt="나래관" src="/images/nalae.png"><span>폴리텍 대전캠퍼스 나래관 전경</span></li>
   		</ul>
   </section>
    
   <jsp:include page="/WEB-INF/jsp/board/Footer.jsp"/>

</body>
</html>