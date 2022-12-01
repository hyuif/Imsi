package com.ncs.hhh;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criTest.PageMaker;
import criTest.SearchCriteria;
import service.CommentService;
import service.F_BoardService;
import vo.F_BoardVO;

@Controller
public class F_BoardController {
	
	@Autowired
	F_BoardService service;
	@Autowired
	CommentService service2;
		// ** Board Check List ***************************
		// => ver02) SearchCriteria,  PageMaker 적용하기 
		@RequestMapping(value="/f_bcrilist")
		public ModelAndView f_bcrilist(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
			
			// 1) Criteria 처리 
			cri.setSnoEno();
			// 2) 서비스처리
			mv.addObject("banana", service.searchList(cri));
			// 3) View 처리 => PageMaker
			pageMaker.setCri(cri);
			pageMaker.setTotalRowsCount(service.searchCount(cri));
			
	    	mv.addObject("pageMaker", pageMaker);
			
			mv.setViewName("freeBoard/f_Blist");
	    	return mv;
		} //f_bcrilist
		
	
	// ** Free_BoardDetail
		@RequestMapping(value="/f_bdetail")
		public ModelAndView f_bdetail(HttpServletRequest request, HttpServletResponse response,
				SearchCriteria cri, ModelAndView mv, F_BoardVO vo) {
			// 1. 요청분석
			String uri = "/freeBoard/f_BoardDetail";
			
			// 2. Service 처리
			vo = service.selectOne(vo);
			mv.addObject("banana", service.searchList(cri));
			if ( vo != null ) {
				// 2.1) 조회수 증가 
				String loginID = (String)request.getSession().getAttribute("loginID"); // object 타입을 string으로
				if (!vo.getId().equals(loginID) && !"U".equals(request.getParameter("jCode"))) { //vo아이디랑 login아이디랑 다르고 && U가 아닌경우
				    // => 조회수 증가 
				    if ( service.countUp(vo) > 0 ) vo.setCnt(vo.getCnt()+1); 
				} //if_증가조건
				 			
				// 2.2) 수정요청 인지 확인
				if ( "U".equals(request.getParameter("jCode")))
					uri = "/freeBoard/f_BupdateForm";
				
				// 2.3) 이전, 다음 상세보기 요청인지 아닌지
				if ( "P".equals(request.getParameter("jCode"))) {
					vo = service.p_selectOne(vo);
					if(vo==null) mv.addObject("Prev", "T");
				}
				
				if ( "N".equals(request.getParameter("jCode"))) {
					vo = service.n_selectOne(vo);
					if(vo==null) mv.addObject("Next", "F");
				}
				
				// 2.3)	결과전달		
				int total = service2.getTotal(vo.getSeq(),3);
				
				
				mv.addObject("total",total);
				mv.addObject("apple", vo);
			}else mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다. ~~");
			
			mv.setViewName(uri);
			return mv;
		} //f_bdetail
	
