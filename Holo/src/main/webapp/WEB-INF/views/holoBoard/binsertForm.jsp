<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>** Board Insert Spring_MVC2 **</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
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
<h2>** Board Insert Spring_MVC2 **</h2>
<form action="hbinsert" method="Post" enctype="multipart/form-data">
<table>
<tr height="40"><td>I D</td>
		<td><input type="text" name="id" value="${loginID}" size="20" style="float: left;" readonly ></td></tr>
	<tr height="40">
		<td><input size="40" type="text" name="title" placeholder="제목을 입력해 주세요."></td></tr>
	<tr height="40">
		<td><textarea rows="7" cols="100" name="content" placeholder="내용을 입력해 주세요."></textarea></td>
	</tr>
		<tr height="40">
		<td><img src="" class="select_img"><br>
			<input type="file" name="uploadfilef" id="uploadfilef"></td></tr>
			<script>
			// 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
			// 이를 해결하기 위해 FileReader이라는 Web API를 사용
			// => 이 를 통해 url data를 얻을 수 있음.
			//    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
			// ** FileReader
			// => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여,
			//    읽을 파일을 가리키는File 혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
			//    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.	
			// => FileReader.readAsDataURL()
			//	  지정된 Blob의 내용 읽기를 시작하고, 완료되면 result 속성에 파일 데이터를 나타내는 data: URL이 포함됨.
			// => FileReader.onload 이벤트의 핸들러.
			//    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
			// => e.target : 이벤트를 유발시킨 DOM 객체
			// => type="file" 은 복수개의 파일을 업로드할수 있도록 설계됨
			//    그러므로 files[] 배열 형태의 속성을 가짐
				$('#uploadfilef').change(function(){
					if(this.files && this.files[0]) {
						var reader = new FileReader;
						reader.readAsDataURL(this.files[0]);
			 			reader.onload = function(e) {
		 					$(".select_img").attr("src", e.target.result)
		 									.width(80).height(100);
		 				} // onload_function
			 		} // if	
				}); //change
			</script>
	<tr><td></td>
		<td><input type="submit" value="등록">&nbsp;&nbsp;
			<input type="reset" value="취소">
		</td></tr>
	</table>
</form>

</div>
<hr>
&nbsp;&nbsp;<a href="hblist">boardList</a>
&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
&nbsp;&nbsp;<a href="home">[Home]</a>
</body>
</html>