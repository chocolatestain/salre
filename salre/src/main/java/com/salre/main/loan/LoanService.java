package com.salre.main.loan;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoanService {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<LoanDTO> selectAll() {
		return sqlSession.selectList("loanMapper.selectAll");
	}
}