package service;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.F_BoardVO;
import vo.Notice_BoardVO;
import vo.T_BoardVO;

public interface F_BoardService {
	// ** F_Blist
	
	// ** selectOne
	F_BoardVO selectOne(F_BoardVO vo);
	
	// ** n_selectOne
	F_BoardVO n_selectOne(F_BoardVO vo);
	
	// ** p_selectOne
	F_BoardVO p_selectOne(F_BoardVO vo);
	
	// ** Insert
	int insert(F_BoardVO vo);
	
	// ** Update
	int update(F_BoardVO vo);
	
	// ** Delete
	int delete(F_BoardVO vo);
	
	// ** 조회수 증가
	int countUp(F_BoardVO vo);

	// ** 답글 등록
	int rinsert(F_BoardVO vo);
	
	// ** Criteria PageList
	// => ver02
	List<F_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<F_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectList
	List<F_BoardVO> selectList();
	
	List<F_BoardVO> selectfhotList();


}
