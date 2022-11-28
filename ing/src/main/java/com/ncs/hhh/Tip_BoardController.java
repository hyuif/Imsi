package com.ncs.hhh;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import service.Tip_BoardService;
import vo.Tip_BoardVO;

@Controller
public class Tip_BoardController {
	
	private static final char[] CLASS_NAME = null;
	@Autowired
	Tip_BoardService service;
	@Autowired
	CommentService service2;
	
	// 팁수정 커밋체크
	@RequestMapping(value="/tiprinsertf")
	public ModelAndView rinsertf(HttpServletRequest request, 
			HttpServletResponse response, ModelAndView mv, Tip_BoardVO vo) {
		// => vo 에는 전달된 부모글의 root, step, indent 가 담겨있음 
		// => 매핑메서드의 인자로 정의된 vo 는 request.setAttribute 와 동일 scope
		//    단, 클래스명의 첫글자를 소문자로 ...  ${Tip_BoardVO.root}
		mv.setViewName("/tipBoard/tipBoarddetail");
		return mv;
	}
	@RequestMapping(value="/tiprinsert", method=RequestMethod.POST)
	public ModelAndView rinsert(HttpServletRequest request, HttpServletResponse response,
									ModelAndView mv, Tip_BoardVO vo, RedirectAttributes rttr) {
		// 1. 요청분석
		// => 성공: blist
		//    실패: 재입력 유도 (rinsertForm.jsp)
		// => set vo
		//		- root: 부모와 동일
		//		- step: 부모 step + 1
		//		- indent: 부모 indent + 1
		//		- 그러므로 rinsertForm 에 부모값을 보관 (hidden으로) 해서 전달받음 
		//		  이를 위해 boardDetail 에서 요청시 퀴리스트링으로 전달 -> rinsertf 
		String uri = "redirect:tipblist";
		vo.setStep(vo.getStep()+1);
		vo.setIndent(vo.getIndent()+1);
		
		// 2. Service 처리
		if ( service.rinsert(vo)>0 ) {
			rttr.addFlashAttribute("message", "~~ 답글 등록 성공 ~~");
		}else {
			mv.addObject("message", "~~ 답글 등록 실패, 다시 하세요 ~~");
			uri = "/tipBoard/tipRinsertForm";
		}
		
		// 3. 결과(ModelAndView) 전달 
		mv.setViewName(uri);
		return mv;
	} //rinsert	
	
	@RequestMapping(value="/tipblist")
	public ModelAndView bcrilist(HttpServletRequest request, HttpServletResponse response, 
						ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();
		
		mv.addObject("banana", service.searchList(cri)); // ver02
		    	
		pageMaker.setCri(cri);
		pageMaker.setTotalRowsCount(service.searchCount(cri));     // ver02: 조건과 일치하는 Rows 갯수 
    	mv.addObject("pageMaker", pageMaker);
    	
    	//System.out.println("*******"+pageMaker);
    	
    	mv.setViewName("/tipBoard/tipBlist");
    	return mv;
	} //bcrilist
	
	
	// ** BoardDetail
		// => 글내용 확인 , 수정화면 요청시 (jCode=U&seq=...)
		// => 조회수 증가
		// 	- 증가조건 : 글보는이(loginID)와 글쓴이가 다를때 && jCode!=U
		//	- 증가메서드: DAO, Service 에 countUp 메서드 추가
		//	- 증가시점 : selectOne 성공후
		@RequestMapping(value="/tipbdetail")
		public ModelAndView bdetail(HttpServletRequest request, HttpServletResponse response,
				ModelAndView mv, Tip_BoardVO vo) {
			// 1. 요청분석
			String uri = "/tipBoard/tipBoardDetail";
			
			// 2. Service 처리
			vo = service.selectOne(vo);
			if ( vo != null ) {
				// 2.1) 조회수 증가
				String loginID = (String)request.getSession().getAttribute("loginID");
				if ( !vo.getId().equals(loginID) && !"U".equals(request.getParameter("jCode")) ) {
					// => 조회수 증가
					if ( service.countUp(vo) > 0 ) vo.setCnt(vo.getCnt()+1); 
				} //if_증가조건
				
				// 2.2) 수정요청 인지 확인
				if ( "U".equals(request.getParameter("jCode")))
					uri = "/tipBoard/tipBupdateForm";
				
				// 2.3)	결과전달		
				
				System.out.println(vo);
				
				
				mv.addObject("apple", vo);
				int total = service2.getTotal(vo.getSeq());
				mv.addObject("total",total);
				
				mv.addObject(uri);
				
				
			}else mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다. ~~");
			
			
			mv.setViewName(uri);
			return mv;
		} //bdetail
	
