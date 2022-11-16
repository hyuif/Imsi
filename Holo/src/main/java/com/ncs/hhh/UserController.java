package com.ncs.hhh;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criTest.PageMaker;
import criTest.SearchCriteria;
import service.UserService;
import vo.UserVO;


@Controller
public class UserController {

	@Autowired
	UserService service;

	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


	// ** user PageList
	@RequestMapping(value = "/user")
	public ModelAndView user(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		// 1) Criteria 처리 
		cri.setSnoEno();

		// 2) 서비스처리
		// => List 처리
		mv.addObject("banana", service.searchList(cri)); // ver01

		// 3) View 처리 => PageMaker
		pageMaker.setCri(cri);
		pageMaker.setTotalRowsCount(service.searchCount(cri)); // ver01 : 전체 row 갯수
		mv.addObject("pageMaker", pageMaker);

		mv.addObject("pageMaker",pageMaker);
		mv.setViewName("/user/userList");
		return mv;
	} //bcrilist



	/*
	// ** Ajax memberDelete : 관리자 회원 삭제
	@RequestMapping(value="/axmdelete", method=RequestMethod.POST)
	public ModelAndView axmdelete(HttpServletRequest request, ModelAndView mv, UserVO vo ) {
		// 1. 요청분석
		String id = null;
		HttpSession session = request.getSession(false);

		if ( session!=null && ((String)session.getAttribute("loginID")).equals("admin") ) {
			if ( service.delete(vo) > 0 ) {
				mv.addObject("code","200"); // 성공
			}else {
				mv.addObject("code","201"); // 실패
			} 
		}else {
			mv.addObject("code","202");
		} // session 확인_if_else

		// 3. 결과(ModelAndView) 전달 
		mv.setViewName("jsonView");
		return mv;
	} // axmdelete
	 */

	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		// 1) request 처리
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		UserVO vo = new UserVO();
		String uri = "/home";

