package service;

import java.util.List;

import criTest.SearchCriteria;
import vo.UserVO;

public interface UserService {
	
	// ** Member Check List
	//List<UserVO> checkList(UserVO vo);
	
	// ** selectList
	List<UserVO> selectList();
	// ** SearchCriteria PageList
	List<UserVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	// ** selectOne
	UserVO selectOne(UserVO vo);
	// ** Insert
	int insert(UserVO vo);
	// ** update
	int update(UserVO vo);
	int pwupdate(UserVO vo);

	// ** delete
	int delete(UserVO vo);
	
	// userDetailList
	List<UserVO> userDetailList(UserVO vo);
	int userDetailListCount(SearchCriteria cri);
}