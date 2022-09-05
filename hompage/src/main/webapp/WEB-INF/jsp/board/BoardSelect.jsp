<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta charset="UTF-8">
<title>수업용 게시판</title>


<!-- css  -->
<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css" rel="stylesheet">
<!-- 헤더css -->
<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
<!-- 푸터css -->
<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet">

<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet" />
<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 파비콘 링크-->
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/board/Header3.jsp"/>

<%-- 기본 URL --%>
<c:url var="_BASE_PARAM" value="">
	<c:param name="menuNo" value="50"/>
	<c:param name="pageIndex" value="${searchVO.pageIndex}"/>
  	<c:if test="${not empty searchVO.searchCondition}">
  		<c:param name="searchCondition" value="${searchVO.searchCondition}" />
  	</c:if>
  	<c:if test="${not empty searchVO.searchKeyword}">
  		<c:param name="searchKeyword" value="${searchVO.searchKeyword}" />
  	</c:if>
</c:url>

<div class="container">
	<div id="contents">
		<div id="bbs_wrap">
			<div class="board_view">
				<dl class="tit_view">
					<dt>제목</dt>
					<dd><c:out value="${result.boardSj}"/></dd>
				</dl>
				<dl class="info_view2">
					<dt>작성자ID</dt>
					<dd><c:out value="${result.frstRegisterId}"/></dd>
					<dt>작성일</dt>
					<dd><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></dd>
					<dt>조회수</dt>
					<dd><c:out value="${result.inqireCo}"/></dd>
				</dl>
				<dl class="tit_view">
					<dt>첨부파일목록</dt>
					<dd>
						<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${result.atchFileId}"/>
						</c:import>
					</dd>
				</dl>
				<div class="view_cont">
					<c:out value="${result.boardCn}" escapeXml="false"/>
				</div>
			</div>
			
			<div class="btn-cont ar">
				<c:choose>
					<c:when test="${not empty searchVO.boardId}">
						<c:choose>
							<c:when test="${inputVO.registId == null || inputVO.registId != result.memoId && result.memoId == null}">
							<a href="${pageContext.request.contextPath}/memo.do" id="btn-reg" class="btn" name="memo">대출하기</a>
							</c:when>
							<c:when test="${inputVO.registId == result.memoId}">
							<a href="${pageContext.request.contextPath}/delmemo.do" id="btn-reg" class="btn" name="memo">반납하기</a>
							</c:when>
							<c:otherwise>
							<button type="button" id="btn-reg" class="btn">"${result.memoId}"이 빌려감</button>
							</c:otherwise>
						</c:choose>
						<c:url var="uptUrl" value="/board/boardRegist.do${_BASE_PARAM}">
							<c:param name="boardId" value="${result.boardId}"/>
						</c:url>
						<a href="${uptUrl}" class="btn">수정</a>
						
						<c:url var="delUrl" value="/board/delete.do${_BASE_PARAM}">
							<c:param name="boardId" value="${result.boardId}"/>
						</c:url>
						<a href="${delUrl}" id="btn-del" class="btn"><i class="ico-del"></i> 삭제</a>
					</c:when>
					<c:otherwise>
						<a href="#none" id="btn-reg" class="btn spot">등록</a>
					</c:otherwise>
				</c:choose>
				<c:url var="listUrl" value="/board/selectList.do${_BASE_PARAM}"/>
				<a href="${listUrl}" class="btn">목록</a>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function(){
	//게시글 삭제
	$("#btn-del").click(function(){
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
	});
	
	//찜버튼을 누를시 버튼을 누를시 세션의 값을 가져와서 로그인 여부를 확인한다.
	$("a[name=memo]").click(function() {
		
		//잘되네
		// alert("찜 버튼 테스트."); 
		
		//매우잘받아짐
		var a="${inputVO.grant}"
		/* alert(a); */
		//잘되네
		//alert("${inputVO.registId}");
		
		//로그인을 한 상태일때는 grant가 yes이고 이때는 찜버튼 작동가능
		if(a=="yes"){
			return true;
		//yes가 아닌 모든 경우에는 alert에 걸려버리게 처리
		}else{
			alert("유저 로그인이 필요합니다.");
			return false;
		} 
		
	});
});

</script>

</body>
</html>