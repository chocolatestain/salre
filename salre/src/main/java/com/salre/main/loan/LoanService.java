package com.salre.main.loan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoanService {
    @Autowired
    private LoanRepository loanRepository;

    // 금리순으로 대출 조회
    public List<LoanDTO> selectByRate(int age, int income) {
        return loanRepository.selectByRate(age, income);
    }

    // 한도순으로 대출 조회
    public List<LoanDTO> selectByLimit(int age, int income) {
        return loanRepository.selectByLimit(age, income);
    }
}