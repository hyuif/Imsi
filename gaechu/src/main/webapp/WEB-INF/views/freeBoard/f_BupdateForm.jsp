<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정</title>
    <link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
    <script src="resources/myLib/jquery-3.2.1.min.js"></script>
</head>
<body>
    <div class="contents">
<%@ include file="/WEB-INF/views/include/header.jsp" %>
      
        <br>
        <h2>자유게시판 글 수정</h2>
        <br>
        <br>
        
	<form action="f_bupdate" method="post" enctype="multipart/form-data">
	    <table>
	        <tr height="40"><td bgcolor="Khaki">Seq</td>
	            <td><input type="text" name="seq" value="${apple.seq}" size="20" readonly></td></tr> <!-- 서버에서 필요한 정보 -->
	        <tr height="40"><td bgcolor="Khaki">I D</td>
	            <td><input type="text" name="id" value="${apple.id}" size="20" readonly></td></tr>
	        <tr height="40"><td bgcolor="Khaki">Title</td>
	            <td><input type="text" name="title" value="${apple.title}"></td></tr> <!-- 서버에서 필요한 정보 -->
	        <tr height="40"><td bgcolor="Khaki">Content</td>
	                          <td><textarea rows="5" cols="50" name="content">${apple.content}</textarea></td>
	                                      <!-- 서버에서 필요한 정보 -->
	        </tr>
	        <tr height="40"><td bgcolor="Khaki">RegDate</td>
	            <td><input type="text" name="regdate" value="${apple.regdate}" readonly></td></tr>
	        <tr height="40"><td bgcolor="Khaki">조회수</td>
	            <td><input type="text" name="cnt" value="${apple.cnt}" readonly></td></tr>
	            <tr height="40"><td bgcolor="GreenYellow">Image</td>
	            <td><img src="${apple.uploadfile}" class="select_img" width="80" height="100"><br>
	                <input type="hidden" name="uploadfile" value="${apple.uploadfile}"><br>
	                <input type="file" name="uploadfilef" id="uploadfilef">
	               <script>
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
	        </td></tr>
	        <tr><td></td>
	            <td><input type="submit" value="글수정">&nbsp;&nbsp;
	                 <input type="reset" value="취소">
	            </td>
	        </tr>
	    </table>
	</form>
</div>
	
	<%-- <c:if test="${loginID==apple.id || loginID=='admin' }"> 
	</c:if>--%>
	<!-- 로그인 아이디랑 아이디랑 같으면 내가 쓴 글 -->
	&nbsp;&nbsp;<a href="bdelete?seq=${apple.seq}&root=${apple.root}">[글삭제]</a>
	&nbsp;&nbsp;<a href="f_bcrilist">목록</a><br>
	&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
	&nbsp;&nbsp;<a href="home">[Home]</a>

 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    
</body>
</html>
