package com.salre.main.loan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoanService {
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 금리 순으로 대출상품 조회
    public List<LoanDTO> selectByRate(int age, int income) {
        Map<String, Object> params = new HashMap<>();
        params.put("age", age);
        params.put("income", income);
        
        return sqlSession.selectList("loanMapper.selectByRate", params);
    }
    
    // 한도 순으로 대출상품 조회
    public List<LoanDTO> selectByLimit(int age, int income) {
        Map<String, Object> params = new HashMap<>();
        params.put("age", age);
        params.put("income", income);
        
        return sqlSession.selectList("loanMapper.selectByLimit", params);
    }
}