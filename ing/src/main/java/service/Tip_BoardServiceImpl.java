package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criTest.Criteria;
import criTest.SearchCriteria;
import mapperInterface.Tip_BoardMapper;
import vo.Notice_BoardVO;
import vo.Tip_BoardVO;

@Service
public class Tip_BoardServiceImpl implements Tip_BoardService {
	@Autowired
	Tip_BoardMapper mapper;

	// ** Criteria PageList
	@Override // ver02
	public List<Tip_BoardVO> searchList(SearchCriteria cri) {
		return mapper.searchList(cri);
	}
	public int searchCount(SearchCriteria cri) {
		return mapper.searchCount(cri);
	}

	@Override // ver01
	public List<Tip_BoardVO> criList(Criteria cri) {
		return mapper.criList(cri);
	}
	public int criTotalCount() {
		return mapper.criTotalCount();
	}

	// ** selectList
	@Override
	public List<Tip_BoardVO> selectList() {
		return mapper.selectList();
	}
	// ** selectOne
	@Override
	public Tip_BoardVO selectOne(Tip_BoardVO vo) {
		return mapper.selectOne(vo);
	}

	// ** Insert
	@Override
	public int insert(Tip_BoardVO vo) {
		return mapper.insert(vo);
	}
	// ** Update
	@Override
	public int update(Tip_BoardVO vo) {
		return mapper.update(vo);
	}
	// ** Delete
	@Override
	public int delete(Tip_BoardVO vo) {
		return mapper.delete(vo);
	}
	// ** 조회수 증가
	@Override
	public int countUp(Tip_BoardVO vo) {
		return mapper.countUp(vo);
	}

	// ** 답글 등록
	@Override
	public int rinsert(Tip_BoardVO vo) {
		int result = mapper.rinsert(vo);
		if ( result>0 )
			System.out.println("** stepUpdate Count => "+ mapper.stepUpdate(vo));
		else result=0;
		return result;
	}

	// home 출력 최신글
	@Override
	public List<Tip_BoardVO> selectHList(){
		return mapper.selectHList();
	}	

	// home 출력 인기글
	@Override
	public List<Tip_BoardVO> selectHhotList(){
		return mapper.selectHhotList();
	}

	
}
