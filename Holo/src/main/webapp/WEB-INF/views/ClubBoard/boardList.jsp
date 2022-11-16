<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="resources/myLib/home.css">
	<title>** BoardList Spring_MVC2 **</title>
</head>
<body>
  <header>
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
<h2>** BoardList Spring_MVC2 **</h2>
<br>
<c:if test="${not empty message}">
	${message}<br>
</c:if>
<hr>
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
			<a href="hbdetail?seq=${board.seq}">${board.title}</a>

			</td>
			
			<td><a href="hbdetail?id=${board.id}">${board.id}</a>
			</td> 
			
			<td>${board.regdate}</td><td>${board.cnt}</td>
		</tr>	
		</c:forEach>
	</c:if>
</table>
<hr>
<hr>
&nbsp;&nbsp;<a href="hbinsertf">새글등록</a>

&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
&nbsp;&nbsp;<a href="home">[Home]</a>
</body>
</html>