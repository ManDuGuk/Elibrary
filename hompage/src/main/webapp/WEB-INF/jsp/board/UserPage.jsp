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



<div style="margin-left:40%; margin-right:38%; margin-top: 10%; border:1px solid #047363; padding:20px">
 	<form action="${pageContext.request.contextPath}/updateregist.do" method="get" onsubmit="return vali();">
 	<input type="hidden" name="id" value="${registVO.id}">
	  <div class="mb-3">
	    <label for="inputId" class="form-label">아이디</label>
	    <input type="text" class="form-control" id="inputId" name="registId" aria-describedby="id" placeholder="기존 : ${registVO.registId}">
	  </div>
	  <div class="mb-3">
	    <label for="inputPw" class="form-label">비밀번호</label>
	    <input type="text" class="form-control" id="inputPw" name="registPw" placeholder="기존 : ${registVO.registPw}">
	  </div>
	  <div class="mb-3">
	    <label for="inputName" class="form-label">이름</label>
	    <input type="text" class="form-control" id="inputName" name="registName" placeholder="기존 : ${registVO.registName}">
	  </div>
	  <button type="submit" class="btn btn-primary"  id="myupdate">수정</button>
	  
	  <button type="reset" class="btn btn-primary">리셋</button>
	</form>
	
	<form action="${pageContext.request.contextPath}/deleteregist.do" method="get">
	<input type="hidden" name="id" value="${registVO.id}">
	 <button type="submit" class="btn btn-primary" id="mydelete">삭제</button>
	</form>
</div>



	<jsp:include page="/WEB-INF/jsp/board/Search.jsp" />






<div class="card-position">

	
		<!-- 홈페이지에서 쓰고있는 카드 양식 가져옴 -->
		<c:forEach var="result" items="${resultList}" varStatus="status" begin="0" end="2" step="1">


			 <!-- 카드 테스트중 -->

			<div class="card" style="width: 18rem;">
				<%-- <c:if test="${not empty result.atchFileNm}"> --%>
					<c:url var="thumbUrl" value="/cmm/fms/getThumbImage.do">
						<c:param name="thumbYn" value="Y" />
						<c:param name="atchFileNm" value="${result.atchFileNm}" />
					</c:url>
					<img src="${thumbUrl}" class="card-img-top" alt="테스트중" />
				<%-- </c:if> --%>

				<div class="card-body">
					<h5 class="card-title">${result.boardSj}</h5>
					<p class="card-text">${result.boardCn}</p>
					<a href="/board/select.do?boardId=${result.boardId}&pageIndex=1&menuNo=50" class="btn btn-primary">해당 도서 조회하기</a>
				
				</div>

			</div> 
			
		</c:forEach>

</div>

	<jsp:include page="/WEB-INF/jsp/board/Footer.jsp" />



	<!-- <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script> -->
		
<script>

$(document).ready(function() {
	

	
	//수정버튼을 버튼을 누를시 
	$("#myupdate").click(function() {
		
			alert("회원정보가 수정되었습니다. 다시 로그인 해주세요");
	
	});
	
	//삭제버튼을 버튼을 누를시 
	$("#mydelete").click(function() {
		
			alert("회원정보가 삭제되었습니다. 다시 회원가입해주세요");
	
	});
	
	
});

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
</body>
</html>