package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criTest.Criteria;
import criTest.SearchCriteria;
import mapperInterface.T_BoardMapper;
import vo.T_BoardVO;

@Service
public class T_BoardServiceImpl implements T_BoardService {
	// ** T_Blist
	
	@Autowired
	T_BoardMapper mapper;
	
	// ** Board Check List
 	//@Override
	//public List<T_BoardVO> checkList(T_BoardVO vo){
	//	return mapper.checkList(vo);
	//}
	
	
	@Override 
	public List<T_BoardVO> checkList(SearchCriteria cri){
 		return mapper.checkList(cri);
 	}
//	@Override 
//	public List<T_BoardVO> checkList2(SearchCriteria cri){
// 		return mapper.checkList(cri);
// 	}
	@Override
	public int checkCount(SearchCriteria cri) {
		return mapper.checkCount(cri);
	}
	
	// ** Criteria PageList
	@Override 
	public List<T_BoardVO> searchList(SearchCriteria cri) {
		return mapper.searchList(cri);
	}
	public int searchCount(SearchCriteria cri) {
		return mapper.searchCount(cri);
	}
//	@Override 
//	public List<T_BoardVO> searchList2(SearchCriteria cri) {
//		return mapper.searchList(cri);
//	}
	
	// ** selectOne
	@Override
	public T_BoardVO selectOne(T_BoardVO vo) {
		return mapper.selectOne(vo);
	}
	
	// ** Insert
	@Override
	public int insert (T_BoardVO vo) {
		return mapper.insert(vo);
	}
	// ** Update
	@Override
	public int update(T_BoardVO vo) {
		return mapper.update(vo);
	}
	
	// ** Delete
	@Override
	public int delete(T_BoardVO vo) {
		return mapper.delete(vo);
	}
	
	// ** 조회수 증가
	@Override
	public int countUp(T_BoardVO vo) {
		return mapper.countUp(vo);
	}
	
	// ** 답글 등록
	@Override
	public int rinsert(T_BoardVO vo) {
		int result = mapper.rinsert(vo);
		if ( result>0 )
			System.out.println("** stepUpdate Count => "+ mapper.stepUpdate(vo));
		else result=0;
		return result;
	}
	
	@Override // ver01
	public List<T_BoardVO> criList(Criteria cri) {
		return mapper.criList(cri);
	}
	public int criTotalCount() {
		return mapper.criTotalCount();
	}
	
	// ** selectList
	@Override
	public List<T_BoardVO> selectList() {
		return mapper.selectList();
	}
	

	

} //class
