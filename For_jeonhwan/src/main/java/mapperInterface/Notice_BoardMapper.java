package mapperInterface;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.Notice_BoardVO;
import vo.Tip_BoardVO;

public interface Notice_BoardMapper {
	
	// ** Criteria PageList
	// => ver02
	List<Notice_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	/*
	// => ver01 
	List<Notice_BoardVO> criList(Criteria cri);
	int criTotalCount();
	*/
	// ** selectList
	List<Notice_BoardVO> selectList();
	// ** selectOne
	Notice_BoardVO selectOne(Notice_BoardVO vo);
	
	// ** Insert: 새글등록 
	int insert(Notice_BoardVO vo);
	// ** Update: 글수정
	int update(Notice_BoardVO vo);
	// ** Delete
	int delete(Notice_BoardVO vo);
	// ** 조회수 증가
	int countUp(Notice_BoardVO vo);
	
	List<Notice_BoardVO> selectNList();
	List<Notice_BoardVO> selectNhotList();
	
} //interface
