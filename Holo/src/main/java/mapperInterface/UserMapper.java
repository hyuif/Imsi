package mapperInterface;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import criTest.SearchCriteria;
import vo.UserVO;

public interface UserMapper {
	/*
	// ** Junit Test **********************
	int totalCount();
	// ** @ 으로 SQL 구문 처리 (~MApper.xml 필요없음)
	@Select("select * from member where id != 'admin'")
	List<UserVO> selectList2();
	*/
	
	// ** Member Check List *******************************
//	List<UserVO> checkList(UserVO vo);
	// ** selectList
	List<UserVO> selectList();
	
	// ** SearchCriteria PageList
	List<UserVO> searchList(SearchCriteria cri);
	int searchCount(SearchCriteria cri);
	// ** selectOne
	UserVO selectOne(UserVO vo);
	// ** Join -> Insert
	int insert(UserVO vo);
	// ** update
	int update(UserVO vo);
	int pwupdate(UserVO vo);
	// ** delete
	int delete(UserVO vo);

	
	
	
	
} //interface
