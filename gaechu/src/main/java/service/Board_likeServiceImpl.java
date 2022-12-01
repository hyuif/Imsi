package service;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.Board_likeMapper;
import vo.Board_likeVO;

@Service
public class Board_likeServiceImpl implements Board_likeService {
	@Autowired
	Board_likeMapper mapper;
	
	@Override
	public void create(Board_likeVO vo) {
		mapper.create(vo);

	}

	@Override
	public int countbyLike(int b_no, int b_type) {
		return mapper.countbyLike(b_no, b_type);
	}

	@Override
	public int like_check(Board_likeVO vo) {
		return mapper.like_check(vo);
	}

	@Override
	public int like_check_cancel(Board_likeVO vo) {
		return mapper.like_check_cancel(vo);
	}

	@Override
	public ArrayList<String> likeuser(int b_no, int b_type) {
		return mapper.likeuser(b_no,b_type);
	}

	
}
