<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래 게시판 글 수정</title>
    <link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
    <script src="resources/myLib/jquery-3.2.1.min.js"></script>
</head>
<body>
    <div class="contents">
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
	    <br>
	    <div class="Header_box">
	    <h2>▶ 거래 게시판 ◀</h2>
	    <p class="Header_text1">&nbsp;이곳은 거래/나눔 게시판 입니다. 물건 거래, 나눔 글을 작성해주세요.</p>
	    <p class="Header_text2">&nbsp;팁 관련 주제는 <a href="tipblist">팁/정보</a>게시판, 자유주제는 <a href="f_bcrilist">자유</a>게시판, 동아리 및 모임 주제는 <a href="cbcrilist">동아리/모임</a>게시판에 남겨주세요.</p>
	    <br>
	    </div>
	    <br>
	    
	<form action="t_bupdate" method="post" enctype="multipart/form-data" class="insert_container">
		<table class="insert_table">
	    	<tbody>
	    		<tr> <!-- 제목 -->
	    			<td bgcolor="#EDEDED">
	    				<table width="100%" border="0">
	    					<tbody>
	    						<tr><td><input type="text" name="seq" class="seqHidden" value="${apple.seq}"></td></tr>
	    						<tr height="30px" style="padding: 0 0 0 5px;">
	    							<td align="center" style="width:60px;">제목 :</td>
	    							<td style="padding:0 5px 0 0;" width="400px">
	    								<input type="text" name="title" value="${apple.title}" style="width:400px; border:1 #CCC solid; padding-top: 3px;" MAXLENGTH=150>
	    							</td>
	    							<td align="left" style="padding:0 15px 0 5px;">
	    								<select name="trade" id="trade" class="test101">
	        								<c:choose>
							        	 	<c:when test="${apple.trade=='sell'}">
							                    <option value="sell" selected>판매</option>
							                    <option value="buy">구매</option>
							                </c:when>
							                
							             	<c:otherwise>
							                    <option value="sell">판매</option>
							                    <option value="buy" selected>구매</option>
							             	</c:otherwise>
							        	 	</c:choose>
	           							</select>
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
										<td align="center"><textarea id="content" name="content" style='width:95%;height:400px;background:#FBFBFB;line-height:150%;overflow-y:scroll;resize:none;'>${apple.content}</textarea></td>
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
	    							<td style="padding:5px 0 5px 10px;" width="180px"><img src="${apple.uploadfile}" class="select_img" width="80" height="100"><br>
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

	<%-- <c:if test="${loginID==apple.id || loginID=='admin' }"> 
	</c:if>--%>
	<!-- 로그인 아이디랑 아이디랑 같으면 내가 쓴 글 -->
	&nbsp;&nbsp;<a href="bdelete?seq=${apple.seq}&root=${apple.root}">[글삭제]</a>
	&nbsp;&nbsp;<a href="t_bcrilist">목록</a><br>
	&nbsp;&nbsp;<a href="javascript:history.go(-1)">이전으로</a>
	&nbsp;&nbsp;<a href="home">[Home]</a>

	 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    
</body>
</html>
