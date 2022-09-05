<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
       

<div class="slidebox">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<input type="radio" name="slide" id="slide04">
	<ul class="slidelist">
		<li class="slideitem">
			<a><img src="/images/slide01.jpg"></a>
		</li>
		<li class="slideitem">
			<a><img src="/images/slide02.jpg"></a>
		</li>
		<li class="slideitem">
			<a><img src="/images/slide03.jpg"></a>
		</li>
		<li class="slideitem">
			<a><img src="/images/slide04.jpg"></a>
		</li>
		
	</ul>
	<div class="slide-control">
		<div class="control01">
			<label for="slide04" class="prev"></label>
			<label for="slide02" class="next"></label>
		</div>
		<div class="control02">
			<label for="slide01" class="prev"></label>
			<label for="slide03" class="next"></label>
		</div>
		<div class="control03">
			<label for="slide02" class="prev"></label>
			<label for="slide04" class="next"></label>
		</div>
		<div class="control04">
			<label for="slide03" class="prev"></label>
			<label for="slide01" class="next"></label>
		</div>
	</div>
</div>
