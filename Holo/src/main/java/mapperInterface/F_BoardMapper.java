package mapperInterface;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.F_BoardVO;

public interface F_BoardMapper {
	
	// ** F_Blist
	
	// ** Criteria PageList
	
	// => ver02
	List<F_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<F_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectList
	List<F_BoardVO> selectList();
	
	// ** selectOne
	F_BoardVO selectOne(F_BoardVO vo);
	
	// ** Insert: 새글등록 
	int insert(F_BoardVO vo);
	// ** Update: 글수정
	int update(F_BoardVO vo);
	// ** Delete
	int delete(F_BoardVO vo);
	
	// ** 조회수 증가
	int countUp(F_BoardVO vo);
	
	// ** Reply Insert
	int stepUpdate(F_BoardVO vo);
	int rinsert(F_BoardVO vo);	



} //interface
