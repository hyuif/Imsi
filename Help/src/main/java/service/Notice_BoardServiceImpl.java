package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criTest.Criteria;
import criTest.SearchCriteria;
import mapperInterface.Notice_BoardMapper;
import mapperInterface.Tip_BoardMapper;
import vo.Notice_BoardVO;

@Service
public class Notice_BoardServiceImpl implements Notice_BoardService {
	@Autowired
	Notice_BoardMapper mapper;
	
	// ** selectList
	@Override
	public List<Notice_BoardVO> selectList() {
		return mapper.selectList();
	}
	// ** selectOne
	@Override
	public Notice_BoardVO selectOne(Notice_BoardVO vo) {
		return mapper.selectOne(vo);
	}
	
	// ** Insert
	@Override
	public int insert(Notice_BoardVO vo) {
		return mapper.insert(vo);
	}
	// ** Update
	@Override
	public int update(Notice_BoardVO vo) {
		return mapper.update(vo);
	}
	// ** Delete
	@Override
	public int delete(Notice_BoardVO vo) {
		return mapper.delete(vo);
	}
	// ** 조회수 증가
	@Override
	public int countUp(Notice_BoardVO vo) {
		return mapper.countUp(vo);
	}
	
	// ** 검색 기능
	@Override
	public List<Notice_BoardVO> searchList(SearchCriteria cri) {
		return mapper.searchList(cri);
	}
	@Override
	public int searchCount(SearchCriteria cri) {
		return mapper.searchCount(cri);
	}
	
	// home 출력 최신글
	@Override
	public List<Notice_BoardVO> selectNList(){
		return mapper.selectNList();
	}
	
	// search 
	@Override
	public List<Notice_BoardVO> nsearchsearch(SearchCriteria cri) {
		return mapper.nsearchsearch(cri);
	}
	@Override
	public int nsearchCount(SearchCriteria cri) {
		return mapper.nsearchCount(cri);
	}	
	

}
