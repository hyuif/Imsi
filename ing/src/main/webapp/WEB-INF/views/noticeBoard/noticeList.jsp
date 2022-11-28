<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>공지 게시판</title>
       	<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
		<link rel="stylesheet" type="text/css" href="resources/myLib/title_hidden.css">
		<script src="resources/myLib/jquery-3.2.1.min.js"></script>
        <script>
          

            $(function () {
                // 1) SearchType 이 '전체' 면 keyword 클리어
                // $('#searchType').change(function () {
                //    if ($(this).val() == 'n') $('#keyword').val('');
                //}); //change

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
        <div class="Header_box">
        <h2>▶ 공지사항 ◀</h2>
        <p class="Header_text1">&nbsp;이곳은 공지사항 게시판 입니다.</p>
        <p class="Header_text2">&nbsp;관리자 외에 글을 쓸 수 없으며, 글 읽기만 가능합니다.</p>
        <br>
        </div>
        <br>
        
        <table  id="board_container">
            <thead class="boardList_head">
                <tr>
                    <th class="headS">번호</th>
                    <th class="headT">제 목</th>
                    <th class="headI">글쓴이</th>
                    <th class="headR">날 짜</th>
					<th class="headC">조회수</th>
				</tr>
            </thead>
            <tbody class="boardList_body">
				<c:if test="${not empty banana}">
					<c:forEach var="board" items="${banana}">
						<c:if test="${board.fix ==1 }">
							<tr bgcolor="lightBlue">
								<td class="notice">공지</td>
								<td class="bodyT" id="title_hidden"><a href="noticedetail?seq=${board.seq}">${board.title}</a></td>
								<td class="bodyI"><img height="25" width="25" src="${board.image}">&nbsp;${board.id}</td>
								<td class="bodyR">${board.regdate}</td>
								<td class="bodyC">${board.cnt}</td>
							</tr>

						</c:if>
						<c:if test="${board.fix !=1 }">
							<tr>
								<td class="bodyS">${board.seq}</td>
								<td class="bodyT" id="title_hidden"><a href="noticedetail?seq=${board.seq}">${board.title}</a></td>
								<td class="bodyI"><img height="25" width="25" src="${board.image}">&nbsp;${board.id}</td>
								<td class="bodyR">${board.regdate}</td>
								<td class="bodyC">${board.cnt}</td>
							</tr>
						</c:if>

					</c:forEach>
				</c:if>
			</tbody>
        </table>
        
        <!-- Cri_Page -->
        <div align="center">
            <!-- First, Prev -->
            <c:choose>
                <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.spageNo-1)}">&lt;</a>&nbsp;&nbsp;

                </c:when>
            </c:choose>
            <!-- Displag PageNo -->
            <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
                <c:if test="${i==pageMaker.cri.currPage}">
                    <font size="5" color="Orange">${i}</font>&nbsp;
                </c:if>
                <c:if test="${i!=pageMaker.cri.currPage}">

                    <a href="noticelist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;

                </c:if>
            </c:forEach>

            <c:choose>
                <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.epageNo+1)}">&nbsp;&gt;</a>

                </c:when>
            </c:choose>

        </div>
       	<br>
		<br>
		<br>
		
            <div id="searchBar">
	            <select name="searchType" id="searchType">
	                <option value="t" ${pageMaker.cri.searchType=='t' ? 'selected' : '' }>제목</option>
	                <option value="c" ${pageMaker.cri.searchType=='c' ? 'selected' : '' }>내용</option>
	                <option value="tc" ${pageMaker.cri.searchType=='tc' ? 'selected' : '' }>제목+내용
	                </option>
	            </select>
	            <input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
	            <button id="searchBtn">Search</button>
        		</div>
        		
		<div class="new_Write">
			<c:if test="${loginID=='admin'}">
       			&nbsp;&nbsp;<a href="noticeinsertf">새글등록</a>
			</c:if>  
      	 	<c:if test="${loginID!='admin'}">
       			&nbsp;&nbsp;<p onclick="alert('관리자만 사용 가능한 기능입니다.')">새글등록</p>
			</c:if> 
        </div>
    </div>
    <br>
    <br>

    <footer>
        <div class="bottom">
            <ul class="btMenu">
                <li><a href="">A</a></li>
                <li><a href="">B</a></li>
                <li><a href="">C</a></li>
                <li><a href="">D</a></li>
                <li><a href="">E</a></li>
                <li><a href="">F</a></li>
            </ul>
            <span>
                <div>Copyright (c) Holo.net All rights reserved.</div>
                <div>Contact us, holo at gmail dot com</div>
                <div><a href="">이용약관</a> | <a href="">개인정보취급방침</a></div>
            </span>
        </div>
        <br>
    </footer>





</body>

</html>