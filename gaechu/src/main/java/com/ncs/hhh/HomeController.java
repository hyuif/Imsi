package com.ncs.hhh;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import criTest.PageMaker;
import criTest.SearchCriteria;
import service.Club_BoardService;
import service.F_BoardService;
import service.Notice_BoardService;
import service.T_BoardService;
import service.Tip_BoardService;
import service.UserService;
import vo.Club_BoardVO;
import vo.F_BoardVO;
import vo.Notice_BoardVO;
import vo.T_BoardVO;
import vo.Tip_BoardVO;
import vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	UserService service;	
	@Autowired
	Notice_BoardService nservice;
	@Autowired
	Tip_BoardService hservice;
	@Autowired
	Club_BoardService cservice;
	@Autowired
	F_BoardService fservice;
	@Autowired
	T_BoardService tservice;
	
	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = {"/","home"}, method = RequestMethod.GET)
	public ModelAndView home(HttpServletRequest request, Locale locale, ModelAndView mv ) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		mv.addObject("serverTime", formattedDate);


		List<Notice_BoardVO> nlist = new ArrayList<Notice_BoardVO>();
		nlist = nservice.selectNList();
		if ( nlist!=null ) {
			mv.addObject("nlist", nlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}


		List<Tip_BoardVO> hlist = new ArrayList<Tip_BoardVO>();
		hlist = hservice.selectHList();
		if ( hlist!=null ) {
			mv.addObject("hlist", hlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}

		List<Tip_BoardVO> hhotlist = new ArrayList<Tip_BoardVO>();
		hhotlist = hservice.selectHhotList();
		if ( hhotlist!=null ) {
			mv.addObject("hhotlist", hhotlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}

		List<Club_BoardVO> chotlist = new ArrayList<Club_BoardVO>();
		chotlist = cservice.selectChotList();
		if ( chotlist!=null ) {
			mv.addObject("chotlist", chotlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}

		List<F_BoardVO> fhotlist = new ArrayList<F_BoardVO>();
		fhotlist = fservice.selectfhotList();
		if ( fhotlist!=null ) {
			mv.addObject("fhotlist", fhotlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}

		List<T_BoardVO> tlist = new ArrayList<T_BoardVO>();
		tlist = tservice.selectTList();
		if ( tlist!=null ) {
			mv.addObject("tlist", tlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}

		
	
		mv.setViewName("home");
		return mv;
	}
	
	@RequestMapping(value = "/login" , method=RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, UserVO vo) {
		// 1) request 처리
		String id = vo.getId();
		String password = vo.getPassword();
		response.setContentType("text/html; charset=UTF-8");
		
		String uri = "/home";

		// 2) service 처리
		vo.setId(id);
		vo = service.selectOne(vo);
		if ( vo != null ) { 
			// ID 는 일치 -> Password 확인
			// => password 암호화 이전
			// if ( vo.getPassword().equals(password) ) 
			// => password 암호화 이후
			if (passwordEncoder.matches(password, vo.getPassword()) ) {

				// Login 성공 -> login 정보 session에 보관, home
				request.getSession().setAttribute("loginID", id);
				request.getSession().setAttribute("loginName", vo.getName());
				mv.addObject("code","200");
				// ** BCryptPasswordEncoder 로 암호화되면 복호화가 불가능함.
				// => password 수정 을 별도로 처리해야 함. 
				// => 그러나 기존의 update  Code 를 활용하여 updateForm.jsp 에서 수정을 위해 
				//    User가 입력한 raw_password 를 보관함. 
				// => 이 session에 보관한 값은 detail 에서 "U" 요청시 사용함. 
				//request.getSession().setAttribute("loginPW", password); 
				uri="home";
			}else {
				// Password 오류
				mv.addObject("code","201");
			}
		}else {	// ID 오류
			mv.addObject("code","202");
		} 
		mv.setViewName("jsonView");
		return mv;
	}
	

	@RequestMapping(value = "/logout" , method=RequestMethod.POST)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {

		HttpSession session = request.getSession(false);
		if (session!=null) session.invalidate();

		mv.setViewName("home");

		return mv;
	} 
	
	@RequestMapping(value="/searchsearch")
	public ModelAndView searchsearch(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();

		// 2) 서비스처리
		// => List 처리
		mv.addObject("nservice", nservice.nsearchsearch(cri)); 
		
		// 3) View 처리 => PageMaker
		System.out.println("*********************************************"+pageMaker);
		pageMaker.setCri(cri);
		pageMaker.setTotalRowsCount(nservice.nsearchCount(cri));     // ver02: 조건과 일치하는 Rows 갯수 
		mv.addObject("pageMaker", pageMaker);

		mv.setViewName("/searchsearch/searchsearch");
		return mv;
	} //searchsearch

	@RequestMapping(value="/searchdetail")
	public ModelAndView search(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, Notice_BoardVO vo) {
		// 1. 요청분석
		String uri = "/searchsearch/searchDetail";
		// 2. Service 처리
		vo = nservice.selectOne(vo);
		if ( vo != null ) {
			// 2.1) 조회수 증가
			String loginID = (String)request.getSession().getAttribute("loginID");
			if ( !vo.getId().equals(loginID) && !"U".equals(request.getParameter("jCode")) ) {
				// => 조회수 증가
				if ( nservice.countUp(vo) > 0 ) vo.setCnt(vo.getCnt()+1); 
			} //if_증가조건
			
			// 2.2) 수정요청 인지 확인
			if ( "U".equals(request.getParameter("jCode")))
				uri = "/searchsearch/searchDetail";
			
			// 2.3)	결과전달		
			mv.addObject("apple", vo);
		}else mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다. ~~");
		
		mv.setViewName(uri);
		return mv;
	} //searchdetail

}
