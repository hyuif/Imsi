<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
<title>** MemberDetail Web_MVC2 **</title>
<script>
function goto() {
    if (confirm("탈퇴하시겠습니까??")) {
        location.href = "userdelete?id=${apple.id }";
    }
}
</script>
</head>
<body>
<c:if test="${loginID!='admin'}">
<h2>** 마이페이지 **</h2>
</c:if>
<c:if test="${loginID=='admin'}">
<h2>** ${apple.id}의 회원 정보 **</h2>
</c:if>
<hr>
<c:if test="${not empty apple}"> 
	<table>
		<tr height="40"><td bgcolor="lavender">I D</td><td>${apple.id}</td></tr>
		<tr height="40"><td bgcolor="lavender">Name</td><td>${apple.name}</td></tr>
		<tr height="40"><td bgcolor="lavender">Birthday</td><td>${apple.birthday}</td></tr>
		<tr height="40"><td bgcolor="lavender">Gender</td><td>${apple.gender}</td></tr>
		<tr height="40"><td bgcolor="lavender">Phonenum</td><td>${apple.phonenum}</td></tr>
		<tr height="40"><td bgcolor="lavender">Image</td>
		<td><img src="${apple.uploadfile}" width="70" height="80"></td></tr>
	</table>
</c:if>
<c:if test="${not empty message}">
<hr>
${message}<br>
</c:if>
<hr>

<c:if test="${loginID!='admin'}">
&nbsp;&nbsp;<a href="userdetail?jCode=U&id=${apple.id}" >[내정보수정]</a>
</c:if>
<c:if test="${loginID=='admin'}">
&nbsp;&nbsp;<a href="userdetail?jCode=U&id=${apple.id}" >[회원정보수정]</a>
</c:if>

<!-- memberList 에서 요청한 경우는 session 에 보관된 id로는 수정 할 수 없기때문에 parameter로 처리함  -->
&nbsp;&nbsp; <a href="javascript:goto()" >[회원탈퇴]</a><br>
&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
&nbsp;&nbsp;<a href="home">[Home]</a>
</body>
</html>