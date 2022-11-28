package service;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.T_BoardVO;

public interface T_BoardService {
	// ** T_Blist
	
	// ** Board Check List
	//List<T_BoardVO> checkList(T_BoardVO vo);
	
	
	
	List<T_BoardVO> checkList(SearchCriteria cri);
	//List<T_BoardVO> checkList2(SearchCriteria cri);
	int checkCount(SearchCriteria cri);
	
	
	// ** Criteria PageList
	// => ver02
	List<T_BoardVO> searchList(SearchCriteria cri);
	//List<T_BoardVO> searchList2(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<T_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectList
	List<T_BoardVO> selectList();
	
	// ** selectOne
	T_BoardVO selectOne(T_BoardVO vo);
	
	// ** n_selectOne
	T_BoardVO n_selectOne(T_BoardVO vo);
	
	// ** p_selectOne
	T_BoardVO p_selectOne(T_BoardVO vo);
	
	// ** Insert
	int insert(T_BoardVO vo);
	
	// ** Update
	int update(T_BoardVO vo);
	
	// ** Delete
	int delete(T_BoardVO vo);
	
	// ** 조회수 증가
	int countUp(T_BoardVO vo);

	// ** 답글 등록
	int rinsert(T_BoardVO vo);

	List<T_BoardVO> selectTList();



}
