<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
		<title>팁 게시판</title>
		<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
		<link rel="stylesheet" type="text/css" href="resources/myLib/title_hidden.css">
		<script src="resources/myLib/jquery-3.2.1.min.js"></script>
		<script>
            // ** JS 에서 함수사용
            // => 최상위 객체 window는 생략가능
            // 		window.document.write("....");
            // => jQuery 호출
            // 	  -	window.jQuery('선택자_id,class,Tag..').click(function(){ ..........  })
            //	  - 늘 사용해야되는 jQuery 대신 $  기호를 사용 
            //   	$('#searchBtn').click(function(){ ....
            // => ready 이벤트
            //	  - script 구문이 Body 보다 위쪽에 위치하면 Tag 인식이 불가능함.
            //    - Body 가 Tag들을 모두 load 한 후 실행 되도록 이벤트를 적용
            //	  - js: window.onload
            //    - jQ: ready   -> $(document).ready(function() { ....... });
            // 					-> 이때  "(document).ready" 는 생략가능 

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
                    self.location = "hbcrilist"
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
        <h2>▶ 팁/정보 게시판 ◀</h2>
        <p class="Header_text1">&nbsp;이곳은 팁/정보 게시판 입니다. 자취 팁, 유용한 정보 글을 작성해주세요.</p>
        <p class="Header_text2">&nbsp;물건 판매 및 거래는 <a href="t_bcrilist">거래/나눔</a>게시판, 자유주제는 <a href="f_bcrilist">자유</a>게시판, 동아리 및 모임 주제는 <a href="cbcrilist">동아리/모임</a>게시판에 남겨주세요.</p>
        <br>
        </div>
        <br>
        
        <table id="board_container">
            <thead class="boardList_head">
              <tr>
                    <th class="headG">추천</th>
                    <th class="headT">제 목</th>
                    <th class="headI">글쓴이</th>
                    <th class="headR">날 짜</th>
                    <th class="headC">조회수</th>
                </tr>
            </thead>
            <tbody class="boardList_body">
                <c:if test="${not empty banana}">
                    <c:forEach var="board" items="${banana}">
                        <tr>
                            <td class="bodyG">1</td>
                            <td class="bodyT" id="title_hidden"><a href="tipbdetail?seq=${board.seq}">${board.title}</a></td>
                            <td class="bodyI"><img height="25" width="25" src="${board.image}">${board.id}</td>
                            <td class="bodyR" width="20%">${board.regdate}</td>
                            <td class="bodyC" width="10%">${board.cnt}</td>
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
                    <!-- New_ver01_Cri : pageMaker.makeQuery(1) -->
                    <!-- New_ver02_SearchCri : pageMaker.searchQuery(1) -->
                    <a href="hbcrilist${pageMaker.searchQuery(pageMaker.spageNo-1)}">&lt;</a>&nbsp;&nbsp;

                    <!-- OLD_version 
    	=> EL 은 주석내에 있어도 JSP가 처리하여 변수명등에 오류있으면 500 발생할 수 있음.  
    <a href="bcrilist?currPage=1&rowsPerPage=5">FP</a>&nbsp;   
    <a href="bcrilist?currPage=${pageMaker.spageNo-1}&rowsPerPage=5">&lt;</a>&nbsp;&nbsp;  
    -->
                </c:when>
            </c:choose>
            <!-- Displag PageNo -->
            <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
                <c:if test="${i==pageMaker.cri.currPage}">
                    <font size="5" color="Orange">${i}</font>&nbsp;
                </c:if>
                <c:if test="${i!=pageMaker.cri.currPage}">

                    <a href="hbcrilist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;

                </c:if>
            </c:forEach>

            <c:choose>
                <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                    <a href="hbcrilist${pageMaker.searchQuery(pageMaker.epageNo+1)}">&nbsp;&gt;</a>

                </c:when>
            </c:choose>

        </div>
        <br>
        <br>
        <br>
        
            <div id="searchBar">
	            <select name="searchType" id="searchType">
	                <option value="n" ${pageMaker.cri.searchType==null ? 'selected' : '' }>전체</option>
	                <option value="t" ${pageMaker.cri.searchType=='t' ? 'selected' : '' }>제목</option>
	                <option value="c" ${pageMaker.cri.searchType=='c' ? 'selected' : '' }>내용</option>
	                <option value="i" ${pageMaker.cri.searchType=='i' ? 'selected' : '' }>ID(글쓴이)</option>
	                <option value="tc" ${pageMaker.cri.searchType=='tc' ? 'selected' : '' }>제목+내용
	                </option>
	                <option value="tci" ${pageMaker.cri.searchType=='tci' ? 'selected' : '' }>제목+내용+글쓴이
	                </option>
	            </select>
	            <input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
	            <button id="searchBtn">Search</button>
        		</div>

        <div class="new_Write">
		<!-- 아이디 로그인할때만 가능하게 -->
        <c:if test="${not empty loginID}">
        &nbsp;&nbsp;<a href="tipbinsertf">새글등록</a>
        </c:if>
        <c:if test="${empty loginID}">
		&nbsp;&nbsp;<p onclick="alert('로그인후 이용해주세요')">새글등록</p>        
        </c:if>
    </div>
</div>
    <br>
    <br>

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
                <div><a href="">이용약관</a> | <a href="">개인정보취급방침</a></div>
            </span>
        </div>
        <br>
    </footer>





</body>

</html>