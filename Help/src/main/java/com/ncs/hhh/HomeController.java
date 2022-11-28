package com.ncs.hhh;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import vo.Club_BoardVO;
import vo.F_BoardVO;
import vo.Notice_BoardVO;
import vo.T_BoardVO;
import vo.Tip_BoardVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

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

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = {"/","home"}, method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv ) {
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

	@RequestMapping(value="/searchsearch")
	public ModelAndView searchsearch(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();

		// 2) 서비스처리
		// => List 처리
		mv.addObject("nservice", nservice.nsearchsearch(cri)); // ver02
		
		// 3) View 처리 => PageMaker
		System.out.println("************************************************************************"+pageMaker);
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