	// ** Insert : 새글등록
	@RequestMapping(value="/tipbinsertf")
	public ModelAndView binsertf(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		mv.setViewName("/tipBoard/tipBinsertForm");
		return mv;
	}
	
	@RequestMapping(value="/tipbinsert", method=RequestMethod.POST)
	// => 매핑네임과 method 가 일치하는 요청만 처리함
	// => Get 요청시 : 405–허용되지 않는 메소드 (Request method 'GET' not supported)  
	public ModelAndView binsert(HttpServletRequest request, 
			HttpServletResponse response, ModelAndView mv, Tip_BoardVO vo, RedirectAttributes rttr,
			HttpSession session) throws IOException {
		String path = session.getServletContext().getRealPath("/");
		System.out.println(path);

		
		System.out.println("1");
		// 1. 요청분석
		// => insert 성공 : blist (redirect 요청, message 전달)
		//    insert 실패 : binsertForm.jsp  
		String uri = "redirect:tipblist";
		System.out.println("2");
		System.out.println("before vo=>"+vo);
		// 2. Service 처리

		//=======================================
		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath => "+realPath);
		
		// 2) 위 의 값을 이용해서 실제저장위치 확인 
		// => 개발중인지, 배포했는지 에 따라 결정
		if ( realPath.contains(".eclipse.") )  // eslipse 개발환경 (배포전)
			realPath = "C:\\Users\\Administrator.User -2022OFLBY\\git\\holo\\Holo\\src\\main\\webapp\\resources\\uploadImage";
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
		
		MultipartFile uploadfilef = vo.getUploadfilef();  // file 의 내용및 화일명 등 전송된 정보들
		System.out.println("uploadfilef=>"+uploadfilef);
		if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {
			
			// ** Image를 선택함 -> Image저장 ( 경로_realPath + 화일명 )
			// 1) 물리적 저장경로에 Image 저장
			file1 = realPath + uploadfilef.getOriginalFilename(); // 경로완성
			uploadfilef.transferTo(new File(file1)); // Image저장
			
			// 2) Table 저장 준비
			file2="resources\\uploadImage\\"+uploadfilef.getOriginalFilename();
		}
		// ** 완성된 경로 vo 에 set
		System.out.println("file2=>"+file2);
		
		vo.setUploadfile(file2);
		//vo.setUploadfile(path+file2);
		
		
		if ( service.insert(vo)>0 ) {
			rttr.addFlashAttribute("message", "~~ 새글 등록 성공 ~~");
		}else {
			mv.addObject("message", "~~ 새글 등록 실패, 다시 하세요 ~~");
			uri = "/tipBoard/tipBinsertForm";
		}
		System.out.println("vo=>"+vo);
		//==========================================
		
		
		// 3. 결과(ModelAndView) 전달 
		mv.setViewName(uri);
		return mv;
	} //binsert
	
	// ** Update : 글수정하기
	@RequestMapping(value="/tipbupdate")
	public ModelAndView bupdate(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, Tip_BoardVO vo) {
		// 1. 요청분석
		// => Update 성공: boardDetail.jsp
		//           실패: 재수정 유도 -> bupdateForm.jsp
		String uri = "/tipBoard/tipBoardDetail";
		mv.addObject("apple",vo);
		// => Update 성공/실패 모두 출력시 필요하므로
		
		// 2. Service 처리
		if ( service.update(vo) > 0 ) {
			mv.addObject("message", "~~ 글수정 성공 ~~"); 
		}else {
			mv.addObject("message", "~~ 글수정 실패, 다시 하세요 ~~");
			uri = "/tipBoard/tipBupdateForm";
		}
		
		// 3. 결과(ModelAndView) 전달 
		mv.setViewName(uri);
		return mv;
	}
	
	// ** Delete : 글 삭제
	@RequestMapping(value="/tipbdelete")
	public ModelAndView bdelete(HttpServletRequest request, HttpServletResponse response, 
									ModelAndView mv, Tip_BoardVO vo, RedirectAttributes rttr) {
		// 1. 요청분석
		// => Delete 성공: redirect:blist
		//           실패: message 표시, redirect:bdetail
		String uri = "redirect:tipblist";
		
		// 2. Service 처리
		if ( service.delete(vo) > 0 ) {
			rttr.addFlashAttribute("message", "~~ 글삭제 성공 ~~"); 
		}else {
			rttr.addFlashAttribute("message", "~~ 글삭제 실패, 다시 하세요 ~~");
			uri = "redirect:tipbdetail?seq="+vo.getSeq();
		} // Service
		
		// 3. 결과(ModelAndView) 전달 
		mv.setViewName(uri);
		return mv;
	} //bdelete
	
	
} //class
