<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    // 엔터 입력시 줄바꿈
    pageContext.setAttribute("replaceChar","\n");
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>** 동아리/모임게시판 디테일 **</title>
	<link rel="stylesheet" type="text/css" href="resources/myLib/board.css">
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<script>
	var offset = 0;
	const limit = 20;
	const com_bno = ${apple.seq};
	const com_type = 4;
	console.log("total => "+${total});
	

$(document).on("click", "#Comment_regist", function() {
   	
		const com_writer = $('#writer').val();
		const com_content = $('#com_content').val();
		
		console.log("com_bno =>"+com_bno)
		
		console.log("댓글쓴이 =>"+com_writer);
		console.log("콘텐츠 =>"+com_content);
	
		 if(com_writer === ''){
			alert('로그인 후 이용해주세요');
			return;
		}else if(com_content == '') {
			alert('내용을 입력하세요');
		} else{
		
		$.ajax({
			type:'post',
			url:'<c:url value="/Comment/InsertComment"/>',
			data: JSON.stringify(
				{
					"com_bno":com_bno,
					"com_writer":com_writer,
					"com_content":com_content,
					"com_type":com_type,
					"offset":offset,
		      "limit":limit
				}		
			),
			contentType: 'application/json',
			success:function(data){
				console.log('통신성공' + data);
				if(data === 'InsertSuccess') {
					alert('댓글 등록이 완료되었습니다.');
					console.log('댓글 등록 완료');
					$('#com_writer').val(com_writer);
   					$('#com_content').val('');
   					getList();
				} else {
					alert('로그인 이후 이용해주시기 바랍니다.');
					console.log('댓글 등록 실패');
				}
			},
			error:function(){
				alert('통신실패');
			}
		})
		 location.href = location.href;
		};// 댓글 비동기 끝
		
});// 댓글등록 이벤트 끝
// 임시

getList(0);


function getList(n) {
		offset = n;
	
	   const com_writer = $('#writer').value;
	   const com_content = $('#com_content').val();
	   $.getJSON(
			   "<c:url value='/Comment/CommentList/'/>"+com_bno+"?com_type="+com_type+"&offset="+offset+"&limit="+limit,
	      function(data) {
	         if(data.total > 0){
	            var list = data.list;
	            
	            var comment_html = "<div>";
	            
	            $('#count').html(data.total);
	            for(i = 0;i < list.length;i++){
	               var content = list[i].com_content;
	               var writer = list[i].com_writer;
	               var com_no = list[i].com_no;
	               comment_html += "<div><span id='com_writer'><strong>" + writer + "</strong></span><br/>";
	               comment_html += "<span id='com-content'>" + content + "</span><br>";
	               if(writer === $("#writer").val()){
	                   comment_html += "<span id='delete' style='cursor:pointer;' data-id ="+com_no+">[삭제]</span><br></div><hr>";
	                   
	               }
	               else{
	                  comment_html += "</div><hr>";
	               }
	            }
	            
	            $(".comment_Box").html(comment_html);
	            
	            
	         }
	         else{
	            var comment_html = "<div>등록된 댓글이 없습니다.</div>";
	            $(".comment_Box").html(comment_html);
	         }
	      
	      }
	      );//getJson
	}
	
$(document).on("click", "#delete", function(){
	const writer = $('#writer').val();
	const com_no = $(this).data("id");
	alert('댓글을 삭제하시겠습니까?');
	console.log('댓글삭제');
           $.ajax({
               type:'post',
               url:'<c:url value="/Comment/commentDelete"/>',
               data:JSON.stringify(
                  {
                     "com_writer":writer,
                     "com_type":com_type,
                     "com_no":com_no
                  }      
               ),
               contentType: 'application/json',
               success:function(data){
                  console.log('통신성공'+data);
                  alert('댓글이 삭제되었습니다');
                  location.href = location.href;
               },
               error:function(){
                  alert('통신실패');
               }
            }); //댓글 삭제 비동기
     
});
	
	
	</script>
	
	
</head>
<body>
    <div class="contents">
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
        <br>
        <div class="Header_box">
        <h2>▶ 동아리/모임 게시판 ◀</h2>
        <p class="Header_text1">&nbsp;이곳은 동아리/모임 게시판 입니다. 동아리, 모임 글을  작성해주세요.</p>
        <p class="Header_text2">&nbsp;팁 관련 주제는 <a href="tipblist">팁/정보</a>게시판, 자유주제는 <a href="f_bcrilist">자유</a>게시판,  물건 판매 및 거래는 <a href="t_bcrilist">거래/나눔</a>게시판에 남겨주세요.</p>
        <br>
        </div>
        <br>
        
        
	<table class="board_dTop">
		<tr class="board_dTitle"><td><br>${apple.title}</td></tr>
		<tr class="board_dList">
        	<td>글번호 : ${apple.seq}&nbsp;&nbsp;</td>
 	        <td>| 작성자 : <img height="15" width="15" src="${apple.image}">${apple.id}&nbsp;&nbsp;</td>
            <td>| 조회수 : ${apple.cnt}&nbsp;&nbsp;</td>
            <td>| ${apple.regdate}</td>
	    </tr>
		<tr class="board_dBottom">
            <c:if test="${empty apple.uploadfile}">
            	<td>${fn:replace(apple.content, replaceChar, "<br/>")}</td>
            </c:if>
            <c:if test="${not empty apple.uploadfile}">
            	<td><img width="100%" src="${apple.uploadfile}"><br><br>${fn:replace(apple.content, replaceChar, "<br/>")}<br><br></td>
            </c:if>
        </tr>
	</table>

     <div class="comment-count">댓글 <span id="count">0</span> 개</div>
