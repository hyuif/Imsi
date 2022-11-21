package service;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.Notice_BoardVO;

public interface Notice_BoardService {
	List<Notice_BoardVO> selectList();

	// ** Criteria PageList
	// => ver02
	List<Notice_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// ** selectOne
	Notice_BoardVO selectOne(Notice_BoardVO vo);
	
	// ** Insert
	int insert(Notice_BoardVO vo);

	// ** Update
	int update(Notice_BoardVO vo);

	// ** Delete
	int delete(Notice_BoardVO vo);

	// ** 조회수 증가
	int countUp(Notice_BoardVO vo);
	
	List<Notice_BoardVO> selectNList();
	List<Notice_BoardVO> selectNhotList();
	
}
