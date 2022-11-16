<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>	
<meta charset="UTF-8">
<title>** User Update**</title>
<script>

</script>
</head>
<body>
<h2>** 내 정보 수정 **</h2>

<form action="userupdate" method="post" enctype="multipart/form-data">
	<table>
		<!-- name 은 문서밖에서 감색하려고 쓰고 id는 문서내에서 검색하려고 쓴다 id name 이름이 같아야함 -->
		<tr height="40"><td bgcolor="GreenYellow ">I D</td>
			<td><input type="text" name="id" id="id" size="20" value="${apple.id}" readonly ></td></tr>
											<!-- ** input Tag 입력 막기 
													=> disabled :  서버로 전송 안됨 
													=> readonly :  서버로 전송 됨   -->
		<tr height="40"><td bgcolor="GreenYellow ">Password</td>
		<td>								
		<a href="userdetail?jCode=Y&id=${apple.id}" >[비밀번호수정]</a>			
			<%-- <td><input type="password" name="password" id="password" size="20" value="${apple.password}">
			 --%></td></tr>
		<tr height="40"><td bgcolor="GreenYellow ">Name</td>
			<td><input type="text" name="name" id="name" value="${apple.name}">   </td></tr>

		<tr height="40"><td bgcolor="GreenYellow ">Birthday</td>
			<td><input type="date" name="birthday" id="birthday" value="${apple.birthday}"></td></tr>
			
		<tr height="40"><td bgcolor="GreenYellow ">Gender</td>
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
		<tr height="40"><td bgcolor="GreenYellow ">핸드폰번호</td>
			<td><input type="text" name="phonenum" id="phonenum" value="${apple.phonenum}"></td></tr>
		<!-- Image Update 추가 
			=> tr Tag 추가, form Tag 속성 확인 (method, enctype) 확인 -->	
		<tr height="40"><td bgcolor="GreenYellow ">Image</td>
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
			
			
		<tr height="40"><td></td>
			<td><input type="submit" value="수정">&nbsp;&nbsp;
				<input type="reset" value="취소">
			</td>	
		</tr>	
	</table>
</form>
<c:if test="${not empty message}">
<hr>
${message}<br>
</c:if>
<hr>
&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
&nbsp;&nbsp;<a href="home">[Home]</a>
</body>
</html>