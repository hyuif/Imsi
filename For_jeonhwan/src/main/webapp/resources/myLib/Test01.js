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
	// ** MousePointer
	// => ~~~.hover(f1, f2);
	$('.textlink').hover(function(){
		$(this).css({
			fontsize: '1.2em',
			fontWeight:'bold',
			color:'DeepSkyBlue',
			cursor:'pointer'
		}); //css
	}, function(){
		$(this).css({
			fontsize: '',
			fontWeight:'bold',
			color:'Blue',
			cursor:'default'
			}); //css
		}); //hover
		
		
	// ** axLogin
	// => axloginf	
	$('#axloginf').click(function(){
		$.ajax({
			type:'Get',
			url:'loginf',
			success:function(resultPage){
				$('#resultArea1').html(resultPage);
			},
			error:function(){
				$('#resultArea1').html('~~ AjaxLogin 요청 Erroe ~~');
			}
		}); //ajax
	}); //click
		
	// => axlogin : ver01
    //    로그인 성공 or 실패는 모두 컨트롤러의 정상젓인 처리 결과이므로
	//	  success function 에서 처리함
    //    로그인 성공 or 실패에 따른 다른 처리가 필요함
	//	  ver01 : webPage 를 response로 전달받음
	//	  		성공 : 현재 화면을 새로고침
	//	  		실패 : 현재 로그인 폼을 그냥 두면 됨
	//			그러므로 response Page가 필요하지 않음
	//	  		로그인 성공 / 실패 결과만 알면됨
	
	//	  ver02 : 결과값 Data 를 response로 전달받음
   	//    		  서버로 부터 결과값을 전달받을 필요성 
   	//    		  서버의 결과는 Java 의 Data -> JS 가 이를 이용해서 코딩
   	//    		  그러므로 Java의 Data를 JS가 인식가능한 Data형식(JSON 포맷)으로 변환 해야함

	// => axlogin : ver01
	// -> success function내 에서 로그인 성공여부를 알수없음
	$('#axlogin').click(function() {
		$.ajax({
			type: 'Post',
			url: 'login',
			data:{
				id: $('#id').val(),
				password: $('#password').val()
			},
			success: function() {
				// => resultPage 를 사용하면
           		//    실패시 로그인폼 출력은 가능 하지만,
             	//    성공시 home 화면을 resultArea1에 출력하게됨
	  
				
				// => resultArea 는 clear, 현재 Page는 새로 고침
				//	  그러나 실패시 로그인폼 출력이 어려움
				$('#resultArea1').html('');
				location.reload(); //새로고침
			},
			error: function() {
				$('#resultArea1').html('~~ AjaxLogin 요청 Erroe ~~');
			}
		}); //ajax
	});	//axlogin_click
	
	
	// **jslogin : ver02
	$('#jslogin').click(function() {
		$.ajax({
			type: 'Post',
			url: 'jslogin',
			data:{
				id: $('#id').val(),
				password: $('#password').val()
			},
			success: function(resultData) {
				// ** JSON 처리 예정
				// => 컨트롤러의 처리 결과를 전달받아 성공/실패 구분 가능
				if (resultData.code==200){
					$('#resultArea1').html('');
					location.reload(); 
				}else{
					$('#message').html(resultData.message);
					$('#id').focus();
				}
			},
			error:function(){
				$('#resultArea1').html('~~AjaxLogin 실패');
			}
			//error: erroeMessage('jsonView Test') 
		}); //ajax
	});	//click
	
	// ** AjaxJoin
	// => axJoinf	
	$('#axjoinf').click(function(){
		$.ajax({
			type:'Get',
			url:'joinf',
			success:function(resultPage){
				$('#resultArea1').html(resultPage);
			},
			error:function(){
				$('#resultArea1').html('~~ AjaxJoin 요청 Error ~~');
			}
		}); //ajax
	}); //click
	
	
	// => axjoin
	// ** Ajax에서 input Data (Value) 처리방법
	// 1) Form 의 serialize()
	// => input Tag 의 name 과 id 가 같아야 함.   
	// => 직렬화 : multipart 타입은 전송안됨. 
	//           처리하지 못하는 값(예-> file Type) 은 스스로 제외시킴 
	// => 제외컬럼 지정하기
	//    var formData = $('#myForm:not(#rid)').serialize();
	//    rid 만 제외시키는 경우 (보류:적용안됨)
	
	// 2) 객체화   
	// => 특정 변수 (객체형) 에 담기      
	// => 특별한 자료형(fileType: UpLoadFilef) 적용안됨.   
	
	// 3) FormData 객체 활용
	// => 모든 자료형의 특성에 맞게 적용가능하여 이미지등의 file 업로드가 가능한 폼데이터 처리 객체
	// => IE10부터 부분적으로 지원되며, 크롬이나 사파리, 파이어폭스같은 최신 브라우져에서는 문제 없이 동작
	// => 3.1) append 메서드 또는 3.2) 생성자 매개변수 이용
	
	// ** 관련속성   
	// => form Tag 
	//      enctype 속성: 'multipart/form-data'  
	//     method: 'Post''
	// => ajax 속성
	//      method: 'Post','
	//      enctype: 'multipart/form-data', // form Tag 에서 지정하므로 생략 가능
	//      processData:false, // false로 선언시 formData를 string으로 변환하지 않음
	//       contentType:false, // false로 선언시 content-type 헤더가 multipart/form-data로 전송되게 함
	
	
	$('#axjoin').click(function() {
		// ** 실습
		// 1) Form 의 serialize()
		//let formData = $('#myform').serialize();
		
		// 2) 객체화
		/*formData =  {
			id:$('#id').val(),
			password:$('#password').val(),
			name:$('#name').val(),
			info:$('#info').val(),
			birthday:$('#birthday').val(),
			jno:$('#jno').val(),
			age:$('#age').val(),
			point:$('#point').val()
			image 파일 적용이 안됨
		}*/
		
		// 3) FormData 객체 활용
		// 3.1) append 메서드
		/*let formData = new FormData();
		formData.append(id,$('#id').val());
		formData.append(password,$('#password').val());
		formData.append(name,$('#name').val());
		formData.append(info,$('#info').val());
		formData.append(birthday,$('#birthday').val());
		formData.append(jno,$('#jno').val());
		formData.append(age,$('#age').val());
		formData.append(point,$('#point').val());
		*/
		
		/* 
		=>  image 처리
	  		Ajax 의  FormData 는  이미지를 선택하지 않으면 append시 오류 발생
	  		하기 때문에 이를 확인 후 append 하도록 함
			이때 append 를 하지 않으면  서버의 vo.uploadfilef 에는 null 값이 전달됨.
		

		// [0] : 아래 코드처럼 JS의 노드로 인식 시켜줌
		// if ( document.getElementById('uploadfilef').files[0] != null)
		if ($('#uploadfilef')[0].files[0] != null) 
			formData.append('uploadfilef', $('#uploadfilef')[0].files[0]);
		*/
		
		// 3.2) append all
		// => 생성자 매개변수로 form (JS의 노드로 인식된 Form 이어야함 ) 사용 
		// => JS 적용
		//let formData = new FormData(document.getElementById('myForm')); //OK
		//let formData = new FormData($('#myForm')); //Error
		
		// => JQuery
		let formData = new FormData($('#myForm')[0]); // OK : JS의 노드로 인식
		
		$.ajax({
			type: 'Post',
			url: 'join',
			
			//=> FormData 객체로 fileUpload 시 enctype, processData, contentType 추가
     	    //   단, enctype: 'multipart/form-data' 는 생략가능 (form Tag 에 적용했으므로)
			processData:false,
			contentType:false,
			
			data:formData,
			success: function() {
				$('#resultArea1').html('');
			},
			error: function() {
				$('#resultArea1').html('~~ AjaxJoin 요청 Error ~~');
			}
		}); //ajax
	});	//axlogin_click
	
	
	
}); //ready


// ** Error 처리 function **
function erroeMessage(message) {
	$('#resultArea1').html('~~ AjaxLogin 요청 Error => '+message);
}




