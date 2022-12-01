package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criTest.SearchCriteria;
import mapperInterface.UserMapper;
import vo.Notice_BoardVO;
import vo.UserVO;

//** Service
//=> 요청클래스 와 DAO클래스 사이의 연결(완충지대) 역할
//=> 요청클래스(컨트롤러) 와 DAO클래스 사이에서 변경사항이 생기더라도 서로 영향 받지않도록해주는 역할
// 결합도는 낮추고, 응집도는 높인다

//** interface 자동완성 
//=> Alt + Shift + T  
//=> 또는 마우스우클릭 PopUp Menu 의  Refactor - Extract Interface...

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserMapper mapper;
	
	
	// ** selectList
	@Override
	public List<UserVO> selectList(){
		return mapper.selectList();
	}
	// ** SearchCriteria PageList
	@Override
	public List<UserVO> searchList(SearchCriteria cri) {
		return mapper.searchList(cri);
	}
	@Override
	public int searchCount(SearchCriteria cri) {
		return mapper.searchCount(cri);
	}
	// ** selectOne
	@Override
	public UserVO selectOne(UserVO vo) {
		return mapper.selectOne(vo);
	}
	// ** Insert
	@Override
	public int insert(UserVO vo) {
		return mapper.insert(vo);
	}
	// ** update
	@Override
	public int update(UserVO vo) {
		return mapper.update(vo);
	}
	// ** pwupdate
	@Override
	public int pwupdate(UserVO vo) {
		return mapper.pwupdate(vo);
	}
	// ** delete
	@Override
	public int delete(UserVO vo) {
		return mapper.delete(vo);
	}
	
	// userDetailList
	@Override
	public List<UserVO> userDetailList(UserVO vo) {
		return mapper.userDetailList(vo);
	}

	@Override
	public int userDetailListCount(SearchCriteria cri) {
		return mapper.userDetailListCount(cri);
	}
}