		// ** Insert : 새글등록
		@RequestMapping(value="/f_binsertf")
		public ModelAndView f_binsertf(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
			mv.setViewName("/freeBoard/f_BinsertForm");
			return mv;
		}
		@RequestMapping(value="/f_binsert", method=RequestMethod.POST)
		// => 매핑네임과 method 가 일치하는 요청만 처리함
		// => Get 요청시 : 405–허용되지 않는 메소드 (Request method 'GET' not supported)  
		public ModelAndView f_binsert(HttpServletRequest request, 
				HttpServletResponse response, ModelAndView mv, F_BoardVO vo, RedirectAttributes rttr) throws IOException {
		
			// 1. 요청분석
			// => insert 성공 : t_Blist (redirect 요청, message 전달)
			//    insert 실패 : t_BinsertForm.jsp  
			String uri = "redirect:f_bcrilist";
			
			// ** Image 물리적위치 에 저장
		    // 1) 현재 웹어플리케이션의 실행 위치 확인 : 
		    // => eslipse 개발환경 (배포전)
		    //    D:\MTest\MyWork\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\Spring01\
		    // => 톰캣서버에 배포 후 : 서버내에서의 위치가 됨
		    //    D:\MTest\IDESet\apache-tomcat-9.0.41\webapps\Spring01\
		    String realPath = request.getRealPath("/"); // deprecated Method
		    System.out.println("** realPath => "+realPath);
		      
		    // 2) 위 의 값을 이용해서 실제저장위치 확인 
		    // => 개발중인지, 배포했는지 에 따라 결정
		    if ( realPath.contains(".eclipse.") )  // eslipse 개발환경 (배포전)
		       realPath = "C:\\Users\\주성현\\git\\Holo\\src\\main\\webapp\\resources\\uploadImage";
		    else  // 톰캣서버에 배포 후 : 서버내에서의 위치
		       realPath += "resources\\uploadImage\\" ;
		      
		    // ** 폴더 만들기 (File 클래스활용)
		    // => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		    File f1 = new File(realPath);
		    if ( !f1.exists() ) f1.mkdir();
		    // => realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		    //    존재하지 않으면 디렉토리 생성
		      
		    // ** 기본 이미지 지정하기 
		    String file1, file2=null; 
		      
		    // ** MultipartFile
		    // => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		    //    -> String getOriginalFilename(), 
		    //    -> void transferTo(File destFile),
		    //    -> boolean isEmpty()
		      
		    MultipartFile uploadfilef = vo.getUploadfilef(); // file의 내용 및 파일명 등 전송된 정보들
		    if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {
		       // ** Image를 선택함 -> Image저장 ( 경로_realPath + 화일명 )
		       // 1) 물리적 저장경로에 Image저장
		       file1 = realPath + uploadfilef.getOriginalFilename(); // 경로완성
		       uploadfilef.transferTo(new File(file1)); // Image저장
		         
		       // 2) Table 저장 준비
		       file2="resources/uploadImage/"+uploadfilef.getOriginalFilename();
		    }
		    vo.setUploadfile(file2);
			
			// 2. Service 처리
			if ( service.insert(vo)>0 ) {
				rttr.addFlashAttribute("message", "~~ 새글 등록 성공 ~~");
			}else {
				mv.addObject("message", "~~ 새글 등록 실패, 다시 하세요 ~~");
				uri = "/freeBoard/f_BinsertForm";
			}
			// 3. 결과(ModelAndView) 전달 
			mv.setViewName(uri);
			return mv;
		} //f_Binsert
	
		// ** Update : 글수정하기
		@RequestMapping(value="/f_bupdate", method=RequestMethod.POST)
		public ModelAndView f_bupdate(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, F_BoardVO vo) throws IOException {
			// 1. 요청분석
			// => Update 성공: f_BoardDetail.jsp
			//           실패: 재수정 유도 -> f_BupdateForm.jsp
			String uri = "/freeBoard/f_BoardDetail";
			mv.addObject("apple",vo);
			// => Update 성공/실패 모두 출력시 필요하므로
			
			// ** Image Update 추가
			// 1) Image 물리적 저장 위치 확인
			String realPath = request.getRealPath("/"); // deprecated Method
			
			// 1.1) 위 의 값을 이용해서 실제저장위치 확인 
			// => 개발중인지, 배포했는지 에 따라 결정
			if ( realPath.contains(".eclipse.") )  // eslipse 개발환경 (배포전)
				realPath = "C:\\Users\\주성현\\git\\Holo\\src\\main\\webapp\\resources\\uploadImage\\";
			else  // 톰캣서버에 배포 후 : 서버내에서의 위치
				realPath += "resources\\uploadImage\\" ;
			
			// 1.2) 폴더 만들기 (File 클래스활용, )
			// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
			File f1 = new File(realPath);
			if ( !f1.exists() ) f1.mkdir();
			
			// 2) 기본 이미지 지정하기 
			String file1, file2=null; 
			
			// 3) MultipartFile : file은 저장, 저장된 경로는 vo 에 set
			// => 새 화일선택 했으면 : uploadfilef 처리
			// => 새 화일선택 안했으면 : uploadfilef 처리없이 uploadfile 사용
			MultipartFile uploadfilef = vo.getUploadfilef();  // file 의 내용및 화일명 등 전송된 정보들
			if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {
				// ** 새 Image 화일 을 선택함 -> Image저장 ( 경로_realPath + 화일명 )
				// 3.1) 물리적 저장경로에 Image 저장
				file1 = realPath + uploadfilef.getOriginalFilename(); // 경로완성
				uploadfilef.transferTo(new File(file1)); // Image저장
				
				// 3.2) Table 저장 준비
				file2="resources/uploadImage/"+uploadfilef.getOriginalFilename();
				vo.setUploadfile(file2);
			}
			// ** new_Image 를 선택하지 않은 경우
			// => form 에서 전송되어 vo 에 담겨진 uploadfile 값을 사용하면 됨. 
			
			// 2. Service 처리
			if ( service.update(vo) > 0 ) {
				mv.addObject("message", "~~ 글수정 성공 ~~"); 
			}else {
				mv.addObject("message", "~~ 글수정 실패, 다시 하세요 ~~");
				uri = "/freeBoard/f_BupdateForm";
			}
			
			// 3. 결과(ModelAndView) 전달 
			mv.setViewName(uri);
			return mv;
		}
		
