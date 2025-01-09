package com.salre.main.product;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

    @PostMapping("/insert") // product/insert�뿉�꽌 �옉�꽦�븳 �궡�슜 post  
    public String createProduct(@ModelAttribute ProductDTO productDTO, MultipartHttpServletRequest request, Model model) {
 
 
        // MultipartHttpServletRequest瑜� �궗�슜�븯�뿬 �뙆�씪 泥섎━
        MultipartFile file = request.getFile("photo");  // 
        // �씪諛� �슂泥� �뙆�씪誘명꽣 泥섎━
        String sigungu = request.getParameter("sigungu"); 

        // sigungu 媛� 異쒕젰 (�뀒�뒪�듃�슜)
        System.out.println("�떆援곌뎄: " + sigungu);
        System.out.println(productDTO);
        productDTO.setRegion_id(regionService.selectIdByRegion(sigungu));

        if (file != null && !file.isEmpty()) {

            // �뙆�씪�쓣 ���옣�븷 �뵒�젆�넗由� 寃쎈줈 吏��젙
            String directoryPath = "src/main/resources/images/products/";

            // �떎�젣 寃쎈줈濡� 蹂��솚 (�꽌踰� �궡�뿉�꽌 �떎�젣 寃쎈줈瑜� �뼸湲� �쐞�븳 諛⑸쾿)
            String realPath = new File(directoryPath).getAbsolutePath();
            System.out.println(realPath);
            // �뵒�젆�넗由ш� �뾾�쑝硫� �깮�꽦
            File directory = new File(realPath);
            if (!directory.exists()) {
                directory.mkdirs(); // �뵒�젆�넗由� �깮�꽦
            }

            // �뙆�씪 寃쎈줈 �꽕�젙 (�뙆�씪紐낆� product_id瑜� 湲곕컲�쑝濡� �꽕�젙)
            File dest = new File(realPath + "/" + productService.nextId() + ".jpg");

            try {
                // �뙆�씪�쓣 �빐�떦 寃쎈줈濡� ���옣
                file.transferTo(dest);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 鍮꾩쫰�땲�뒪 濡쒖쭅 泥섎━ (�긽�뭹 �벑濡�)
        productService.insertProduct(productDTO);

        return "redirect:/";
    }
 
    // 紐⑤뱺 product return 
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

        // �븘�꽣 媛믪쓣 湲곕컲�쑝濡� 寃��깋 議곌굔 泥섎━
        ProductDTO filter = new ProductDTO();
        filter.setRegion_id(regionId != null && !regionId.isEmpty() ? Integer.parseInt(regionId) : null);
        filter.setPayment_type(paymentType);
        filter.setProduct_status(productStatus != null && !productStatus.isEmpty() ? Integer.parseInt(productStatus) : null);
        filter.setRoom_count(roomCount != null && !roomCount.isEmpty() ? Integer.parseInt(roomCount) : null);
        filter.setFloor(floor != null && !floor.isEmpty() ? Integer.parseInt(floor) : null);

        // �꽌鍮꾩뒪 �샇異�
        List<ProductDTO> searchResults = productService.searchByConditions(filter);
        model.addAttribute("searchResults", searchResults);

        return "product/search";
    }

 
    @GetMapping("/detail/{id}")
    public String viewProduct(@PathVariable("id") int product_id, Model model) {
    	ProductDTO product = productService.selectByIdService(product_id);
    	String status = "status-before";
    	String label = "嫄곕옒 �쟾";
    	switch (product.getProduct_status()) {
    	    case 0:
    	    	status = "status-pending";
    	    	label = "嫄곕옒 �쟾";
    	        break;
    	    case 1:
    	    	status = "status-in-progress";
    	    	label = "嫄곕옒 以�";
    	        break;
    	    case 2:
    	    	status = "status-completed";
    	    	label = "嫄곕옒 �셿猷�";
    	    	break; 
    	    case 3:
    	    	status ="status-unknown";
    	    	label = "�삤瑜�";
    	} 
    	model.addAttribute("status", status);
    	model.addAttribute("product", product);
    	model.addAttribute("label", label);
    	productService.incrementViewCount(product_id);
    	return "product/detail";
    }  
    @GetMapping("")
    public String searchProducts(@RequestParam("search") String searchQuery, Model model) {
        // 寃��깋�뼱媛� 鍮꾩뼱�엳�쓣 �븣 �삁�쇅 泥섎━
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            model.addAttribute("message", "寃��깋�뼱瑜� �엯�젰�빐二쇱꽭�슂.");
            return "/product/search";
        }

        log.info("寃��깋�뼱: {}", searchQuery);  // 濡쒓렇濡� 寃��깋�뼱 �솗�씤

        // ProductService�뿉�꽌 寃��깋 寃곌낵 媛��졇�삤湲�
        List<ProductDTO> searchResults = productService.searchProducts(searchQuery);

        // 寃��깋 寃곌낵媛� �뾾�쓣 寃쎌슦
        if (searchResults == null || searchResults.isEmpty()) {
            model.addAttribute("message", "寃��깋 寃곌낵媛� �뾾�뒿�땲�떎.");
        } else {
            model.addAttribute("searchResults", searchResults);
      
        }

        return "product/search";
    }
}
