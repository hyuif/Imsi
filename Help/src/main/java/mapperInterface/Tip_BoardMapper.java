package mapperInterface;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.Notice_BoardVO;
import vo.Tip_BoardVO;

public interface Tip_BoardMapper {
	
	// ** Criteria PageList
	// => ver02
	List<Tip_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<Tip_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectList
	List<Tip_BoardVO> selectList();
	// ** selectOne
	Tip_BoardVO selectOne(Tip_BoardVO vo);
	
	// ** Insert: 새글등록 
	int insert(Tip_BoardVO vo);
	// ** Update: 글수정
	int update(Tip_BoardVO vo);
	// ** Delete
	int delete(Tip_BoardVO vo);
	// ** 조회수 증가
	int countUp(Tip_BoardVO vo);
	
	// ** Reply Insert
	int stepUpdate(Tip_BoardVO vo);
	
	int rinsert(Tip_BoardVO vo);
	
	List<Tip_BoardVO> selectHList();
	List<Tip_BoardVO> selectHhotList();

	
} //interface
