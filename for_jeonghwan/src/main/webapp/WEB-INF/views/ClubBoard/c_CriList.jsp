<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>** Board Cri_PageList Spring_MVC2 **</title>
        <link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
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
            
            function checkClear() {
						$('.clear').attr('checked',false);
						return false; // reset 의 기본 onclick 취소
						} //checkClear
            
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

                /* $('#searchBtn').click(function () {
                    self.location = "hbcrilist"
                        + "${pageMaker.makeQuery(1)}"
                        + "&searchType="
                        + $('#searchType').val()
                        + "&keyword="
                        + $('#keyword').val()
                }); //click */
            }); //ready	
        </script>
    </head>

  <body>
        <div class="contents">
        <header>
            <div class="header">
                <div>
                    <a href="" class="logo">logo</a>
                </div>
                <div class="search">
                    <form action="">
                        <input class="searchBox" size="40" type="text" id="search" placeholder="게시판 & 통합검색">
                        <span>
                            <input class="searchClick" type="submit" value="검색">
                        </span>
                    </form>
                </div>

            </div>

            <nav class="headerM">
                <div>
                    <ul class="category">
                        <li>
                            <a href="noticelist" class="liText">공지사항
                            </a>
                        </li>
                        <li>
                            <a href="hbcrilist" class="liText">팁/정보
                            </a>
                        </li>
                        <li>
                            <a href="f_bcrilist" class="liText">자유게시판
                            </a>
                        </li>
                        <li>
                            <a href="t_bcrilist" class="liText">거래/나눔
                            </a>
                        </li>
                        <li>
                            <a href="cbcrilist" class="liText">동아리/모임
                            </a>
                        </li>
                        <li>
                            <a href="" class="liText">Q&A
                            </a>
                        </li>
                        
                    </ul>
                </div>
            </nav>

        </header>
        <br>
        <br>
        <h2>동아리/모임 게시판</h2>
        <br>
        <br>
        
        <table width=100%>
            <thead>
                <tr height="30">
                    <th width="50%">제목</th>
                    <th width="10%">글쓴이</th>
                    <th width="20%">날짜</th>
                    <th width="10%">조회수</th>
                    <th width="10%">추천</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty banana}">
                    <c:forEach var="board" items="${banana}">
                        <tr height="30">
                            <td width="45%">&nbsp;
                            [${board.place}]
                            &nbsp; <a href="cbdetail?seq=${board.seq}">${board.title}</a> 
                            </td>
                            <td width="15%">${board.id}</td>
                            <td class="ct" width="20%">${board.regdate}</td>
                            <td class="ct" width="10%">${board.cnt}</td>
                            <td class="ct" width="10%">1</td>
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
                    <a href="cbcrilist${pageMaker.searchQuery(pageMaker.spageNo-1)}">&lt;</a>&nbsp;&nbsp;

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

                    <a href="cbcrilist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;

                </c:if>
            </c:forEach>

            <c:choose>
                <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                    <a href="cbcrilist${pageMaker.searchQuery(pageMaker.epageNo+1)}">&nbsp;&gt;</a>

                </c:when>
            </c:choose>

        </div>
        
  <div id="searchBar">
            
  	<form action="cbcrilist" method="get">
			<b>검색 지역선택 : </b>
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${place=='서울'}">
					<input type="checkbox" name="check" value="서울" checked class="clear">서울&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="서울">서울&nbsp;
			</c:if>
			 
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${place=='인천'}">
					<input type="checkbox" name="check" value="인천" checked class="clear">인천&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="인천">인천&nbsp;
			</c:if> 
			 
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${place=='세종'}">
					<input type="checkbox" name="check" value="세종" checked class="clear">세종&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="세종">세종&nbsp;
			</c:if> 
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${place=='경기'}">
					<input type="checkbox" name="check" value="경기" checked class="clear">경기&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="경기">경기&nbsp;
			</c:if> 
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${place=='강원'}">
					<input type="checkbox" name="check" value="강원" checked class="clear">강원&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="강원">강원&nbsp;
			</c:if> 
			 
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='대전'}">
					<input type="checkbox" name="check" value="대전" checked class="clear">대전&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="대전">대전&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='충북'}">
					<input type="checkbox" name="check" value="충북" checked class="clear">충북&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="충북">충북&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='충남'}">
					<input type="checkbox" name="check" value="충남" checked class="clear">충남&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="충남">충남&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='대구'}">
					<input type="checkbox" name="check" value="대구" checked class="clear">대구&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="대구">대구&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='부산'}">
					<input type="checkbox" name="check" value="부산" checked class="clear">부산&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="부산">부산&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='울산'}">
					<input type="checkbox" name="check" value="울산" checked class="clear">울산&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="울산">울산&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='경북'}">
					<input type="checkbox" name="check" value="경북" checked class="clear">경북&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="경북">경북&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='경남'}">
					<input type="checkbox" name="check" value="경남" checked class="clear">경남&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="경남">경남&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='광주'}">
					<input type="checkbox" name="check" value="광주" checked class="clear">광주&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="광주">광주&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='전북'}">
					<input type="checkbox" name="check" value="전북" checked class="clear">전북&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="전북">전북&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='전남'}">
					<input type="checkbox" name="check" value="전남" checked class="clear">전남&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="전남">전남&nbsp;
			</c:if>
			
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="place" items="${pageMaker.cri.check}" >
				<c:if test="${plce=='제주'}">
					<input type="checkbox" name="check" value="제주" checked class="clear">제주&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="제주">제주&nbsp;
			</c:if>
			

			<input type="reset" value="초기화" onclick="checkClear()">
			
			<!-- <input type="submit" value="검색">&nbsp; -->
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
      <button id="searchBtn" onclick="this.submit()">Search</button>
		
		
		
	</form>	 
 </div>

        &nbsp;&nbsp;<a href="cbinsertf">새글등록</a>
        &nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
        &nbsp;&nbsp;<a href="home">[Home]</a>
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