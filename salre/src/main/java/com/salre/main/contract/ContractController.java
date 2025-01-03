package com.salre.main.contract;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.salre.main.product.ProductDTO;
import com.salre.main.product.ProductService;
import com.salre.main.user.UserDTO;
import com.salre.main.user.UserService;

@Controller
@RequestMapping("/contract")
public class ContractController {
	@Autowired
	public ContractService contractService;
	@Autowired
	public UserService userService;
	@Autowired
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

	// 1.거래 시작 누리고 첫화면  "정보확인"(매물,회원정보 조회)
	@GetMapping("/dealstart")
	public String beforeContract(HttpServletRequest request,Model model) {
		//int p_id = (int)request.getAttribute("product_id");
		//int user_id = (int)request.getAttribute("user_id");
		int p_id = 34;
		int user_id = 12;
		ProductDTO product = productService.selectByIdService(p_id);
		UserDTO user = userService.getUserById(user_id);
		model.addAttribute("product", product);
		model.addAttribute("user", user);
		return "contract/contractDetail";
	}
	
	// 2.계약정보 입력
		@GetMapping("/inputContract") 
		public String selectAllContractById(HttpServletRequest request, Model model) {
			// HttpSession session = request.getSession();
			// Integer user_id = (Integer) session.getAttribute("user_id");
		//	ContractDTO contract = contractService.getContractById(contract_id);
			
			int user_id = 12;
			int p_id = 34;
			ProductDTO product = productService.selectByIdService(p_id);
			UserDTO user = userService.getUserById(user_id);
			
			//model.addAttribute("contract", contract);
			model.addAttribute("product", product);
			model.addAttribute("user", user);
			
			return "contract/contractInput";
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
		//3. 계약서 저장 
	     @PostMapping("/save") //입력받은 계약내용, 특약내용 저장
	     public String saveContract(ContractDTO contractDTO, Model model) {
	    	 contractDTO.setUser_id(12); //임시
	    	 contractDTO.setProduct_id(34); //임시
	 
	    	 if(contractDTO.getBalance_payment_day().equals("")) {
	    		 contractDTO.setBalance_payment_day("1900-01-01");
	    	 } 
	    	 // 계약 저장후 계약번호 반환
	         int contractId = contractService.saveContract(contractDTO);
	         // 저장된 계약 정보를 조회하는 페이지로 리다이렉트
	         return "redirect:/contract/contractTotal?contract_id=" + contractId; 
	     }
	     //4.계약서 최종확인
	     @GetMapping("/contractTotal")
	     public String showContractTotal(@RequestParam("contract_id") int contract_id, Model model) {
			ContractDTO contract = contractService.getContractById(contract_id);
			UserDTO user = userService.getUserById(contract.getUser_id());
			ProductDTO product = productService.selectByIdService(contract.getProduct_id());
			
			
			 model.addAttribute("contract", contract);
			    model.addAttribute("user", user);
			    model.addAttribute("product", product);
			    System.out.println("contract_id 받음: " + contract_id);
	    	 return "contract/contractTotal";
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
