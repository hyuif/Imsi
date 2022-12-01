package com.ncs.hhh;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import service.Board_likeService;
import vo.Board_likeVO;
import vo.CommentVO;


@RestController
@RequestMapping("/Like")
public class Board_likeController {
	
	@Autowired
	Board_likeService service;
	
	
	
	@RequestMapping("/InsertLike")
	public String InsertLike(@RequestBody Board_likeVO vo,HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("세션 겟어트리"+session.getAttribute("com_bno"));
		System.out.println("리퀘스트겟 파라"+request.getParameter("com_bno"));
		System.out.println("리퀘스트겟 파라"+request.getParameter("com_type"));
//		int b_no = Integer.parseInt(request.getParameter("com_no"));
//		int b_type = Integer.parseInt(request.getParameter("com_type"));
		
		
		
		System.out.println("id1의 값 => "+service.likeuser(17, 1));
		String id2 = (String) session.getAttribute("loginID");
		
		  if(id2 == null) 
			{
				return "fail";
			}
				else if(service.likeuser(17, 1).contains(id2)){ return "overlap"; }
		  else{
		 
			service.create(vo);
			System.out.println("좋아요 등록 서비스 성공");}
		  	System.out.println(vo);
		  
			return "InsertLike";
		
	}
	
}