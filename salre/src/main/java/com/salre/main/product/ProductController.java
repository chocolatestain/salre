package com.salre.main.product;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private RegionService regionService;

    @GetMapping("/insert")
    public String showCreateForm() {
        return "product/insert";
    }

    @PostMapping("/insert")
    public String createProduct(@ModelAttribute ProductDTO productDTO, MultipartHttpServletRequest request,
            Model model) {

        // MultipartHttpServletRequest를 사용하여 파일 처리
        MultipartFile file = request.getFile("photo"); // "photo"는 HTML input의 name 값과 일치해야 함
        // 일반 요청 파라미터 처리
        String sigungu = request.getParameter("sigungu"); // "sigungu"는 HTML에서 지정한 name 값과 일치해야 함

        // sigungu 값 출력 (테스트용)
        System.out.println("시군구: " + sigungu);
        System.out.println(productDTO);
        productDTO.setRegion_id(regionService.selectIdByRegion(sigungu));

        if (file != null && !file.isEmpty()) {

            // 파일을 저장할 디렉토리 경로 지정
            String directoryPath = "src/main/resources/static/images/products/";

            // 실제 경로로 변환 (서버 내에서 실제 경로를 얻기 위한 방법)
            String realPath = new File(directoryPath).getAbsolutePath();
            System.out.println(realPath);
            // 디렉토리가 없으면 생성
            File directory = new File(realPath);
            if (!directory.exists()) {
                directory.mkdirs(); // 디렉토리 생성
            }

            // 파일 경로 설정 (파일명은 product_id를 기반으로 설정)
            File dest = new File(realPath + "/" + productService.nextId() + ".jpg");

            try {
                // 파일을 해당 경로로 저장
                file.transferTo(dest);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 비즈니스 로직 처리 (상품 등록)
        productService.insertProduct(productDTO);

        return "redirect:/";
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