<div class="comment_Box" style="border:1px solid gray;"> <!-- 댓글이 들어갈 박스 --></div>


<div id="page"></div>
<script>
let page = document.getElementById("page");
console.log(page);
console.log("반내림 => "+Math.floor(${total}/10));


	   for(let i=0; i<Math.ceil(${total}/20); i++){
       page.innerHTML = page.innerHTML+'<input  type="button" class="pagebt" style="border:none; font-size:20px; cursor: pointer;" value="'+(i+1)+'" onclick="getList('+i*20+')"/>';
       console.log("offset => "+offset);
	   }
</script>
  <div class="comment-box">
                    

         	   <!-- <span class="c-icon"><i class="fa-solid fa-user"></i>  -->
         <div class="comment-name">
            <span class="anonym">작성자 : 
        	    <input type="text" class="form-control" id="writer" placeholder="이름" name ="writer" value='${loginID}' readonly  style="width: 100px; border:none;">
            </span>
          </div>   
            	
            <!-- </span> -->
        <!--<img src="/익명.jpg" width ="50px" alt="My Image"><!-->
       <div class="comment-sbox">
           <textarea class="comment-input" id="com_content" cols="80" rows="2" name="com_content" ></textarea>
           <!-- <span class="com-function-btn" type="hidden">
               
               <a href="#"><i class="fa-solid fa-pen-to-square"></i></a>
               <a href="#"><i class="fa-solid fa-trash-can"></i></a>
            </span> -->
       </div>
       	<div class="regBtn">
       		<button id="Comment_regist"> 댓글등록</button>
         </div>
  </div>
		<br>
		<hr>
		<div>
			<!-- 아이디 로그인이랑 다를때 메뉴 -->
	        <c:if test="${loginID!=apple.id || loginID!='admin'}">
			<a href="cbinsertf">새글등록</a>
	        &nbsp;&nbsp;<a href="crinsertf?root=${apple.root}&step=${apple.step}&indent=${apple.indent}">답글등록</a>
			&nbsp;&nbsp;<a href="cbcrilist">목록으로</a>       
	        </c:if>
	        <!-- 아이디 로그인이랑 같을때 추가 메뉴 -->
	        <c:if test="${loginID==apple.id || loginID=='admin' }">
	        &nbsp;&nbsp;<a href="cbdetail?jCode=U&seq=${apple.seq}">글수정</a>
	        &nbsp;&nbsp;<a href="cbdelete?seq=${apple.seq}&root=${apple.root}">글삭제</a>
	        </c:if>
	        <br>
	        
	        <br>
	        <c:if test="${Prev!='T'}">
	        <a href="cbdetail?jCode=P&seq=${apple.seq}">이전글</a>
	        </c:if>
	        <c:if test="${Prev=='T'}">
	        이전글
	        </c:if>
	        
	        &nbsp;&nbsp;<a href="cbdetail?jCode=N&seq=${apple.seq}">다음글</a>
        </div>
		<hr>
		<table id="board_container">
            <thead class="boardList_head">
                <tr>
                    <th class="headS">번호</th>
                    <th class="headT">제 목</th>
                    <th class="headI">글쓴이</th>
                    <th class="headR">날 짜</th>
                    <th class="headC">조회수</th>
                </tr>
            </thead>
            <tbody class="boardList_body">
                <c:if test="${not empty banana}">
                    <c:forEach var="board" items="${banana}">
                        <tr>
                            <td class="bodyS">${board.seq}</td>
                            <td class="bodyT" id="title_hidden">[${board.place}]<a href="cbdetail?seq=${board.seq}">${board.title}</a></td>
                            <td class="bodyI" ><img height="25" width="25" src="${board.image}"><a href="userdetail?id=${board.id}">${board.id}</a></td>
                            <td class="bodyR">${board.regdate}</td>
                            <td class="bodyC">${board.cnt}</td>
                        </tr>
                    </c:forEach>
                </c:if>
            </tbody>
        </table>
</div> <!-- contents /div -->

 <%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>