package com.salre.main.loan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoanRepository {

    @Autowired
    private SqlSessionTemplate sqlSession;

    // 공통된 파라미터를 설정하는 메서드
    private Map<String, Object> createParams(int age, int income) {
        Map<String, Object> map = new HashMap<>();
        
        map.put("age", age);
        map.put("income", income);
        
        return map;
    }

    // 금리 순으로 대출상품 조회
    public List<LoanDTO> selectByRate(int age, int income) {
    	Map<String, Object> map = createParams(age, income);
    	
        return sqlSession.selectList("loanMapper.selectByRate", map);
    }

    // 한도 순으로 대출상품 조회
    public List<LoanDTO> selectByLimit(int age, int income) {
    	Map<String, Object> map = createParams(age, income);
    	
        return sqlSession.selectList("loanMapper.selectByLimit", map);
    }
}
