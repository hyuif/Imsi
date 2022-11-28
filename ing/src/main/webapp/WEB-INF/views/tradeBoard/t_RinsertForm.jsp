<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>답글달기</title>
    <link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
    <script src="resources/myLib/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class="contents">
    <header>
        <div class="header">
            <div>
                <a href="home" class="logo">logo</a>
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
    <h2>거래/나눔 게시판 답글 등록</h2>
    <br>
    <br>
        
	<form action="t_rinsert" method="post">
	    <table>
	        <tr height="40"><td bgcolor="Violet">I D</td>
	            <td><input type="text" name="id" size="20" value="${loginID}" readonly></td></tr>
	            
	        <tr height="40"><td bgcolor="Violet">Title</td>
	            <td><input type="text" name="title" placeholder="반드시 입력하세요~~"></td></tr>
	            
	        <tr height="40"><td bgcolor="Violet">Content</td>
	            <td><textarea rows="5" cols="50" name="content"></textarea></td>
	        </tr>
	        
	           <!-- 답글등록시 필요한 부모글의 root, step, indent 전달 위함 
	                -> 매핑메서드의 인자로 정의된 vo 와 param 모두 가능   -->
	           
	        <tr height="40"><td></td>
	            <td><input type="text" name="root" value="${t_BoardVO.root}" hidden>
	                 <input type="text" name="step" value="${t_BoardVO.step}" hidden>
	                 <input type="text" name="indent" value="${t_BoardVO.indent}" hidden>
	            </td>
	        </tr>
	        
	        <tr><td></td>
	            <td><input type="submit" value="등록">&nbsp;&nbsp;
	                 <input type="reset" value="취소">
	        </td></tr>
	    </table>
	</form>
</div>

	&nbsp;&nbsp;<a href="t_bcrilist">목록으로</a>
	&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
	&nbsp;&nbsp;<a href="home">[Home]</a>

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
