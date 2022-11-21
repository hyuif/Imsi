package mapperInterface;

import java.util.List;

import criTest.Criteria;
import criTest.SearchCriteria;
import vo.Club_BoardVO;
import vo.Tip_BoardVO;

public interface Club_BoardMapper {
	
	List<Club_BoardVO> checkList(SearchCriteria cri);
	int checkCount(SearchCriteria cri);
	
	// ** Criteria PageList
	// => ver02
	List<Club_BoardVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	
	// => ver01 
	List<Club_BoardVO> criList(Criteria cri);
	int criTotalCount();
	
	// ** selectList
	List<Club_BoardVO> selectList();
	// ** selectOne
	Club_BoardVO selectOne(Club_BoardVO vo);
	
	// ** Insert: 새글등록 
	int insert(Club_BoardVO vo);
	// ** Update: 글수정
	int update(Club_BoardVO vo);
	// ** Delete
	int delete(Club_BoardVO vo);
	// ** 조회수 증가
	int countUp(Club_BoardVO vo);
	
	// ** Reply Insert
	int stepUpdate(Club_BoardVO vo);
	
	int rinsert(Club_BoardVO vo);
	
	
} //interface
