<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css" rel="stylesheet">

<link href="/asset/front/css/style2.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<div id="header-background-color">
	<header class="page-header wrapper-header">
	<!-- 로고 -->
	<a href="${pageContext.request.contextPath}/home.do"><img class="logo" src="/images/revise_logo_main.png" alt="logo"></a>	
	    <!-- 상단바 메뉴 -->
	    <nav>
	        <ul class="main-nav">
	        <%-- <a href='${pageContext.request.contextPath}/bbs/del.do?bbsNo=${bbsVo.bbsNo}' style="text-decoration: none"> --%>
	            <li><a href="${pageContext.request.contextPath}/board/selectList.do">게시판</a></li>
	            
	            <li><c:choose>
						<c:when test="${empty sessionScope.LoginVO}">
							<a href="/login/egovLoginUsr.do" class="login">로그인</a>
						</c:when>
						<c:otherwise>
							<a href="/login/actionLogout.do"><c:out value="${sessionScope.LoginVO.name}"></c:out>님 로그아웃</a>
						</c:otherwise>
					</c:choose>
					<div class="dim"></div></li>
					
	            <li><a href="${pageContext.request.contextPath}/map.do">지도</a></li>
	           
	        </ul>
	    </nav>
	</header>
</div>

<div class="layer-popup layer-login" style="display: none;">
	<header class="layer-header">
		<span class="logo">
			<span class="img-logo">한국폴리텍대학 대전캠퍼스 스마트소프트웨어학과</span>
		</span>
		<button type="button" class="layer-close"><span>팝업 닫기</span></button>
	</header>
	<div class="layer-body">
		<form action="/login/actionLogin.do" id="frmLogin" name="frmLogin" method="post" onsubmit="return vali()">
			<input type="hidden" name="userSe" value="USR"/>
			<fieldset>
				<legend>로그인을 위한 아이디/비밀번호 입력</legend>
				<div class="ipt-row">
					<input type="text" id="loginId" name="id" placeholder="아이디"  required="required">
				</div>
				<div class="ipt-row">
					<input type="password" id="loginPw" name="password" placeholder="비밀번호" required="required">
				</div>
				<button type="submit" class="btn-login"><span>로그인</span></button>
			</fieldset>
		</form>
	</div>
</div>


<script>
$(document).ready(function() {
	//로그인
	$(".login").click(function() {
		$(".dim, .layer-login").fadeIn();
		return false;
	});
	
	//레이어닫기
	$(".layer-close").click(function() {
		$(".dim, .layer-login").fadeOut();
		return false;
	});
});

function vali() {
	if(!$("#loginId").val()) {
		alert("아이디를 입력해주세요.");
		$("#loginId").focus();
		return false;
	}
	
	if(!$("#loginPw").val()) {
		alert("비밀번호를 입력해주세요.");
		$("#loginPw").focus();
		return false;
	}
}

<c:if test="$(not empty loginMessage)">
	alert("${loginMessage}");
</c:if>
</script>    
