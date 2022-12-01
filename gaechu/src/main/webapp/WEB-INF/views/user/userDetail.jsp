<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/myLib/userDetail.css">

<title>내 정보</title>
<script>
function goto() {
    if (confirm("탈퇴하시겠습니까??")) {
        location.href = "userdelete?id=${apple.id }";
    }
}
</script>
</head>
<div>
	<a href="home" class="logo">logo</a>
</div>
<body>
<hr>
<c:if test="${loginID=='admin' or loginID==apple.id}">

<c:if test="${loginID==apple.id}">
<h2>마이페이지</h2>
</c:if>
<c:if test="${loginID=='admin'}">
<h2>${apple.id}의 회원 정보 **</h2>
</c:if>


<c:if test="${not empty apple}"> 
	<table>
		<tr><td class="page">I D</td><td>${apple.id}</td></tr>
		<tr><td class="page">이름</td><td>${apple.name}</td></tr>
		<tr><td class="page">생년월일</td><td>${apple.birthday}</td></tr>
		<tr><td class="page">Gender</td><td>${apple.gender}</td></tr>
		<tr><td class="page">핸드폰 번호</td><td>${apple.phonenum}</td></tr>
		<tr><td class="page">회원 사진</td>
		<td><img src="${apple.uploadfile}" width="70" height="80"></td></tr>
	</table>
</c:if>

</c:if>

<c:if test="${loginID==apple.id}">
&nbsp;&nbsp;<a href="userdetail?jCode=U&id=${apple.id}" >내정보수정</a>
</c:if>
<c:if test="${loginID=='admin'}">
&nbsp;&nbsp;<a href="userdetail?jCode=U&id=${apple.id}" >회원정보수정</a>
</c:if>
<c:if test="${loginID=='admin' or loginID==apple.id}">
&nbsp;&nbsp; <a href="javascript:goto()" >회원탈퇴</a><br>
</c:if>

<hr>
<hr>
<c:if test="${loginID==apple.id}">
<h2>내가 쓴 글</h2>
</c:if>
<c:if test="${loginID!=apple.id}">
<h2>${apple.id}(이)가 쓴 글</h2>
</c:if>

<table>
			<thead>
				<tr height="30">
					<th width="300px">제 목</th>
					<th width="150px">날 짜</th>
					<th width="80px">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty service}">
					<c:forEach var="board" items="${service}">
						<tr height="30">
							<td><a href="searchdetail?seq=${board.seq}">${board.title}</a></td>
							<td class="ct">${board.regdate}</td>
							<td class="ct">${board.cnt}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		
<hr>		


</body>

</html>