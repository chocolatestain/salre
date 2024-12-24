package com.salre.main.product;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
 
@Slf4j
@Controller
public class HomeController {

    @Autowired
    private ProductService productservice;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home() {
        return "home";
    }

    @GetMapping("/search")
    public String searchProducts(@RequestParam("search") String searchQuery, Model model) {
        // 검색어가 비어있을 때 예외 처리
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            model.addAttribute("message", "검색어를 입력해주세요.");
            return "search";
        }

        log.info("검색어: {}", searchQuery);  // 로그로 검색어 확인

        // ProductService에서 검색 결과 가져오기
        List<ProductDTO> searchResults = productservice.searchProducts(searchQuery);

        // 검색 결과가 없을 경우
        if (searchResults == null || searchResults.isEmpty()) {
            model.addAttribute("message", "검색 결과가 없습니다.");
        } else {
            model.addAttribute("searchResults", searchResults);
      
        }

        return "search";
    }
}