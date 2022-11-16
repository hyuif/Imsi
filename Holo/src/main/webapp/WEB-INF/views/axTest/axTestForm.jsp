<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Ajax Test Main Form **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css">
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/axTest01.js"></script>
<script src="resources/myLib/axTest02.js"></script>

</head>
<body>
<h3>** Ajax Test Main Form **</h3>
<c:if test="${not empty loginID}">
=> ${loginName} 님 안녕하세요 !!! <br>
</c:if>
<c:if test="${not empty message}">
=> ${message}<br>
</c:if>
<hr>
&nbsp;<span id="axloginf" class="textlink">AxLoginF</span>&nbsp;
&nbsp;<span id="axjoinf" class="textlink">AxjoinF</span>&nbsp;
&nbsp;<span id="axmlist" class="textlink">AxMList</span>&nbsp;
&nbsp;<span id="axblist" class="textlink">AxBList</span>&nbsp;
<a href="home">[HOME]</a>
<hr>
<div id="resultArea1"></div>
<div id="resultArea2"></div>

</body>
</html>