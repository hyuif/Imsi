<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판 새글 등록</title>
    <link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
    <script src="resources/myLib/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class="contents">
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <br>
        <div class="Header_box">
        <h2>▶ 자유 게시판 ◀</h2>
        <p class="Header_text1">&nbsp;이곳은 자유게시판 입니다. 아래의 주제 외에 자유롭게 글을 작성해주세요.</p>
        <p class="Header_text2">&nbsp;팁 관련 주제는 <a href="tipblist">팁/정보</a>게시판, 물건 판매 및 거래는 <a href="t_bcrilist">거래/나눔</a>게시판, 동아리 및 모임 주제는 <a href="cbcrilist">동아리/모임</a>게시판에 남겨주세요.</p>
        <br>
        </div>
        <br>
        
	<form action="f_binsert" method="post" enctype="multipart/form-data"  class="insert_container">
		<table class="insert_table">
			<tbody>
	    		<tr> <!-- 제목 -->
	    			<td bgcolor="#EDEDED">
	    				<table width="100%" border="0">
	    					<tbody>
	    						<tr height="30px" style="padding: 0 0 0 5px;">
	    							<td align="center" style="width:60px;">제목 :</td>
	    							<td style="padding:0 5px 0 0;" width="840px">
	    								<input type="text" name="title" value="" style="width:400px; border:1 #CCC solid; padding-top: 3px;" MAXLENGTH=150 placeholder="제목을 입력해주세요.">
	    							</td>
	    						</tr>
	    					</tbody>
	    				</table>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr height="1">
								<td bgcolor='#CCC'></td>
							</tr>
						</table>
	    			</td>
	    		</tr>

	    		<tr> <!-- ID -->
	    			<td bgcolor="#f6f5f5">
	    				<table border="0" width="100%">
	    					<tbody>
	    						<tr height="30px">
	    							<td width="*" align="right" style="padding:0 15px 0 5px;">
										<input class="test1000" name="id" value="${loginID}" readonly >	
									</td>
								</tr>
	    					</tbody>
	    				</table>
	    				<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr height="1">
								<td bgcolor='#CCC'></td>
							</tr>
						</table>
	    			</td>
	    		</tr>

	    		<tr> <!-- 내용 -->
	    			<td>
	    				<div style="width:100%; margin:10px;">
							<table width="100%">
								<tbody>
									<tr>
										<td align="center"><textarea id="content" name="content" style='width:95%;height:400px;background:#FBFBFB;line-height:150%;overflow-y:scroll;resize:none;'></textarea></td>
									</tr>
								</tbody>
							</table>
						</div>
	    			</td>
	    		</tr>

	    		<tr> <!-- 업로드 -->
	    			<td bgcolor="#EDEDED">
	    				<table width="100%" border="0">
	    					<tbody>
	    						<tr height="30px">
	    							<td style="padding:5px 0 5px 10px;" width="180px"><img src="" class="select_img"><br>
	    								<input type="file" name="uploadfilef" id="uploadfilef" value="" style="padding-top: 3px;">
	    									<script>
										    // 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
										    // 이를 해결하기 위해 FileReader이라는 Web API를 사용
										    // => 이 를 통해 url data를 얻을 수 있음.
										    //    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
										    // ** FileReader
										    // => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 읽을 파일을 가리키는File
										    //    혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
										    //    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.   
										    // => FileReader.onload 이벤트의 핸들러.
										    //    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
										    // => e.target : 이벤트를 유발시킨 DOM 객체
										    // => type="file" 은 복수개의 파일을 업로드 할 수 있도록 설계됨
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
	    							</td>
	    							<td style="padding:10px 0 10px 0">
	    							    <span>
	    							        ＊ 업로드 할 이미지를 파일선택 클릭 후 첨부해주세요.<br>
	    							        ＊ 통신 환경에 따라 고용량 이미지의 업로드가 실패할 수 있습니다.<br>
	    							        <br>
	    							        ※ 정보통신망에서 불법촬영물등을 유통할 경우 「전기통신사업법」 제22조의 5 제1항에<br>
	    							        &nbsp;&nbsp;&nbsp;따른 삭제.접속차단 등 유통방지에 필요한 조치가 취해지며 「성폭력처벌법」 제14조<br>
	    							        &nbsp;&nbsp;&nbsp;「청소년성보호법」 제11조에 따라 형사처벌을 받을수 있습니다.<br>
	    							    </span>
	    							</td>
	    						</tr>
	    					</tbody>
	    				</table>
	    				<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr height="1">
								<td bgcolor='#CCC'></td>
							</tr>
						</table>
	    			</td>
	    		</tr>

	    		<tr> <!-- 버튼 -->
	    			<td bgcolor="#f6f5f5">
	    				<table border="0" width="100%">
	    					<tbody>
	    						<tr height="30px">
	    							<td width="*" align="left" style="padding:10px 0 15px 5px;">
										<input type="submit" value="등록">&nbsp;&nbsp;
	                					<input type="reset" value="취소">								
									</td>
								</tr>
	    					</tbody>
	    				</table>
	    			</td>
	    		</tr>
	    	</tbody>
	    </table>
	</form>
	</div>

	 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    
</body>
</html>
