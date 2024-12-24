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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
 
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;
    
    @GetMapping("/insert")
    public String showCreateForm(Model model) {
        model.addAttribute("productDTO", new ProductDTO());
        return "product/insert";
    }

    @PostMapping("/insert")
    public String createProduct(@ModelAttribute ProductDTO productDTO) {
        productService.insertProduct(productDTO);
        return "redirect:/product/list";
    }
    
    @GetMapping("/list")
    public String listProducts(Model model) {
        List<ProductDTO> products = productService.selectAllProducts();
        model.addAttribute("products", products);
        return "product/list";
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
    


}
