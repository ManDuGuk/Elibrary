<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css"
	rel="stylesheet">

<link href="/asset/front/css/style2.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<div id="header-background-color">
	<header class="page-header wrapper-header">
		<!-- 로고 -->
		<a href="${pageContext.request.contextPath}/home.do"><img
			class="logo" src="/images/revise_logo_main.png" alt="logo"></a>
		<!-- 상단바 메뉴 -->
		<nav>
			<ul class="main-nav">
				<%-- <a href='${pageContext.request.contextPath}/bbs/del.do?bbsNo=${bbsVo.bbsNo}' style="text-decoration: none"> --%>
				<li><a
					href="${pageContext.request.contextPath}/board/selectList.do">도서검색</a></li>

				<li><c:choose>
						<c:when
							test="${empty sessionScope.LoginVO && empty sessionScope.inputVO}">
							<a href="${pageContext.request.contextPath}/userlogin.do"
								class="login">로그인</a>
						</c:when>

						<c:when test="${sessionScope.inputVO.registId != 'admin' && empty sessionScope.LoginVO}">
							<a href="/login/actionLogout.do"><c:out
									value="${sessionScope.inputVO.registName}"></c:out>님 로그아웃</a>
						</c:when>
						<c:otherwise>
							<a href="/login/actionLogout.do"><c:out value="${sessionScope.LoginVO.name}"></c:out>님 로그아웃</a>
						</c:otherwise>
					</c:choose>
					<div class="dim"></div></li>

				<li><a href="${pageContext.request.contextPath}/map.do">지도</a></li>
				
				<!-- 마이페이지를 눌렀을 때 로그인이 되어있는지 확인가능해야함, 나의경우에는 grant="yes"일 상태에만 보낼수 있도록 하고싶음-->
				
				<li><a href="${pageContext.request.contextPath}/userpage.do" id="mypage">마이페이지</a></li>
				
				<li><a href="${pageContext.request.contextPath}/regist.do">리스트정보(지우지마셈)</a></li>
			</ul>
		</nav>
	</header>
</div>

<div class="layer-popup layer-login" style="display: none;">
	<header class="layer-header">
		<span class="logo"> <span class="img-logo">한국폴리텍대학 대전캠퍼스
				스마트소프트웨어학과</span>
		</span>
		<button type="button" class="layer-close">
			<span>팝업 닫기</span>
		</button>
	</header>
	<div class="layer-body">
		<form action="${pageContext.request.contextPath}/contrast.do"
			id="frmLogin" name="frmLogin" method="post" onsubmit="return vali()">
			<fieldset>
				<legend>로그인을 위한 아이디/비밀번호 입력</legend>
				<div class="ipt-row">
					<input type="text" id="loginId" name="registId" placeholder="아이디"
						required="required">
				</div>
				<div class="ipt-row">
					<input type="password" id="loginPw" name="registPw"
						placeholder="비밀번호" required="required">
				</div>
				<div style="display: flex; justify-content:space-around;">
					<div>
						<button type="submit" class="btn-login">
							<span>로그인</span>
						</button>
					</div>
					<div>
						<button type="button" class="btn-regist">
							<a href="${pageContext.request.contextPath}/insertregist.do"><span>회원가입</span></a>
						</button>
					</div>
					
				</div>
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
	
	//마이페이지 버튼을 누를시 
	$("#mypage").click(function() {
		/* alert("마이페이지 버튼 테스트."); */
		//매우잘받아짐
		var a="${inputVO.grant}"
		/* alert(a); */
		//매우 잘나옴
		/* alert("${inputVO.registId}"); */
		
		//로그인을 한 상태일때는 grant가 yes이고 이때는 mypage로 이동가능함
		
		if(a=="yes"){
			return true;
		//yes가 아닌 모든 경우에는 alert에 걸려버리게 처리
		}else{
			alert("로그인이 필요합니다.");
			return false;
		}
		 	
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
<c:if test="${not empty loginMessage}">
	alert("${loginMessage}");
</c:if>
</script>
