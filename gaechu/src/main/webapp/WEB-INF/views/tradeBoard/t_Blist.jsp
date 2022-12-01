<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>거래/나눔 게시판</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
	<link rel="stylesheet" type="text/css" href="resources/myLib/title_hidden.css">
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script>
	
    $(function() {
		// 1) SearchType 이 '전체' 면 keyword 클리어
		$('#searchType').change(function(){
			if ( $(this).val()=='n' ) $('#keyword').val('');
		}); //change
		
		// 2) 검색 후 요청 
		// => 검색조건 입력 후 첫 Page 요청
		//    이때는 서버에 searchType, keyword 가 전달되기 이전이므로 makeQuery 메서드사용
		// => self.location="bcrilist?currPage=?????" : 해당 요청을 서버로 전달 	
				
		// ** self.location	
		// 1) location 객체 직접사용 Test : url로 이동, 히스토리에 기록됨
		// 2) location 객체의 메서드
		// => href, replace('...'), reload()	
		
		$('#searchBtn').click(function(){
			self.location="t_bcrilist"
				+"${pageMaker.makeQuery(1)}"
				+"&searchType="
				+$('#searchType').val()
				+"&keyword="
				+$('#keyword').val()
		}); //click
	}); //ready */
	
	function checkClear() {
		$('.clear').attr('checked',false);
		return false; // reset 의 기본 onclick 취소
	} //checkClear
	
	
	</script>
</head>
<body>
    <div class="contents">
        <!-- header -->
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <br>
        <div class="Header_box">
        <h2>▶ 거래 게시판 ◀</h2>
        <p class="Header_text1">&nbsp;이곳은 거래/나눔 게시판 입니다. 물건 거래, 나눔 글을 작성해주세요.</p>
        <p class="Header_text2">&nbsp;팁 관련 주제는 <a href="tipblist">팁/정보</a>게시판, 자유주제는 <a href="f_bcrilist">자유</a>게시판, 동아리 및 모임 주제는 <a href="cbcrilist">동아리/모임</a>게시판에 남겨주세요.</p>
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
					<c:forEach var="trade_board" items="${banana}">
					<tr>
					<td class="bodyS">${trade_board.seq}</td>
			
					<td id="title_hidden" class="bodyT" >
					<!-- 답글 등록후 indent 에 따른 들여쓰기 
					=> 답글인 경우에만 적용  -->
					<c:if test="${trade_board.indent > 0}">
						<c:forEach begin="1" end="${trade_board.indent}">
							<span>&nbsp;&nbsp;</span>
						</c:forEach>
							<span style="color:hotpink">re..</span>
						</c:if>
					<!-- 로그인 한 경우에만 title을 클릭하면 content를 볼 수 있도록 함
						=> t_bdetail 을 실행함 -->
					<c:if test="${empty loginID}">
				   		${trade_board.title}
					</c:if>		
					<c:if test="${not empty loginID}">
						<a href="t_bdetail?seq=${trade_board.seq}">${trade_board.title}</a>&nbsp;&nbsp;
					</c:if> 
					
					<!-- 구매,판매 빨간글씨로 제목 옆 표시 -->
					<c:if test="${trade_board.trade=='sell'}">
					    <span style="color:red">판매</span>
					</c:if>
					<c:if test="${trade_board.trade=='buy'}">
					    <span style="color:red">구매</span>
					</c:if>
					
					</td>
					<td class="bodyI"><img height="25" width="25" src="${trade_board.image}"><a href="userdetail?id=${trade_board.id}">${trade_board.id}</a></td>
					<td class="bodyR">${trade_board.regdate}</td>
					<td class="bodyC">${trade_board.cnt}</td>
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
				<a href="t_bcrilist${pageMaker.searchQuery(pageMaker.spageNo-1)}">&lt;</a>&nbsp;&nbsp; 
			</c:when>
		</c:choose>	
		<!-- Display PageNo -->
		<c:forEach  var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
			<c:if test="${i==pageMaker.cri.currPage}">
				<font size="5" color="Orange">${i}</font>&nbsp;
			</c:if>
			<c:if test="${i!=pageMaker.cri.currPage}">
				<a href="t_bcrilist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
			</c:if>
		</c:forEach>
		<!-- Next, Last -->
		<c:choose>
			<c:when test="${pageMaker.next && pageMaker.epageNo>0}">
				<a href="t_bcrilist${pageMaker.searchQuery(pageMaker.epageNo+1)}">&nbsp;&gt;</a>  
			</c:when>
		</c:choose>
	
	</div>
	<br>
	<br>
	<br>
	<div id="searchBar">
	<form action="t_bcrilist" method="get">
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="trade" items="${pageMaker.cri.check}" >
				<c:if test="${trade=='sell'}">
					<input type="checkbox" name="check" value="sell" checked class="clear">판매&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="sell">판매&nbsp;
			</c:if>
			 
			<c:set var="ckPrint" value="false" />
			<c:forEach  var="trade" items="${pageMaker.cri.check}" >
				<c:if test="${trade=='buy'}">
					<input type="checkbox" name="check" value="buy" checked class="clear">구매&nbsp;
					<c:set var="ckPrint" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not ckPrint}">
				<input type="checkbox" name="check" value="buy">구매&nbsp;
			</c:if> 
	
		<select name="searchType" id="searchType">
			<!-- <option value="n" selected> 을 조건 (cri.searchType 의 값) 에 따라 작성하기 위한 삼항식 
				=> value="n" : ~~~~.cri.searchType==null ? 'selected':''  첫화면 출력시 초기값 으로 selected
			-->
			<%-- <option value="n" ${pageMaker.cri.searchType==null ? 'selected' : ''}  disabled hidden>숨김</option> --%>
			<option value="tc" ${pageMaker.cri.searchType=='tc' ? 'selected' : ''} selected >제목+내용</option>
			<option value="t" ${pageMaker.cri.searchType=='t' ? 'selected' : ''}>제목</option>
			<option value="c" ${pageMaker.cri.searchType=='c' ? 'selected' : ''}>내용</option>
			<option value="i" ${pageMaker.cri.searchType=='i' ? 'selected' : ''}>ID(글쓴이)</option>
		</select>
		<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">	
		<button id="searchBtn" onclick="this.submit();">Search</button>
		</form>	
	</div>
	
	<div class="new_Write">
		<!-- 아이디 로그인할때만 가능하게 -->
        <c:if test="${not empty loginID}">
        &nbsp;&nbsp;<a href="t_binsertf">새글등록</a>
        </c:if>
        <c:if test="${empty loginID}">
		&nbsp;&nbsp;<p onclick="alert('로그인후 이용해주세요')">새글등록</p>      
        </c:if>
    </div>
</div>
<br>
<br>

	<!-- footer -->
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>