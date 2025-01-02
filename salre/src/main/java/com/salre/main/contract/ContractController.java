package com.salre.main.contract;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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

	@GetMapping("/input")
	public String showContractInputPage(@RequestParam(value = "contract_id",required=false,defaultValue="0") Integer contract_id,
	        Model model) {
		if (contract_id == 0) {
	        model.addAttribute("errorMessage", "계약번호가 제공되지 않았습니다.");
	        return "errorPage"; // 에러 페이지로 이동
	    }
		
		ProductContractDTO contract = contractService.getContractPById(contract_id);
	    // 데이터를 모델에 추가
	    model.addAttribute("contract", contract);
	    return "contract/contractInput"; // contractInput.jsp로 이동
	}
	@PostMapping("/input")
	public ResponseEntity<String> handleInputData(@RequestParam("contract_id") Integer contract_id, Model model) {
	    // 데이터 처리 (필요시 contractId를 기반으로 데이터 조회/저장)
	    System.out.println("Contract ID received: " + contract_id);

	    // 요청 성공 응답
	    return ResponseEntity.ok("Success");
	}

	// 계약 ID로 조회
	@GetMapping("/list/{contract_id}")
	public String getContractById(@PathVariable int contract_id, Model model) {
		ProductContractDTO contractP = contractService.getContractPById(contract_id);
		model.addAttribute("contractP", contractP);
		return "contract/contractDetail";
	}


//	
	@PostMapping("/viewContract/{contract_id}")
	public String viewContract(@PathVariable(required = true) Integer contract_id, 
			@RequestParam Map<String,String> formData,
			Model model, HttpSession session) {
	     try {
	            // 서비스 계층 호출
	    	    String imagePath = session.getServletContext().getRealPath(".");
	            String upload_imagePath = contractService.processContract(formData,contract_id,imagePath);

	            // 이미지 경로를 JSP에 전달
	            model.addAttribute("imagePath", upload_imagePath);
	            return "contract/viewContract"; // 계약서 이미지를 보여주는 JSP
	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("errorMessage", "계약서 처리 중 오류 발생: " + e.getMessage());
	            return "error";
	        }
	}
	     @PostMapping("/save") //입력받은 계약내용, 특약내용 저장
	     public String saveContract(ProductContractDTO contractDTO) {
	         contractService.saveContract(contractDTO);
	         return "redirect:/contract/success"; // 저장 완료 후 성공 페이지로 리다이렉트
	     }
	     
	     

	
	
//			@PostMapping("/submitContract")
//	public String submitContract(@RequestParam String payment_type, @RequestParam String address,
//			@RequestParam String deposit_CHAR) {
//		try {
//			// 서비스 계층 호출
//			Map<String, String> contractData = contractService.getContractData(payment_type, address, deposit_CHAR);
//
//			// ExcelWriter 호출
//			ExcelWriter excelWriter = new ExcelWriter();
//			String filePath = "src/main/webapp/excel/contractPaper_NEW.xlsx";
//			excelWriter.writeContractData(filePath, contractData);
//
//			return "엑셀 저장 성공!";
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "엑셀 저장 실패: " + e.getMessage();
//		}
//
//	}
}
