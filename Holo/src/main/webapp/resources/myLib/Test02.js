// *** PasswordEncoder (암호화 적용하기)
// => update에 적용하기전에
//      - login : loginPW session에 보관
//      - detail : updateForm 에 raw_password 가 출력되도록 수정함.
// => BCryptPasswordEncoder 적용
//    encode(rawData) -> digest 생성 & vo 에 set  





  

// => Delete
function amDelete(id) {
	
	$.ajax({
		type:'Get',
		url:'axmdelete',
		data: { id:id },
		success:function(resultData){
			// Delete 결과 처리
			
		if ( resultData.code=='200' ) {
			alert('삭제가 성공적으로 처리되었습니다. ~~ ');
			// span 의 컨텐츠를 Deleted, click_event 를 off
			/* 
			$(this).html('Deleted'); 
			ajax 처리 단계이므로 이미 this는 변경되어 click 시의 this 가 아님 
			=> 그러므로 id 활용 */ 
			$('#'+id).html('Deleted')   //  $('#admin')
			.css({
				color:'Gray',
				fontgWeight:'bold'
			}).off().attr('onclick', null);
			// JQuery 의 이벤트제거 이므로 여기서 off()는 적용안됨
			// => 그러므로 이 경우에는 onclick 속성의 값을 삭제 해야함. 
		}else if ( resultData.code=='201' )	 {
			$('#resultArea2').html('');
			alert('~~ Delete Sql 오류 !! 잠시후 다시 하세요 ~~');
		}else {
			$('#resultArea2').html('');
			alert('~~ 관리자 로그인 정보 없음!!  다시 하세요 ~~');
		} //else
			
		}, // seccess
		error:function(){
			alert('~~ 서버오류 !! 잠시후 다시 하세요 ~~');
		}
	}); //ajax
} //amDelete 
 


