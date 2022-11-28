<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
<title>** 공지사항</title>
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
		<h2>Search Detail</h2>
		<hr>
		<table>
			<tr height="40">
				<td bgcolor="Khaki">Seq</td>
				<td>${apple.seq}</td>
			</tr>
			<tr height="40">
				<td bgcolor="Khaki">I D</td>
				<td>${apple.id}</td>
			</tr>
			<tr height="40">
				<td bgcolor="Khaki">Title</td>
				<td>${apple.title}</td>
			</tr>
			<tr height="40">
				<td bgcolor="Khaki">Content</td>
				<td><img height="300" width="300" src="${apple.uploadfile}"><br>${apple.content}</td>
			</tr>
			<tr height="40">
				<td bgcolor="Khaki">조회수</td>
				<td>${apple.cnt}</td>
			</tr>
		</table>
		<hr>
		&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a> 
		&nbsp;&nbsp;<a href="home">[Home]</a>

	</div>
</body>
</html>