		// 2) service 처리
		vo.setId(id);
		vo = service.selectOne(vo);
		if ( vo != null ) { 
			// ID 는 일치 -> Password 확인
			// => password 암호화 이전
			// if ( vo.getPassword().equals(password) ) {
			// => password 암호화 이후
			if (passwordEncoder.matches(password, vo.getPassword()) ) {

				// Login 성공 -> login 정보 session에 보관, home
				request.getSession().setAttribute("loginID", id);
				request.getSession().setAttribute("loginName", vo.getName());

				// ** BCryptPasswordEncoder 로 암호화되면 복호화가 불가능함.
				// => password 수정 을 별도로 처리해야 함. 
				// => 그러나 기존의 update  Code 를 활용하여 updateForm.jsp 에서 수정을 위해 
				//    User가 입력한 raw_password 를 보관함. 
				// => 이 session에 보관한 값은 detail 에서 "U" 요청시 사용함. 
				//request.getSession().setAttribute("loginPW", password); 
				uri="home";
			}else {
				// Password 오류
				mv.addObject("message", "~~ Password 오류,  다시 하세요 ~~");
			}
		}else {	// ID 오류
			mv.addObject("message", "~~ ID 오류,  다시 하세요 ~~");
		} //else
		mv.setViewName(uri);
		return mv;
	}


	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		// ** session 인스턴스 정의 후 삭제하기
		// => 매개변수: 없거나, true, false
		// => false : session 이 없을때 null 을 return;

		HttpSession session = request.getSession(false);
		if (session!=null) session.invalidate();
		mv.addObject("message", "~~ 로그아웃 되었습니다 ~~"); 
		mv.setViewName("home");

		return mv;
	} 

	// ** Join : 회원가입
	@RequestMapping(value = "/joinf")
	public ModelAndView joinf(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		mv.setViewName("/user/joinForm");
		return mv;
	}
	@RequestMapping(value = "/join" , method = RequestMethod.POST)
	// => 매핑네임과 method 가 일치하는 요청만 처리함
	public ModelAndView join(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, UserVO vo) throws IOException {
		// 1. 요청분석
		// => Service 준비
		// => request, 한글처리
		// => Spring : 한글(web.wml , filter) , request ( 매핑메서드의 매개변수선언으로 처리 )
		// => Join 성공 : 로그인 유도 loginForm
		//		   실패 : joinForm
		String uri = "home";


		// ** MultipartFile ***********************
		// => MultipartFile 타입의 uploadfilef 의 정보에서 
		//    upload된 image 화일과 화일명을 get 처리,
		// => upload된 image 화일은 서버의 정해진 폴더 (물리적위치)에 저장 하고, -> file1
		// => 이 위치에 대한 정보를 table에 저장 (vo의 UploadFile 에 set) -> file2
		// ** image 화일명 중복시 : 나중 이미지로 update 됨. 

		// ** Image 물리적위치 에 저장
		// 1) 현재 웹어플리케이션의 실행 위치 확인 : 
		// => eslipse 개발환경 (배포전)
		//    C:\MTest\myWork\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring02\
		// => 톰캣서버에 배포 후 : 서버내에서의 위치가 됨
		//    D:\MTest\IDESet\apache-tomcat-9.0.41\webapps\Spring01\
		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath => "+realPath);

		// 2) 위 의 값을 이용해서 실제저장위치 확인 
		// => 개발중인지, 배포했는지 에 따라 결정
		if ( realPath.contains(".eclipse.") )  // eslipse 개발환경 (배포전)
			realPath = "C:\\MTest\\mywork\\Holo\\src\\main\\webapp\\resources\\Uimages\\";
		else  // 톰캣서버에 배포 후 : 서버내에서의 위치
			realPath += "resources\\Uimages\\" ;

		// ** 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		// => realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		//    존재하지 않으면 디렉토리 생성

		// ** 기본 이미지 지정하기 
		String file1, file2="resources/Uimages/asdf.gif"; 

		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()

		MultipartFile uploadfilef = vo.getUploadfilef();  // file 의 내용및 화일명 등 전송된 정보들
		if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {

			// ** Image를 선택함 -> Image저장 ( 경로_realPath + 화일명 )
			// 1) 물리적 저장경로에 Image 저장
			file1 = realPath + uploadfilef.getOriginalFilename(); // 경로완성
			uploadfilef.transferTo(new File(file1)); // Image저장

			// 2) Table 저장 준비
			file2="resources/Uimages/"+uploadfilef.getOriginalFilename();
		}
		// ** 완성된 경로 vo 에 set
		vo.setUploadfile(file2);

		// ** password 암호화 적용하기
		// => BCryptPasswordEncoder 적용
		//    encode(rawData) -> digest 생성 & vo 에 set  
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));


		// 2. Service 처리
		if(service.insert(vo) > 0) {
			mv.addObject("message" , " ~~ 회원가입 성공, 로그인 후 이용하세여");
		} else {
			mv.addObject("message"," ~~ 회원가입 실패, 다시 하세요");
			uri = "/user/joinForm";
		}

		// 3. 결과 (View -> forward) 처리
		mv.setViewName(uri);
		return mv;
	} //Join


	// ** id 중복 확인
	@RequestMapping(value = "/idDupCheck")
	public ModelAndView idDupCheck(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv, UserVO vo) {
		// 1) 입력한 newID 보관
		mv.addObject("newId", vo.getId());
		// 2) service
		vo = service.selectOne(vo);
		// 3) 결과 처리
		if (vo != null) {
			// -> newId 사용 불가능
			mv.addObject("isUse", "F");
		} else {
			mv.addObject("isUse", "T");
		}
		mv.setViewName("/user/idDupCheck");
		return mv;
	} // idDupCheck

	// ** update : 내 정보 수정
	@RequestMapping(value = "/userupdate" , method = RequestMethod.POST)
	public ModelAndView userupdate(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, UserVO vo) throws IOException {

		// 1. 요청분석
		// => Update 성공 : 내정보 표시 -> memberDetail.jsp
		// 			 실패 : 재수정 유도 -> updateForm.jsp
		String uri = "/user/userDetail";
		mv.addObject("apple",vo); //vo : 수정전의 값
		// => Update 성공/실패 모두 출력시 필요하므로
		// => Image 추가 후에는 Update 성공 후에는 uploadfile 의 값이 변경될수있으므로
		//	  성공 후에는 재처리해야함


		// ** Image Update 추가
		// 1) Image 물리적 저장 위치 확인 작업
		String realPath = request.getRealPath("/"); // deprecated Method

		// 1.1) 위 의 값을 이용해서 실제저장위치 확인 
		// => 개발중인지, 배포했는지 에 따라 결정
		if ( realPath.contains(".eclipse.") )  // eslipse 개발환경 (배포전)
			realPath = "C:\\MTest\\mywork\\Holo\\src\\main\\webapp\\resources\\Uimages\\";
		else  // 톰캣서버에 배포 후 : 서버내에서의 위치
			realPath += "resources\\Uimages\\" ;

		// 1.2) 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();

		// ** 기본 이미지 지정하기 
		String file1, file2="resources/Uimages/basicman4.png"; 

		// 1.4) MultipartFile : file은 저장, 저장된 경로는 vo에 set
		// => 새 화일 선택 했으면 : uploadfilef 처리
		// => 새 화일 선택 안했으면 : uploadfilef 처리할 필요 없이 uploadfile 사용하면 됨
		MultipartFile uploadfilef = vo.getUploadfilef();  // file 의 내용및 화일명 등 전송된 정보들
		if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {

			// ** 새 Image 화일을 선택함 -> Image저장 ( 경로_realPath + 화일명 )
			// 1.4.1) 물리적 저장경로에 Image 저장
			file1 = realPath + uploadfilef.getOriginalFilename(); // 경로완성
			uploadfilef.transferTo(new File(file1)); // Image저장

			// 1.4.2) Table 저장 준비
			file2="resources/Uimages/"+uploadfilef.getOriginalFilename();
			vo.setUploadfile(file2);
		}
		// ** new_Image 를 선택하지 않은 경우
		// => form 에서 전송되어 vo 에 담겨진 uploadfile 값을 사용하면 됨. 

		// ** password 암호화 적용하기
		// => BCryptPasswordEncoder 적용
		//    encode(rawData) -> digest 생성 & vo 에 set  
		//vo.setPassword(passwordEncoder.encode(vo.getPassword()));

		// 2. Service 처리
		if (service.update(vo) > 0) {
			mv.addObject("message", "회원 정보 수정 성공");
			mv.addObject("apple",vo); // 회원 정보 수정이 되면 vo에 수정된 값이 들어가야함
		}else {
			// update 실패 : 재수정 유도 -> updateForm.jsp 
			mv.addObject("message", "회원 정보 수정 실패, 다시 하세요 ~~");
			uri = "/user/updateForm";
		}

		// 3. 결과(ModelAndView) 전달 
		mv.setViewName(uri);
		return mv;
	}

	// ** pwupdate : 내 정보 수정
	@RequestMapping(value = "/pwupdate" , method = RequestMethod.POST)
	public ModelAndView pwupdate(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, UserVO vo) throws IOException {
		// 1. 요청분석
		// => Update 성공 : 내정보 표시 -> memberDetail.jsp
		// 			 실패 : 재수정 유도 -> updateForm.jsp
		String uri = "home";

		// id 찾기
		HttpSession session = request.getSession(false);

		if ( session!=null && session.getAttribute("loginID")!=null ) 
			vo.setId((String)session.getAttribute("loginID"));

		mv.addObject("apple",vo); //vo : 수정전의 값


		// ** password 암호화 적용하기
		// => BCryptPasswordEncoder 적용
		//    encode(rawData) -> digest 생성 & vo 에 set  
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));

		System.out.println("***** pwupdate =>"+vo);
		// 2. Service 처리
		if (service.pwupdate(vo) > 0) {
			mv.addObject("message", "비밀번호 수정 성공");
			mv.addObject("apple",vo); // 회원 정보 수정이 되면 vo에 수정된 값이 들어가야함
		}else {
			// update 실패 : 재수정 유도 -> pwupdate.jsp 
			mv.addObject("message", "회원 정보 수정 실패, 다시 하세요 ~~");
			uri = "/user/pwupdate";
		}

		// 3. 결과(ModelAndView) 전달 
		mv.setViewName(uri);
		return mv;
	}

	// ** MemberDetail
	@RequestMapping(value = "/userdetail")
	public ModelAndView userdetail(HttpServletRequest request, HttpServletResponse response, UserVO vo , ModelAndView mv) {
		// => Mapping 메서드 : 매개변수로 지정된 객체에 request_ParameterName 과 일치하는 컬럼(setter)존재하면 자동으로 set 
		//MemberVO vo = new MemberVO();
		//vo.setId(request.getParameter("id")); 매개변수에 추가하면 자동으로 생겨서 필요 없어짐

		// 1. 요청분석
		// => 요청구분 ( 요청에 따라 id 가져오기 )
		//   - 로그인후 내정보 보기: session.getAttr~~ 
		//   - 관리자가 memberList 에서 선택: getParameter...)

		HttpSession session = request.getSession(false);

		if (vo.getId() == null || vo.getId().length()<1) {
			// => parameter id의 값이 없으면 session에서 가져옴 
			if ( session!=null && session.getAttribute("loginID")!=null ) 
				vo.setId((String)session.getAttribute("loginID"));
			else {
				request.setAttribute("message", "=> 출력할 id 없음, 로그인후 이용하세요 ~~");
				mv.setViewName("home");
				return mv;
			}
		} //getParameter_else

		String uri = "/user/userDetail";

		// 2. Service 처리
		// => Service 에서 selectOne
		vo=service.selectOne(vo);
		if (vo != null) {

			// ** Update 요청이면 uqdateForm.jsp 로
			// => passwordEncoder 사용 후 에는
			//	  session에 보관해 놓은 raw_password 를 수정할수 있도록 vo에 set 해줌
			if("U".equals(request.getParameter("jCode")) ) {
				uri = "/user/updateForm";
				vo.setPassword((String)session.getAttribute("loginPW")); 
			}else if("Y".equals(request.getParameter("jCode"))) {
				uri = "/user/pwupdate";
				vo.setPassword((String)session.getAttribute("loginPW")); 
			}
			mv.addObject("apple", vo);
		}else {
			mv.addObject("message","~~ "+request.getParameter("id")+"님의 자료는 존재하지 않습니다 ~~"); 
		}	
		mv.setViewName(uri);
		return mv;
	} //mdetail



	// ** Delete : 회원탈퇴
	@RequestMapping(value="/userdelete")
	public ModelAndView userdelete(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, UserVO vo, RedirectAttributes rttr) {
		// 1. 요청분석
		// => Delete 성공: session 무효화, message 표시, home.jsp
		//           실패: message 표시, home.jsp
		// => 삭제대상 확인 : 본인 loginID or 관리자가 삭제하는경우 (request.getParameter..) 

		String id = null;
		HttpSession session = request.getSession(false);
		// => 메서드내에서 session 을 사용가능 하도록 정의
		//    삭제성공후 session 무효화 하기위함.

		if ( session!=null && session.getAttribute("loginID")!=null ) {
			// ** 삭제 가능한 경우
			id = (String)session.getAttribute("loginID");
			// => 본인 탈퇴: loginID 이용한 삭제
			// 	- 그러나 id 는 관리자가 아니어야함. 
			// 	- 관리자 작업인경우 : 이미 vo에 삭제할 ID 가 set 되어있음
			//	- 관리자 작업 아닌경우: session 에서 get한 ID 를 vo에 set 
			if ( !"admin".equals(id) )  vo.setId(id);

			// 2. Service 처리
			if ( service.delete(vo) > 0 ) {
				// 성공: session 무효화, home.jsp
				rttr.addFlashAttribute("message", "~~ 회원탈퇴 성공, 1개월 후 재가입 가능합니다 ~~"); 
				// 본인이 탈퇴하는 경우에만 session 무효화
				if ( !"admin".equals(id) ) session.invalidate();
			}else {
				rttr.addFlashAttribute("message", "~~ 회원탈퇴 실패, 다시 하세요 ~~");
			} // Service

		}else {
			// ** session 정보가 없어 삭제가 불가능한 경우
			// => session is null
			rttr.addFlashAttribute("message", "~~ 삭제할 id 없음, 로그인후 이용하세요 ~~");
		} // session 확인_if_else

		// 3. 결과(ModelAndView) 전달 
		// =>  성공 & 실패
		//	- redirect home 이 바람직 (단, message 처리 주의)
		//	- 웹브라우져 주소창의 주소가 home 이 표시 되도록
		mv.setViewName("redirect:home");
		return mv;
	}

} //class
