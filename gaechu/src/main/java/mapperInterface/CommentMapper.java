package mapperInterface;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import vo.CommentVO;

public interface CommentMapper {
	
	void CommentRegist(CommentVO vo); //댓글 등록
	List<CommentVO> getList(@Param("com_bno") int com_bno, @Param("com_type") int com_type ,@Param("offset") int offset,@Param("limit") int limit); //목록 요청
	int getTotal(@Param("com_bno") int com_bno, @Param("com_type") int com_type); //댓글 개수
	List<CommentVO> myRecord(String writer);
	void commentDelete(CommentVO vo);
	
	List<CommentVO> getComList(String com_wrtier); //어드민용 회원 댓글 불러오긔
	
	
	
} //interface
