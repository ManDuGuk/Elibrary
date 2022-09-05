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


<!-- 부트트랩css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">



</head>

<body>

   <jsp:include page="/WEB-INF/jsp/board/Header3.jsp"/>
<%-- 
  	<div>
        <form action="${pageContext.request.contextPath}/doinsertregist.do" method="get">
            <input type="text" name="registId" placeholder="아이디" value=""/>
            <input type="text" name="registPw" placeholder="비번" value=""/>
            <input type="text" name="registName" placeholder="이름" value=""/>
            <input type="submit" value="전송"/>
        </form>
    </div> 
   --%>
  <!-- 부트트랩 html --> 
  <!-- 아래 div css는 임의로 넣은거니까 나중에 정리하자 -->
<div style="margin-left:40%; margin-right:38%; margin-top: 10%; margin-bottom: 20%; border:1px solid #047363; padding:20px">
 	<form action="${pageContext.request.contextPath}/doinsertregist.do" method="get" onsubmit="return vali();">
	  <div class="mb-3">
	    <label for="inputId" class="form-label">아이디</label>
	    <input type="text" class="form-control" id="inputId" name="registId" aria-describedby="id" placeholder="ex)test">
	    <div id="id" class="form-text">잊어버리면 찾는기능은 없으니까 꼭 기억해주세요.</div>
	  </div>
	  <div class="mb-3">
	    <label for="inputPw" class="form-label">비밀번호</label>
	    <input type="text" class="form-control" id="inputPw" name="registPw" placeholder="ex)1234">
	  </div>
	  <div class="mb-3">
	    <label for="inputName" class="form-label">이름</label>
	    <input type="text" class="form-control" id="inputName" name="registName" placeholder="홍길동">
	  </div>
	  <button type="submit" class="btn btn-primary">등록</button>
	</form>
</div>

<script>
function vali() {
	if(!$("#inputId").val()) {
		alert("아이디를 입력해주세요.");
		$("#inputId").focus();
		return false;
	}
	
	if(!$("#inputPw").val()) {
		alert("비밀번호를 입력해주세요.");
		$("#inputPw").focus();
		return false;
	}
	
	if(!$("#inputName").val()) {
		alert("이름을 입력해주세요.");
		$("#inputName").focus();
		return false;
	}
}
<c:if test="${not empty message}">
	alert("${message}");
</c:if>
</script> 
    
   <jsp:include page="/WEB-INF/jsp/board/Footer.jsp"/>

</body>
</html>