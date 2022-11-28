package service;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.Notice_BoardVO;
import vo.Tip_BoardVO;

public interface Tip_BoardService {
	List<Tip_BoardVO> selectList();

	// ** Criteria PageList
	// => ver02
	List<Tip_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<Tip_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectOne
	Tip_BoardVO selectOne(Tip_BoardVO vo);
	
	// ** Insert
	int insert(Tip_BoardVO vo);

	// ** Update
	int update(Tip_BoardVO vo);

	// ** Delete
	int delete(Tip_BoardVO vo);

	// ** 조회수 증가
	int countUp(Tip_BoardVO vo);

	// ** 답글 등록
	int rinsert(Tip_BoardVO vo);
	
	List<Tip_BoardVO> selectHList();
	List<Tip_BoardVO> selectHhotList();


}
