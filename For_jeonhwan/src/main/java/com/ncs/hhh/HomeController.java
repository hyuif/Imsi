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

import service.Notice_BoardService;
import service.Tip_BoardService;
import vo.Notice_BoardVO;
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

		List<Notice_BoardVO> nhotlist = new ArrayList<Notice_BoardVO>();
		nhotlist = nservice.selectNhotList();
		if ( nhotlist!=null ) {
			mv.addObject("nhotlist", nhotlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}
		
		
		List<Tip_BoardVO> hlist = new ArrayList<Tip_BoardVO>();
		hlist = hservice.selectHList();
		if ( nlist!=null ) {
			mv.addObject("hlist", hlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}

		List<Tip_BoardVO> hhotlist = new ArrayList<Tip_BoardVO>();
		hhotlist = hservice.selectHhotList();
		if ( nhotlist!=null ) {
			mv.addObject("hhotlist", hhotlist); 
		}else {
			mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		}
		
		mv.setViewName("home");
		return mv;
	}
	
	

}
