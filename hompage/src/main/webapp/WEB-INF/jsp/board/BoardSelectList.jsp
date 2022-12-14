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
<!-- BBS Style -->
<link href="/asset/BBSTMP_0000000000001/style.css" rel="stylesheet" />
<!-- 공통 Style -->
<link href="/asset/LYTTMP_0000000000000/style.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- css  -->
<!-- 공통css -->
<link href="${pageContext.request.contextPath}/css/comm.css" rel="stylesheet">
<!-- 헤더css -->
<link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
<!-- 푸터css -->
<link href="${pageContext.request.contextPath}/css/footer.css" rel="stylesheet">
<!-- 파비콘 링크-->
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">
</head>
<body>

<jsp:include page="/WEB-INF/jsp/board/Header3.jsp"/>

<%-- 기본 URL --%>
<c:url var="_BASE_PARAM" value="">
	<c:param name="menuNo" value="50"/>
  	<c:if test="${not empty searchVO.searchCondition}"><c:param name="searchCondition" value="${searchVO.searchCondition}" /></c:if>
  	<c:if test="${not empty searchVO.searchKeyword}"><c:param name="searchKeyword" value="${searchVO.searchKeyword}" /></c:if>
</c:url>

<div style="text-align: center">
	<img alt="배너이미지" src="/images/listbenner.jpg" width="1200px;" height="200px;">
</div>


<div class="container">
	<div id="contents">
	
		<!-- 검색바가 구현되어있다. -->
		<%-- 검색영역 --%>
		<h3 class="search-title">도서검색</h3>
		<br>
		<div id="bbs_search">
	        <form name="frm" method="post" action="/board/selectList.do">
				<fieldset>
					<legend>검색조건입력폼</legend>
					<label for="ftext" class="hdn">검색분류선택</label>
					<select name="searchCondition" id="ftext">
						<option value="0" <c:if test="${searchVO.searchCondition eq '0'}">selected="selected"</c:if>>제목</option>
		          		<option value="1" <c:if test="${searchVO.searchCondition eq '1'}">selected="selected"</c:if>>내용</option>
		          		<option value="2" <c:if test="${searchVO.searchCondition eq '2'}">selected="selected"</c:if>>작성자</option>
					</select>
					<label for="inp_text" class="hdn">검색어입력</label>
					<input name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>" type="text" class="inp_s" id="inp_text" />
					<span class="bbtn_s"><input type="submit" value="검색" title="검색(수업용 게시판 게시물 내)" /></span>
				</fieldset>
			</form>
	    </div>
	    
	    <%-- 목록영역 --%>
		<div id="bbs_wrap">
			
			<!-- 총 게시물과 현재페이지를 나타내주는 토탈창 -->
			<div class="total">
				총 게시물 
				<strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>건 ㅣ 
				현재페이지 <strong><c:out value="${paginationInfo.currentPageNo}"/></strong>/
				<c:out value="${paginationInfo.totalPageCount}"/>
			</div>
			<!-- 총 게시물과 현재페이지를 나타내주는 토탈창 -->	
			
	        <div class="bss_list">
	            <table class="list_table">
	              <thead>
	                  <tr>
	                      <th class="num" scope="col">번호</th>
	                      <th class="tit" scope="col">제목</th>
	                      <th class="writer" scope="col">작성자</th>
	                      <th class="date" scope="col">작성일</th>
	                      <th class="hits" scope="col">조회수</th>
	                  </tr>
	              </thead>
	              <tbody>
	              	<%-- 공지 글 --%>
					 <c:forEach var="result" items="${noticeResultList}" varStatus="status">
						<tr class="notice">
							<td class="num"><span class="label-bbs spot">공지</span></td>
							<td class="tit">
								<c:url var="viewUrl" value="/board/select.do${_BASE_PARAM}">
									<c:param name="boardId" value="${result.boardId}"/>
									<c:param name="pageIndex" value="${searchVO.pageIndex}" />
								</c:url>
								<a href="${viewUrl}"><c:out value="${result.boardSj}"/></a>
							</td>
							<td class="writer" data-cell-header="작성자 : "><c:out value="${result.frstRegisterId}"/></td>
							<td class="date" data-cell-header="작성일 : "><fmt:formatDate value="${result.frstRegistPnttm}"  pattern="yyyy-MM-dd"/></td>
							<td class="hits" data-cell-header="조회수 : "><c:out value="${result.inqireCo}"/></td>
						</tr>
					  </c:forEach>
	                  
	                  <%-- 일반 글 --%>
	                  <!-- varStatus 포이치의 속성,포이치가 쓰는 변수명 -->
	                  <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<!-- 게시글 번호를 보여주는 로직, 최신글부터 역순 번호표기, 원리를 스스로 찾아보기 숙제-->
								<!-- totalRecordCount 총수 - ( (pageIndex현재페이지 번호 -1)* pageUnit페이지당 갯수 - status.count -->
								<td class="num"><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - (status.count - 1)}" /></td>
								<!-- 게시글 번호를 보여주는 로직, 최신글부터 역순 번호표기, 원리를 스스로 찾아보기 숙제-->
								
								<td class="tit">
									<c:if test="${not empty result.atchFileNm}">
										<c:url var="thumbUrl" value="/cmm/fms/getThumbImage.do">
											<c:param name="thumbYn" value="Y"/>
											<c:param name="atchFileNm" value="${result.atchFileNm}"/>
										</c:url>
										<img src="${thumbUrl}" alt="" style="width: 150px;"/>
									</c:if>
									<c:url var="viewUrl" value="/board/select.do${_BASE_PARAM}">
										<c:param name="boardId" value="${result.boardId}"/>
										<c:param name="pageIndex" value="${searchVO.pageIndex}" />
									</c:url>
									<a href="${viewUrl}">
										<!-- 비밀글인경우 이미지가 붙도록 -->
										<c:if test="${result.othbcAt eq 'Y'}">
											<img src="/asset/BBSTMP_0000000000001/images/ico_board_lock.gif" alt="비밀 글 아이콘" />
										</c:if>
										<c:out value="${result.boardSj}"/>
									</a>
								</td>
								<td class="writer" data-cell-header="작성자 : "><c:out value="${result.frstRegisterId}"/></td>
								<td class="date" data-cell-header="작성일 : "><fmt:formatDate value="${result.frstRegistPnttm}"  pattern="yyyy-MM-dd"/></td>
								<td class="hits" data-cell-header="조회수 : "><c:out value="${result.inqireCo}"/></td>
							</tr>
					  </c:forEach>
					  
					  <%-- 게시 글이 없을 경우 --%>
					  <c:if test="${fn:length(resultList) == 0}">
				    	<tr class="empty"><td colspan="5">검색 데이터가 없습니다.</td></tr>
				    </c:if>
	                </tbody>
	            </table>
	        </div>
		    <div id="paging">
		    	<c:url var="pageUrl" value="/board/selectList.do${_BASE_PARAM}"/>
				<c:set var="pagingParam"><c:out value="${pageUrl}"/></c:set>
			    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${pagingParam}"/>
		    </div>
		</div>
		<div class="btn-cont ar">
		    <a href="/board/boardRegist.do" class="btn spot"><i class="ico-check-spot"></i> 글쓰기</a>
		</div>
	</div>
</div>
<script>
/* 수정,등록,삽입등 어떤 액션을 취하고 forward했을때 보내는 메시지 */
<c:if test="${not empty adiminmessage}">
	alert("${adiminmessage}");
</c:if>
</script>

<jsp:include page="/WEB-INF/jsp/board/Footer.jsp"/>
</body>
</html>