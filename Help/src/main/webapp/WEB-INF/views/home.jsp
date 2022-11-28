<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/inCheck.js"></script>
<script src="resources/myLib/Test01.js"></script>


<script>
   let iCheck=false;
   let pCheck=false;
   
   $(function(){
      $('#id').focus();
      // ** ID
      $('#id').keydown(function(e){
         if ( e.which==13 ) {
            e.preventDefault();
            // => form 에 submit 이 있는경우
            // => enter 누르면 자동 submit 발생되므로 이를 제거함
            $('#password').focus();
         }
      }).function(){    
         iCheck=idCheck();
      }; //id
      
      // ** Password
      $('#password').keydown(function(e){
         if ( e.which==13 ) {
            e.preventDefault();
            $('#password2').focus();
         }
      }).function(){    
         pCheck=   pwCheck();
      }; //password
   }); //ready
   
   function inCheck() {
         if (iCheck==false) { $('#iMessage').html(' id 를 확인하세요 !!');}
         if (pCheck==false) { $('#pMessage').html(' Password 를 확인하세요 !!');}
         
         if ( iCheck && pCheck ) return true; // submit 진행  
         else return false;
   } //inCheck
   
   
   $(function searchsearch() {
       $('#searchBtn2').click(function () {
           self.location = "searchsearch"
               + "${pageMaker.makeQuery(1)}"
               + "&keyword2="
               + $('#keyword2').val()
       }); //click
   }); //ready	
   
</script>


