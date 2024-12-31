package com.salre.main.contract;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.salre.main.product.ProductContractDTO;
import com.salre.main.product.ProductService;
import com.salre.main.user.UserService;

@Controller
@RequestMapping("/contract")
public class ContractController {
	@Autowired
	public ContractService contractService;
	public UserService userService;
	public ProductService productService;

	@GetMapping("/plus.do")
	public String testGet() {
		return "contract/contractDetail";
	}

	// 계약 ID로 조회
	@GetMapping("/list/{contract_id}")
	public String getContractById(@PathVariable int contract_id, Model model) {
		// ContractDTO contract = contractService.getContractById(contract_id);
		ProductContractDTO contractP = contractService.getContractPById(contract_id);
		// ContractDTO user_id = contractService.getSellerById(contract_id);
		// System.out.println(user_id);
		// int product_id = contractService.getProductById(contract_id);
		// UserDTO user = userService.getUserById(user_id);
		// ProductDTO product = productService.selectByIdService(product_id);
		model.addAttribute("contractP", contractP);
		// model.addAttribute("user", user);
		// model.addAttribute("product", product);
		return "contract/contractDetail";
	}

	// 계약 ID로 모든(판매자,매물)조회
	@GetMapping("/listAll/{contract_id}")
	public String getContractAllById(@PathVariable int contract_id, Model model) {
		ContractUserDTO contractAll = contractService.getContractAllById(contract_id);
		model.addAttribute("contractAll", contractAll);
		return "contract/contractPlus";
	}

	// 계약 생성
	@PostMapping
	public ResponseEntity<String> createContract(@RequestBody ContractDTO contract) {
		contractService.createContract(contract);
		return ResponseEntity.ok("Contract created successfully.");
	}

	@PostMapping("/submitContract")
	public String submitContract(@RequestParam String payment_type, @RequestParam String address,
			@RequestParam String deposit_CHAR) {
		try {
			// 서비스 계층 호출
			Map<String, String> contractData = contractService.getContractData(payment_type, address, deposit_CHAR);

			// ExcelWriter 호출
			ExcelWriter excelWriter = new ExcelWriter();
			String filePath = "src/main/webapp/excel/contractPaper_NEW.xlsx";
			excelWriter.writeContractData(filePath, contractData);

			return "엑셀 저장 성공!";
		} catch (Exception e) {
			e.printStackTrace();
			return "엑셀 저장 실패: " + e.getMessage();
		}

	}
	@GetMapping("/viewContract/{contract_id}")
	public String viewContract(@PathVariable(required = true) Integer contract_id, 
			Model model, HttpSession session) {
	     try {
	            // 서비스 계층 호출
	    	    String imagePath = session.getServletContext().getRealPath(".");
	            String upload_imagePath = contractService.processContract(contract_id,imagePath);

	            // 이미지 경로를 JSP에 전달
	            model.addAttribute("imagePath", upload_imagePath);
	            return "contract/viewContract"; // 계약서 이미지를 보여주는 JSP
	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("errorMessage", "계약서 처리 중 오류 발생: " + e.getMessage());
	            return "error";
	        }
	}
	

//    // 계약 수정
//    @PutMapping("/{contract_id}")
//    public ResponseEntity<String> updateContract(@RequestBody ContractDTO contract) {
//        contractService.updateContract(contract);
//        return ResponseEntity.ok("Contract updated successfully.");
//    }
//
//    // 계약 삭제
//    @DeleteMapping("/{contract_id}")
//    public ResponseEntity<String> deleteContract(@PathVariable int contract_id,  @RequestBody ContractDTO contract) {
//        contractService.deleteContract(contract_id);
//        return ResponseEntity.ok("Contract deleted successfully.");
//    }

}
