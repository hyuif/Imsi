package service;

import java.util.List;

import vo.CommentVO;

public interface CommentService {
	void CommentRegist(CommentVO vo); //댓글 등록
	List<CommentVO> getList(int com_bno); //목록 요청
	int getTotal(int com_bno); //댓글 개수
	List<CommentVO> myRecord(String writer);
	void commentDelete(CommentVO vo);
	
	List<CommentVO> getComList(String com_wrtier); //어드민용 회원 댓글 불러오긔
	
}
