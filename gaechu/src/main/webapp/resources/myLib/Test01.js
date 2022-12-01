/*
** 이클립스 자바스크립트 파일 내용이 흑백으로 나올때... 컬러로 고치기 
=> https://creampuffy.tistory.com/66
** js 문서관련 설정
윈도우 - 프레퍼런스 - 제네럴 - 에디터스 - 파일 어소시에이션 - 
add - *.js - 밑에 제네릭 텍스트 에디터 디폴트

********************************************
** Ajax_Test01 
 *  =>  MousePointer, axLogin, jsLoin,
   => form 의 input Data 처리
 */

$(function(){
		
	// => axlogin : ver01
    //    로그인 성공 or 실패는 모두 컨트롤러의 정상젓인 처리 결과이므로
	//	  success function 에서 처리함
    //    로그인 성공 or 실패에 따른 다른 처리가 필요함
	
	//	  ver02 : 결과값 Data 를 response로 전달받음
   	//    		  서버로 부터 결과값을 전달받을 필요성 
   	//    		  서버의 결과는 Java 의 Data -> JS 가 이를 이용해서 코딩
   	//    		  그러므로 Java의 Data를 JS가 인식가능한 Data형식(JSON 포맷)으로 변환 해야함

	$('#jslogin').click(function() {
		$.ajax({
			type: 'Post',
			url: 'login',
			data: {
				id: $('#id').val(),
				password: $('#password').val()
			},
			success: function(resultData) {
				// ** JSON 처리 예정
				// => 컨트롤러의 처리 결과를 전달받아 성공/실패 구분 가능
				if (resultData.code == "200") {
					location.reload();
				} else if (resultData.code == "201" ){
				alert("아이디 또는 비밀번호를 확인해주세요");
				location.reload();
				}else if (resultData.code == "202" ){
				alert("아이디 또는 비밀번호를 확인해주세요");
				location.reload();
				}
			}
		}); //ajax
		
	});	//click
	

	$('#axlogout').click(function() {
		$.ajax({
			type: 'Post',
			url: 'logout',
			success: function() {
				location.reload(); //새로고침
			}
		}); //ajax
	});	//axlogout

}); //ready





