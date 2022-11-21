package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criTest.Criteria;
import criTest.SearchCriteria;
import mapperInterface.Club_BoardMapper;
import vo.Club_BoardVO;

@Service
public class Club_BoardServiceImpl implements Club_BoardService {
	@Autowired
	Club_BoardMapper mapper;
	
	@Override
	public List<Club_BoardVO> checkList(SearchCriteria cri){
 		return mapper.checkList(cri);
 	}
 	@Override
 	public int checkCount(SearchCriteria cri) {
 		return mapper.checkCount(cri);
 	}
	
	
	// ** Criteria PageList
	@Override // ver02
	public List<Club_BoardVO> searchList(SearchCriteria cri) {
		return mapper.searchList(cri);
	}
	public int searchCount(SearchCriteria cri) {
		return mapper.searchCount(cri);
	}
	
	@Override // ver01
	public List<Club_BoardVO> criList(Criteria cri) {
		return mapper.criList(cri);
	}
	public int criTotalCount() {
		return mapper.criTotalCount();
	}
	
	// ** selectList
	@Override
	public List<Club_BoardVO> selectList() {
		return mapper.selectList();
	}
	// ** selectOne
	@Override
	public Club_BoardVO selectOne(Club_BoardVO vo) {
		return mapper.selectOne(vo);
	}
	
	// ** Insert
	@Override
	public int insert(Club_BoardVO vo) {
		return mapper.insert(vo);
	}
	// ** Update
	@Override
	public int update(Club_BoardVO vo) {
		return mapper.update(vo);
	}
	// ** Delete
	@Override
	public int delete(Club_BoardVO vo) {
		return mapper.delete(vo);
	}
	// ** 조회수 증가
	@Override
	public int countUp(Club_BoardVO vo) {
		return mapper.countUp(vo);
	}
	
	// ** 답글 등록
	@Override
	public int rinsert(Club_BoardVO vo) {
		int result = mapper.rinsert(vo);
		if ( result>0 )
			System.out.println("** stepUpdate Count => "+ mapper.stepUpdate(vo));
		else result=0;
		return result;
	}
	
	
}
