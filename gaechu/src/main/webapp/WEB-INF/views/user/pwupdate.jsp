<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** User PwUpdate **</title>
    <script src="resources/myLib/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="resources/myLib/userUpdate.css">
	<script src="resources/myLib/inCheck.js"></script>

<script>
   let pCheck=false;
   let ppCheck=false;
   
   $(function(){
	// ** Password
		$('#password').keydown(function(e){
			if ( e.which==13 ) {
				e.preventDefault();
				$('#password2').focus();
			}
		}).focusout(function(){    
			pCheck=	pwCheck();
		}); //password
		
		$('#password2').keydown(function(e){
			if ( e.which==13 ) {
				e.preventDefault();
				$('#submit').focus();
			}
		}).focusout(function(){    
			ppCheck=pw2Check();
		}); //password2
   }); //ready
   
   function inCheck() {
	   	if (pCheck==false) { $('#pMessage').html(' Password 를 확인하세요 !!');}
		if (ppCheck==false) { $('#ppMessage').html(' Password2 를 확인하세요 !!');}
         
         if ( pCheck && ppCheck ) return true; // submit 진행  
         else return false;z
   } //inCheck
   
   function change() {
	   if (confirm("비밀 번호를 변경하시겠습니까??")) {
	    }else{
	    	
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
	
	
<h2> 비밀번호 변경 </h2>

<form action="pwupdate" method="post" enctype="multipart/form-data">
	<table>
		
		<tr height="40"><td>Password</td>
		<td><input type="password" name="password" id="password"  size="20"
								placeholder="특수문자 반드시 포함"><br>
 			<span id="pMessage" class="eMessage" ></span>
		</td></tr>
		
		<tr height=40>
			<td><label for=password>PW  확인</label></td>
			<td><input type="password"  id=password2 size="20"><br>
	 			<span id="ppMessage" class="eMessage" ></span></td>
		</tr>	
								
		<tr>
			<td class="no"><input  type="submit" value="수정" onclick="return change()" >&nbsp;&nbsp;
				<input type="reset" value="취소">
			</td>	
		</tr>	
	</table>
</form>

</body>
</html>