package mapperInterface;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.T_BoardVO;

public interface T_BoardMapper {
	
	// ** T_Blist
	
	// ** Criteria PageList
	
	
	// ** Board Check List
	//List<T_BoardVO> checkList(T_BoardVO vo);
	
	
	

	List<T_BoardVO> checkList(SearchCriteria cri);
	//List<T_BoardVO> checkList2(SearchCriteria cri);
	int checkCount(SearchCriteria cri);
	
	// => ver02
	List<T_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<T_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectList
	List<T_BoardVO> selectList();
	//List<T_BoardVO> selectList2();
	
	// ** selectOne
	T_BoardVO selectOne(T_BoardVO vo);
	
	// ** Insert: 새글등록 
	int insert(T_BoardVO vo);
	// ** Update: 글수정
	int update(T_BoardVO vo);
	// ** Delete
	int delete(T_BoardVO vo);
	
	// ** 조회수 증가
	int countUp(T_BoardVO vo);
	
	// ** Reply Insert
	int stepUpdate(T_BoardVO vo);
	int rinsert(T_BoardVO vo);	



} //interface