</head>
<body>
	<div class="contents">
		<header>
			<div class="header">
				<div>
					<a href="home" class="logo">logo</a>
				</div>
				<div class="search">
				<form action="searchsearch">
					<input class="searchBox" type="text" size="40"
						placeholder="게시판 & 통합검색" type="text" name="keyword2" id="keyword2" /> 
					<input class="searchClick" id="searchBtn2" type="submit" value="검색" />
				</form>
				</div>

			</div>

			<nav class="headerM">
				<div>
					<ul class="category">
						<li><a href="noticelist" class="liText">공지사항 </a></li>
						<li><a href="tipblist" class="liText">팁/정보 </a></li>
						<li><a href="f_bcrilist" class="liText">자유게시판 </a></li>
						<li><a href="t_bcrilist" class="liText">거래/나눔 </a></li>
						<li><a href="cbcrilist" class="liText">동아리/모임 </a></li>
					</ul>
				</div>
			</nav>

		</header>

		<main>
			<div class="main">
					<a href="" class="banner"></a>
					<div>
				<c:if test="${not empty loginID}">
					<h1> ${loginName} 님 !!!</h1>
					<br>
      &nbsp;&nbsp;<a href="logout">Logout</a>
      &nbsp;&nbsp;<a href="userdetail">내정보</a>
				</c:if>

				<c:if test="${loginID=='admin'}">
					<a href="user">회원 목록</a>&nbsp;&nbsp;
	 </c:if>

				<c:if test="${empty loginID}">
					<form action="login" method="post">
						<table>
							<tr>
								<td bgcolor="PaleTurquoise">I D</td>
								<td><input type="text" name="id" id="id"><br>
								</td>
							</tr>
							<tr>
								<td bgcolor="PaleTurquoise ">Password</td>
								<td><input type="password" name="password" id="password"><br>
								</td>
							</tr>
							<tr>
								<td></td>
								<td><input type="submit" value="Login"
									onclick="return inCheck()">&nbsp;&nbsp; <span
									id="pMessage" class="eMessage"></span> <br> <a
									href="joinf">회원가입</a>&nbsp;&nbsp; <a href="logout">Logout</a></td>
							</tr>
						</table>
					</form>
					<br>
				</c:if>
				</div>
			</div>
	
			<div class="boards">
				<section>
					<h4>
						최신 공지사항 <a href="noticelist">+</a>
					</h4>
					<hr>
					<table width=100%>
						<thead>
							<tr height="30">
								<th width="50%">제목</th>
								<th width="20%">글쓴이</th>
								<th width="30%">날짜</th>
							</tr>
						</thead>
						<c:if test="${not empty nlist}">
							<c:forEach var="board" items="${nlist}">
								<tr height="30">
									<td width="50%"><a href="noticedetail?seq=${board.seq}">${board.title}</a></td>
									<td class="ct" width="20%">${board.id}</td>
									<td class="ct" width="30%">${board.regdate}</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</section>
				<section>
					<h4>
						인기 자유글 <a href="f_bcrilist">+</a>
					</h4>
					<hr>
					<table width=100%>
						<thead>
							<tr height="30">
								<th width="50%">제목</th>
								<th width="30%">글쓴이</th>
								<th width="20%">조회수</th>
							</tr>
						</thead>
						<c:if test="${not empty fhotlist}">
							<c:forEach var="fboard" items="${fhotlist}">
								<tr height="30">

									<td width="40%"><a href="f_bdetail?seq=${fboard.seq}">${fboard.title}</a></td>
									<td class="ct" width="20%">${fboard.id}</td>
									<td class="ct" width="10%">${fboard.cnt}</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</section>
			</div>
			<div class="boards">
				<section>
					<h4>
						최신 팁/정보 <a href="hbcrilist">+</a>
					</h4>
					<hr>
					<table width=100%>
						<thead>
							<tr height="30">
								<th width="50%">제목</th>
								<th width="20%">글쓴이</th>
								<th width="30%">날짜</th>
							</tr>
						</thead>
						<c:if test="${not empty hlist}">
							<c:forEach var="hboard" items="${hlist}">
								<tr height="30">
									<td width="40%"><a href="hbdetail?seq=${hboard.seq}">${hboard.title}</a></td>
									<td class="ct" width="20%">${hboard.id}</td>
									<td class="ct" width="30%">${hboard.regdate}</td>

								</tr>
							</c:forEach>
						</c:if>
					</table>
				</section>
				<section>
					<h4>
						인기 팁/정보 <a href="hbcrilist">+</a>
					</h4>
					<hr>
					<table width=100%>
						<thead>
							<tr height="30">
								<th width="50%">제목</th>
								<th width="30%">글쓴이</th>
								<th width="20%">조회수</th>
							</tr>
						</thead>
						<c:if test="${not empty hhotlist}">
							<c:forEach var="hboard" items="${hhotlist}">
								<tr height="30">
									<td width="40%"><a href="hbdetail?seq=${hboard.seq}">${hboard.title}</a></td>
									<td class="ct" width="20%">${hboard.id}</td>
									<td class="ct" width="10%">${hboard.cnt}</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
				</section>
			</div>
			<div class="boards">
				<section>
					<h4>
						최신 거래글 <a href="t_bcrilist">+</a>
					</h4>
					<hr>
					<table width=100%>
						<thead>
							<tr height="30">
								<th width="50%">제목</th>
								<th width="20%">글쓴이</th>
								<th width="30%">날짜</th>
							</tr>
						</thead>
						<c:if test="${not empty tlist}">
							<c:forEach var="tboard" items="${tlist}">
								<tr height="30">
									<td width="40%"><a href="t_bdetail?seq=${tboard.seq}">${tboard.title}</a></td>
									<td class="ct" width="20%">${tboard.id}</td>
									<td class="ct" width="30%">${tboard.regdate}</td>

								</tr>
							</c:forEach>
						</c:if>
					</table>
				</section>
				<section>
					<h4>
						인기 동아리 <a href="cbcrilist">+</a>
					</h4>
					<hr>
					<table width=100%>
						<thead>
							<tr height="30">
								<th width="50%">제목</th>
								<th width="30%">글쓴이</th>
								<th width="20%">조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty chotlist}">
								<c:forEach var="cboard" items="${chotlist}">
									<tr height="30">
										<td width="40%"><a href="cbdetail?seq=${cboard.seq}">${cboard.title}</a></td>
										<td class="ct" width="20%">${cboard.id}</td>
										<td class="ct" width="10%">${cboard.cnt}</td>
									</tr>
								</c:forEach>
							</c:if>
					</table>
				</section>
			</div>

		</main>
	</div>
	<footer>
		<div class="bottom">
			<ul class="btMenu">
				<li><a href="">공지사항</a></li>
				<li><a href="">팁/정보</a></li>
				<li><a href="">자유게시판</a></li>
				<li><a href="">거래/나눔</a></li>
				<li><a href="">동아리/모임</a></li>
			</ul>
			<span>
				<div>Copyright (c) Holo.net All rights reserved.</div>
				<div>Contact us, holo at gmail dot com</div>
				<div>
					<a href="">이용약관</a> | <a href="">개인정보취급방침</a>
				</div>
			</span>
		</div>
		<br>
	</footer>

</body>

</html>
