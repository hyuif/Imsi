<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>	
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="resources/myLib/userUpdate.css">

<title> User Update</title>
<script>
function change() {
	var result = confirm("~ 하시겠습니까?");
	
	if(result == true) {
		alert("확인을 눌렀습니다.");
	} 
	else {
		alert("취소를 눌렀습니다.");
	}
	   
} //change
</script>
</head>
<body>
	<div class="header">
		<div>
			<a href="home" class="logo">logo</a>
		</div>

	</div>


<h2>내 정보 수정 </h2>

<form action="userupdate" method="post" enctype="multipart/form-data">
	<table>
		<!-- name 은 문서밖에서 감색하려고 쓰고 id는 문서내에서 검색하려고 쓴다 id name 이름이 같아야함 -->
		<tr height="40"><td>I D</td>
			<td><input type="text" name="id" id="id" size="20" value="${apple.id}" readonly ></td></tr>
		<tr height="40"><td>Password</td>
		<td>								
		<a href="userdetail?jCode=Y&id=${apple.id}">비밀번호수정</a>			
			<%-- <td><input type="password" name="password" id="password" size="20" value="${apple.password}">
			 --%></td></tr>
		<tr height="40"><td>Name</td>
			<td><input type="text" name="name" id="name" value="${apple.name}">   </td></tr>

		<tr height="40"><td>Birthday</td>
			<td><input type="date" name="birthday" id="birthday" value="${apple.birthday}"></td></tr>
			
		<tr height="40"><td>Gender</td>
			<td><select name="gender" id="gender" >
				<c:choose>
				<c:when test="${apple.gender=='여성'}">
					<option value="여성" selected>여성</option>
					<option value="남성">남성</option>
				</c:when>
				<c:otherwise>
					<option value="여성">여성</option>
					<option value="남성" selected>남성</option>
				</c:otherwise>
				</c:choose>
				</select>
			</td></tr>
		<tr height="40"><td>핸드폰번호</td>
			<td><input type="text" name="phonenum" id="phonenum" value="${apple.phonenum}"></td></tr>
		<!-- Image Update 추가 
			=> tr Tag 추가, form Tag 속성 확인 (method, enctype) 확인 -->	
		<tr height="40"><td>Image</td>
			<td><img src="${apple.uploadfile}" class="select_img" width="80" height="100" >
				<!-- ${apple.uploadfile} 의 정보를 기억하기위해 숨겨둠 -->
				<input type="hidden"  name="uploadfile" value="${apple.uploadfile}"><br>
				<input type="file" name="uploadfilef" id="uploadfilef">
				<script>
				$('#uploadfilef').change(function() {
							if (this.files && this.files[0]) {
								var reader = new FileReader;
								reader.readAsDataURL(this.files[0]);
								reader.onload = function(e) {
									$(".select_img").attr("src",e.target.result)
													.width(100).height(100);
								} // onload_function
							} // if   
						}); //change
				</script>
			</td></tr>			
			
			
		<tr height="40">
			<td class="no"><input type="submit" value="수정" onclick="return change()" >&nbsp;&nbsp;
				<input type="reset" value="취소">
			</td>	
		</tr>	
	</table>
</form>
</body>
</html>