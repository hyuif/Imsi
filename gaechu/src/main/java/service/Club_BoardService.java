package service;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.Club_BoardVO;

public interface Club_BoardService {
	List<Club_BoardVO> selectList();
	
	List<Club_BoardVO> checkList(SearchCriteria cri);
	int checkCount(SearchCriteria cri);
	
	// ** Criteria PageList
	// => ver02
	List<Club_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<Club_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectOne
	Club_BoardVO selectOne(Club_BoardVO vo);
	// ** n_selectOne
	Club_BoardVO n_selectOne(Club_BoardVO vo);
	// ** p_selectOne
	Club_BoardVO p_selectOne(Club_BoardVO vo);
	
	// ** Insert
	int insert(Club_BoardVO vo);

	// ** Update
	int update(Club_BoardVO vo);

	// ** Delete
	int delete(Club_BoardVO vo);

	// ** 조회수 증가
	int countUp(Club_BoardVO vo);

	// ** 답글 등록
	int rinsert(Club_BoardVO vo);
	
	
	List<Club_BoardVO> selectChotList();
}
