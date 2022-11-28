<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Notice_Board PageList</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script>
           /* 

            $(function () {
                // 1) SearchType 이 '전체' 면 keyword 클리어
                $('#searchType').change(function () {
                    if ($(this).val() == 'n') $('#keyword').val('');
                }); //change

                // 2) 검색 후 요청 
                // => 검색조건 입력 후 첫 Page 요청
                //    이때는 서버에 searchType, keyword 가 전달되기 이전이므로 makeQuery 메서드사용
                // => self.location="bcrilist?currPage=?????" : 해당 요청을 서버로 전달 	

                // ** self.location	
                // 1) location 객체 직접사용 Test : url로 이동, 히스토리에 기록됨
                // 2) location 객체의 메서드
                // => href, replace('...'), reload()	

                $('#searchBtn').click(function () {
                    self.location = "noticelist"
                        + "${pageMaker.makeQuery(1)}"
                        + "&searchType="
                        + $('#searchType').val()
                        + "&keyword="
                        + $('#keyword').val()
                }); //click
            }); //ready	 */
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
							placeholder="게시판 & 통합검색" type="text" name="keyword2"
							id="keyword2" /> <input class="searchClick" id="searchBtn2"
							type="submit" value="검색" />
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
		<br>
		<h2>검색 결과</h2>
		<br> <br>

		<table width=100%>
			<thead>
				<tr height="30">
					<th width="40%">제 목</th>
					<th width="10%">글쓴이</th>
					<th width="20%">날 짜</th>
					<th width="10%">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty nservice}">
					<c:forEach var="nboard" items="${nservice}">
						<tr height="30" bgcolor="lightGray">
							<td width="40%"><a href="searchdetail?seq=${nboard.seq}">${nboard.title}</a></td>
							<td class="ct" width="20%"><img height="25" width="25" src="${nboard.image}">${nboard.id}</td>
							<td class="ct" width="10%">${nboard.regdate}</td>
							<td class="ct" width="10%">${nboard.cnt}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>



		<!-- Cri_Page -->
		<div align="center">
			<!-- First, Prev -->
			<c:choose>
				<c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
					<a href="searchsearch${pageMaker.searchQuery(pageMaker.spageNo-1)}">&lt;</a>&nbsp;&nbsp;

                </c:when>
			</c:choose>
			<!-- Displag PageNo -->
			<c:forEach var="i" begin="${pageMaker.spageNo}"
				end="${pageMaker.epageNo}">
				<c:if test="${i==pageMaker.cri.currPage}">
					<font size="5" color="Orange">${i}</font>&nbsp;
                </c:if>
				<c:if test="${i!=pageMaker.cri.currPage}">

					<a href="searchsearch${pageMaker.searchQuery(i)}">${i}</a>&nbsp;

                </c:if>
			</c:forEach>

			<c:choose>
				<c:when test="${pageMaker.next && pageMaker.epageNo>0}">
					<a href="searchsearch${pageMaker.searchQuery(pageMaker.epageNo+1)}">&nbsp;&gt;</a>

				</c:when>
			</c:choose>
		</div>
		<br> <br>

		<footer>
			<div class="bottom">
				<ul class="btMenu">
					<li><a href="">공지사항</a></li>
					<li><a href="">팁/정보</a></li>
					<li><a href="">자유게시판</a></li>
					<li><a href="">거래/나눔</a></li>
					<li><a href="">동아리/모임</a></li>
					<li><a href="">Q&A</a></li>
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