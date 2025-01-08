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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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

    @PostMapping("/insert") // product/insert에서 작성한 내용 post  
    public String createProduct(@ModelAttribute ProductDTO productDTO, MultipartHttpServletRequest request, Model model) {
 
 
        // MultipartHttpServletRequest를 사용하여 파일 처리
        MultipartFile file = request.getFile("photo");  // 
        // 일반 요청 파라미터 처리
        String sigungu = request.getParameter("sigungu"); 

        // sigungu 값 출력 (테스트용)
        System.out.println("시군구: " + sigungu);
        System.out.println(productDTO);
        productDTO.setRegion_id(regionService.selectIdByRegion(sigungu));

        if (file != null && !file.isEmpty()) {

            // 파일을 저장할 디렉토리 경로 지정
            String directoryPath = "src/main/resources/images/products/";

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
 
    // 모든 product return 
    @GetMapping("/list")
    public String listProducts(Model model) {
        List<ProductDTO> products = productService.selectAllProducts();
        model.addAttribute("products", products);
        return "product/list";
    }
     
    @GetMapping("/search/filter")
    public String searchByFilters(
        @RequestParam(value = "region_id", required = false) String regionId,
        @RequestParam(value = "payment_type", required = false) String paymentType,
        @RequestParam(value = "product_status", required = false) String productStatus,
        @RequestParam(value = "room_count", required = false) String roomCount,
        @RequestParam(value = "floor", required = false) String floor,
        Model model
    ) {

        // 필터 값을 기반으로 검색 조건 처리
        ProductDTO filter = new ProductDTO();
        filter.setRegion_id(regionId != null && !regionId.isEmpty() ? Integer.parseInt(regionId) : null);
        filter.setPayment_type(paymentType);
        filter.setProduct_status(productStatus != null && !productStatus.isEmpty() ? Integer.parseInt(productStatus) : null);
        filter.setRoom_count(roomCount != null && !roomCount.isEmpty() ? Integer.parseInt(roomCount) : null);
        filter.setFloor(floor != null && !floor.isEmpty() ? Integer.parseInt(floor) : null);

        // 서비스 호출
        List<ProductDTO> searchResults = productService.searchByConditions(filter);
        model.addAttribute("searchResults", searchResults);

        return "product/search";
    }

 
    @GetMapping("/detail/{id}")
    public String viewProduct(@PathVariable("id") int product_id, Model model) {
    	ProductDTO product = productService.selectByIdService(product_id);
    	String status = "status-before";
    	String label = "거래 전";
    	switch (product.getProduct_status()) {
    	    case 0:
    	    	status = "status-pending";
    	    	label = "거래 전";
    	        break;
    	    case 1:
    	    	status = "status-in-progress";
    	    	label = "거래 중";
    	        break;
    	    case 2:
    	    	status = "status-completed";
    	    	label = "거래 완료";
    	    	break; 
    	    case 3:
    	    	status ="status-unknown";
    	    	label = "오류";
    	} 
    	model.addAttribute("status", status);
    	model.addAttribute("product", product);
    	model.addAttribute("label", label);
    	productService.incrementViewCount(product_id);
    	return "product/detail";
    }  
    @GetMapping("")
    public String searchProducts(@RequestParam("search") String searchQuery, Model model) {
        // 검색어가 비어있을 때 예외 처리
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            model.addAttribute("message", "검색어를 입력해주세요.");
            return "/product/search";
        }

        log.info("검색어: {}", searchQuery);  // 로그로 검색어 확인

        // ProductService에서 검색 결과 가져오기
        List<ProductDTO> searchResults = productService.searchProducts(searchQuery);

        // 검색 결과가 없을 경우
        if (searchResults == null || searchResults.isEmpty()) {
            model.addAttribute("message", "검색 결과가 없습니다.");
        } else {
            model.addAttribute("searchResults", searchResults);
      
        }

        return "product/search";
    }
}