		// ** Delete : 글 삭제
		@RequestMapping(value="/f_bdelete")
		public ModelAndView f_bdelete(HttpServletRequest request, HttpServletResponse response, 
										ModelAndView mv, F_BoardVO vo, RedirectAttributes rttr) {
			// 1. 요청분석
			// => Delete 성공: redirect:f_blist
			//           실패: message 표시, redirect:f_bdetail
			String uri = "redirect:f_bcrilist";
			
			// 2. Service 처리
			if ( service.delete(vo) > 0 ) {
				rttr.addFlashAttribute("message", "~~ 글삭제 성공 ~~"); 
			}else {
				rttr.addFlashAttribute("message", "~~ 글삭제 실패, 다시 하세요 ~~");
				uri = "redirect:f_bdetail?seq="+vo.getSeq();
			} // Service
			
			// 3. 결과(ModelAndView) 전달 
			mv.setViewName(uri);
			return mv;
		} //f_bdelete
		
		// ** Reply_Insert : 답글등록
		@RequestMapping(value="/f_rinsertf")
		public ModelAndView f_rinsertf(HttpServletRequest request, 
				HttpServletResponse response, ModelAndView mv, F_BoardVO vo) {
			// => vo 에는 전달된 부모글의 root, step, indent 가 담겨있음 
			// => 매핑메서드의 인자로 정의된 vo 는 request.setAttribute 와 동일 scope
			//    단, 클래스명의 첫글자를 소문자로 ...  ${boardVO.root}??
			mv.setViewName("/freeBoard/f_RinsertForm");
			return mv;
		}
		@RequestMapping(value="/f_rinsert", method=RequestMethod.POST)
		public ModelAndView f_rinsert(HttpServletRequest request, HttpServletResponse response,
										ModelAndView mv, F_BoardVO vo, RedirectAttributes rttr) {
			// 1. 요청분석
			// => 성공: f_blist
			//    실패: 재입력 유도 (f_RinsertForm.jsp)
			// => set vo
			//		- root: 부모와 동일
			//		- step: 부모 step + 1
			//		- indent: 부모 indent + 1
			//		- 그러므로 rinsertForm 에 부모값을 보관 (hidden으로) 해서 전달받음 
			//		  이를 위해 boardDetail 에서 요청시 퀴리스트링으로 전달 -> f_rinsertf 
			String uri = "redirect:f_bcrilist";
			vo.setStep(vo.getStep()+1);
			vo.setIndent(vo.getIndent()+1);
			
			// 2. Service 처리
			if ( service.rinsert(vo)>0 ) {
				rttr.addFlashAttribute("message", "~~ 답글 등록 성공 ~~");
			}else {
				mv.addObject("message", "~~ 답글 등록 실패, 다시 하세요 ~~");
				uri = "/freeBoard/f_RinsertForm";
			}
			
			// 3. 결과(ModelAndView) 전달 
			mv.setViewName(uri);
			return mv;
		} //f_rinsert	
		
} //class
