package mapperInterface;


import java.util.*;

import org.apache.ibatis.annotations.Param;

import vo.Board_likeVO;

public interface Board_likeMapper {
	
    void create(Board_likeVO vo); //댓글 등록
	
	int countbyLike(@Param("b_no") int b_no, @Param("b_type") int b_type);
	
	ArrayList<String> likeuser(@Param("b_no") int b_no, @Param("b_type") int b_type);
	
	int like_check(Board_likeVO vo);
	
	int like_check_cancel(Board_likeVO vo);
	
	
	
	
	
} //interface
