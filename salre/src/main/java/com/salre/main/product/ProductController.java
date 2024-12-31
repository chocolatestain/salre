package com.salre.main.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

 
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;
    
    @GetMapping("/insert")
    public String showCreateForm() { 
        return "product/insert";
    }

    @PostMapping("/insert")
    public String createProduct(@ModelAttribute ProductDTO productDTO, Model model) {
      
        // productDTO 객체로 매핑된 데이터를 확인
        System.out.println(productDTO);
 
        // 비즈니스 로직 처리
        productService.insertProduct(productDTO);

        // 결과 페이지로 이동
        model.addAttribute("message", "매물이 성공적으로 등록되었습니다.");
 
        return "redirect:/product/list";
    } 
    
    @GetMapping("/list")
    public String listProducts(Model model) {
        List<ProductDTO> products = productService.selectAllProducts();
        model.addAttribute("products", products);
        return "product/list";
    }
    @GetMapping("/search")
    public String searchByConditions(Model model) {
    	List<ProductDTO> products = productService.searchByConditions();
    	model.addAttribute("products", products);
    	return "product/search";
    }
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") int product_id, Model model) {
        ProductDTO productDTO = productService.selectByIdService(product_id);
        System.out.println("조회된 매물 정보: " + productDTO); // 디버깅용
        model.addAttribute("productDTO", productDTO);
        return "product/edit";
    }

    @PostMapping("/edit/{id}")
    public String updateProduct(@PathVariable("id") int product_id, @ModelAttribute ProductDTO productDTO) {
        productDTO.setProduct_id(product_id);
        productService.updateProduct(productDTO);
        return "redirect:/product/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") int product_id) {
        productService.deleteProduct(product_id);
        return "redirect:/product/list";
    }
    @GetMapping("/detail/{id}")
    public String viewProduct(@PathVariable("id") int product_id, Model model) {
    	ProductDTO product = productService.selectByIdService(product_id);
    	model.addAttribute("product", product);
    	return "product/detail";
    }  
}
