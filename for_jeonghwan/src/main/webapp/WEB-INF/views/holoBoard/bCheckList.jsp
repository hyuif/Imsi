<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>** Board Check List Spring_Mybatis **</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css">
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script>
		function checkClear() {
			$('.clear').attr('checked',false);
			return false; // reset 의 기본 onclick 취소
		} //checkClear
	</script>
</head>
<body>
<h2>** Board Check List Spring_Mybatis **</h2>
<br>
<c:if test="${not empty message}">
	${message}<br>
</c:if>
<hr>
<div id="searchBar">
<!-- 검색후에도 조건을 유지하고 취소버튼 클릭시에는,
     조건만  clear 되도록 function checkClear() 추가함 
     ( reset 버튼은 기본적으로 새로고침과 동일하게 처리되어 ${check} 로 전달된 조건이 계속 적용되기때문  -->
	<form action="bchecklist" method="post">
		<b>ID : </b>
		<c:set var="ckPrint" value="false" />
		<c:forEach  var="id" items="${check}" >
			<c:if test="${id=='admin'}">
				<input type="checkbox" name="check" value="admin" checked class="clear">관리자&nbsp;
				<c:set var="ckPrint" value="true" />
			</c:if>
		</c:forEach>
		<c:if test="${not ckPrint}">
			<input type="checkbox" name="check" value="admin">관리자&nbsp;
		</c:if>
		 
		<c:set var="ckPrint" value="false" />
		<c:forEach  var="id" items="${check}" >
			<c:if test="${id=='teacher'}">
				<input type="checkbox" name="check" value="teacher" checked class="clear">Teacher&nbsp;
				<c:set var="ckPrint" value="true" />
			</c:if>
		</c:forEach>
		<c:if test="${not ckPrint}">
			<input type="checkbox" name="check" value="teacher">Teacher&nbsp;
		</c:if> 
		 
		<c:set var="ckPrint" value="false" />
		<c:forEach  var="id" items="${check}" >
			<c:if test="${id=='green'}">
				<input type="checkbox" name="check" value="green" checked class="clear">Green&nbsp;
				<c:set var="ckPrint" value="true" />
			</c:if>
		</c:forEach>
		<c:if test="${not ckPrint}">
			<input type="checkbox" name="check" value="green">Green&nbsp;
		</c:if> 
		 
		<c:set var="ckPrint" value="false" />
		<c:forEach  var="id" items="${check}" >
			<c:if test="${id=='banana'}">
				<input type="checkbox" name="check" value="banana" checked class="clear">Banana&nbsp;
				<c:set var="ckPrint" value="true" />
			</c:if>
		</c:forEach>
		<c:if test="${not ckPrint}">
			<input type="checkbox" name="check" value="banana">Banana&nbsp;
		</c:if> 
		 
		<c:set var="ckPrint" value="false" />
		<c:forEach  var="id" items="${check}" >
			<c:if test="${id=='apple'}">
				<input type="checkbox" name="check" value="apple" checked class="clear">Apple&nbsp;
				<c:set var="ckPrint" value="true" />
			</c:if>
		</c:forEach>
		<c:if test="${not ckPrint}">
			<input type="checkbox" name="check" value="apple">Apple&nbsp;
		</c:if>
		
		<input type="submit" value="검색">&nbsp;
		<input type="reset" value="취소" onclick="checkClear()">
		
	</form>	 
</div>
<br><hr>

<table width=100%> 
	<tr bgcolor="Gold" height="30">
		<th>Seq</th><th>Title</th><th>I D</th><th>RegDate</th><th>조회수</th>
	</tr>
	<c:if test="${not empty banana}">
		<c:forEach  var="board" items="${banana}" >
		<tr height="30">
			<td>${board.seq}</td>
			<td>
				<!-- 답글 등록후 indent 에 따른 들여쓰기 
						=> 답글인 경우에만 적용  -->
				<c:if test="${board.indent > 0}">
					<c:forEach begin="1" end="${board.indent}">
						<span>&nbsp;&nbsp;</span>
					</c:forEach>
					<span style="color:blue">re..</span>
				</c:if>
			
				<!-- 로그인 한 경우에만 title을 클릭하면 content를 볼 수 있도록 함
						=> bdetail 을 실행함 -->
				<c:if test="${not empty loginID}">
					<a href="bdetail?seq=${board.seq}">${board.title}</a>
				</c:if> 
				<c:if test="${empty loginID}">
				    ${board.title}
				</c:if>      
			</td>
			
			<td>
				<c:if test="${loginID=='admin'}">
					<a href="mdetail?id=${board.id}">${board.id}</a>
				</c:if> 
				<c:if test="${loginID!='admin'}">
				    ${board.id}
				</c:if>
			</td> 
			
			<td>${board.regdate}</td><td>${board.cnt}</td>
		</tr>	
		</c:forEach>
	</c:if>
	<c:if test="${empty banana}">
		<tr height="30"><td colspan="5">** 출력할 자료가 1건도 없습니다 **</td></tr>
	</c:if>
</table>
<hr>
<hr>
<c:if test="${not empty loginID}">
&nbsp;&nbsp;<a href="binsertf">새글등록</a>
</c:if>
&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
&nbsp;&nbsp;<a href="home">[Home]</a>
</body>
</html>