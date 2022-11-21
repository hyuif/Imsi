package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criTest.Criteria;
import criTest.SearchCriteria;
import mapperInterface.F_BoardMapper;
import vo.F_BoardVO;

@Service
public class F_BoardServiceImpl implements F_BoardService {
	// ** F_Blist
	
	@Autowired
	F_BoardMapper mapper;
	
	// ** Criteria PageList
	@Override 
	public List<F_BoardVO> searchList(SearchCriteria cri) {
		return mapper.searchList(cri);
	}
	public int searchCount(SearchCriteria cri) {
		return mapper.searchCount(cri);
	}
	
	// ** selectOne
	@Override
	public F_BoardVO selectOne(F_BoardVO vo) {
		return mapper.selectOne(vo);
	}
	
	// ** Insert
	@Override
	public int insert (F_BoardVO vo) {
		return mapper.insert(vo);
	}
	// ** Update
	@Override
	public int update(F_BoardVO vo) {
		return mapper.update(vo);
	}
	
	// ** Delete
	@Override
	public int delete(F_BoardVO vo) {
		return mapper.delete(vo);
	}
	
	// ** 조회수 증가
	@Override
	public int countUp(F_BoardVO vo) {
		return mapper.countUp(vo);
	}
	
	// ** 답글 등록
	@Override
	public int rinsert(F_BoardVO vo) {
		int result = mapper.rinsert(vo);
		if ( result>0 )
			System.out.println("** stepUpdate Count => "+ mapper.stepUpdate(vo));
		else result=0;
		return result;
	}
	
	@Override // ver01
	public List<F_BoardVO> criList(Criteria cri) {
		return mapper.criList(cri);
	}
	public int criTotalCount() {
		return mapper.criTotalCount();
	}
	
	// ** selectList
	@Override
	public List<F_BoardVO> selectList() {
		return mapper.selectList();
	}
	

	

} //class
