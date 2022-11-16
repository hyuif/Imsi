<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>** 거래게시판 디테일 **</title>
    <link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css">
	<link rel="stylesheet" type="text/css" href="resources/myLib/home.css">
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
			self.location="t_blist"
				+"${pageMaker.makeQuery(1)}"
				+"&searchType="
				+$('#searchType').val()
				+"&keyword="
				+$('#keyword').val()
		}); //click
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
    <main>
        





<br>
<c:if test="${not empty message}">
	${message}<br>
</c:if>
<hr>

<!-- &nbsp;&nbsp;<a href="binsertf">글쓰기</a> -->
<%-- <c:if test="${not empty loginID}">
&nbsp;&nbsp;<a href="binsertf">새글등록</a>
</c:if> --%>
<br>



<h2>** 거래게시판 디테일 **</h2>
<c:if test="${not empty apple}">
    <table>
        <tr height="40" width="100">
        <td>
        	<c:if test="${apple.trade=='sell'}">판매</c:if>
        	<c:if test="${apple.trade=='buy'}">구매</c:if>
        </td></tr>
        <tr height="40" width="100"><td><b>${apple.title}</b></td></tr>
        <tr height="40" id="test111"><td>글번호 : ${apple.seq}&nbsp;</td><td>&nbsp;${apple.id}&nbsp;</td>
                            <td>&nbsp;조회수 : ${apple.cnt}&nbsp;</td><td>&nbsp;${apple.regdate}</td></tr>
        <tr height="100" width="100"><td><img height="300" width="300" src="${apple.uploadfile}"><br>${apple.content}</td>
        </tr>
    </table>
</c:if>

<%-- <c:if test="${not empty message}">
<hr>
${message}<br>
</c:if> --%>
<%-- <c:if test="${loginID==apple.id || loginID=='admin' }">
<!-- 로그인 아이디랑 아이디랑 같으면 내가 쓴 글 -->

<!-- root 추가 : 삭제시 원글삭제 or 답글삭제 확인을 위함 -->

</c:if>
<c:if test="${not empty loginID}"> <!-- 로그인이 되어 있다면~ -->
답글~~
</c:if>

&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
&nbsp;&nbsp;<a href="home">[Home]</a> --%>

&nbsp;&nbsp;<a href="t_rinsertf?root=${apple.root}&step=${apple.step}&indent=${apple.indent}">[답글달기]</a><br>
&nbsp;&nbsp;<a href="t_bdetail?jCode=U&seq=${apple.seq}">[글수정]</a>
&nbsp;&nbsp;<a href="t_bdelete?seq=${apple.seq}&root=${apple.root}">[글삭제]</a>
&nbsp;&nbsp;<a href="t_bcrilist">목록으로</a>

</main>
<footer>
</footer>

<hr>

</body>
</html>