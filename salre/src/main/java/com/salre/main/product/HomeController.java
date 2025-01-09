package com.salre.main.product;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
 
@Slf4j
@Controller
public class HomeController {
    @Autowired
    private ProductService productservice;
    @Autowired
    private RegionService regionservice;
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("productCount", productservice.countProduct());
        model.addAttribute("regionCount", regionservice.countRegion()); 
        System.out.println("Region Count : " + regionservice.countRegion());
        System.out.println("Product Count : " + productservice.countProduct());
        try {
			model.addAttribute("regions", new ObjectMapper().writeValueAsString(regionservice.selectAllRegion()));
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return "home";
    } 
}