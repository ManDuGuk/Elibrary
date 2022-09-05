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

   <jsp:include page="/WEB-INF/jsp/board/Header.jsp"/>

  	<div>
        <form action="${pageContext.request.contextPath}/contrast.do" method="get">
            <input type="text" name="registId" placeholder="제목" value=""/>
            <input type="text" name="registPw" placeholder="내용" value=""/>
            <input type="submit" value="전송"/>
        </form>
    </div> 
    <a href="${pageContext.request.contextPath}/contrast.do">contrast</a>
    
   <jsp:include page="/WEB-INF/jsp/board/Footer.jsp"/>

</body>
</html>