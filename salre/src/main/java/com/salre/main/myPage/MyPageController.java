package com.salre.main.myPage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salre.main.login.UserDTO;
import com.salre.main.login.UserService;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.*;
@Controller
public class MyPageController {

	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙占쏙옙占쏙옙
	@GetMapping("/myPage")
	public String userInfo(HttpSession session, Model model) {	    
		return "myPage/myPage";	
	}
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙占쏙옙占쏙옙
 
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占실곤옙占심매뱄옙
	@GetMapping("/favorites")
	public String favorites() {
		return "myPage/favorites";
		}
	
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신뤄옙占쏙옙황
	@GetMapping("/transactions")
	public String transactions() {
		return "myPage/transactions";
	}

	@PostMapping("/transactions/registerReview")
	@ResponseBody
	public Map<String, Object> updateReview(@RequestBody ReviewDTO review, 
	                                        @RequestParam int product_id, 
	                                        HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        // 세션에서 UserDTO 객체 가져오기
	        Object userObj = session.getAttribute("loggedInUser");
	        if (userObj == null) {
	            throw new IllegalArgumentException("로그인 정보가 없습니다.");
	        }

	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 추출
	        System.out.println("### user_id: " + user_id);

	        // ProductDTO를 통해 seller_id 가져오기
	        ProductDTO product = productService.selectByIdService(product_id);
	        if (product == null) {
	            throw new IllegalArgumentException("유효하지 않은 product_id입니다.");
	        }
	        System.out.println(product_id);
	        int seller_id = product.getUser_id();
	        	
	        // ReviewDTO에 user_id와 seller_id 설정
	        review.setUser_id(user_id);
	        review.setSeller_id(seller_id);

	        // 후기를 등록
	        userService.registerReview(review);

	        response.put("success", true);
	    } catch (IllegalArgumentException e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "후기 등록 중 알 수 없는 오류가 발생했습니다.");
	        e.printStackTrace();
	    }

	    return response;
	}

			
			
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占쌜쇽옙占쏙옙 占쏙옙.. 占쏙옙占? 占쏙옙회
	@GetMapping("/posts")
	public String getMyPosts(HttpSession session, Model model) {
	    // 占쏙옙占실울옙占쏙옙 UserDTO 占쏙옙체 占쏙옙占쏙옙占쏙옙占쏙옙
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 占쏙옙占쏙옙
	        System.out.println("Extracted user_id: " + user_id);

	        // Service 호占쏙옙占싹울옙 占쌉시깍옙 占쏙옙占? 占쏙옙회
	        List<PostDTO> postList = userService.getPostsByUserId(user_id);
	        System.out.println("postList: " + postList);
	        model.addAttribute("postList", postList);
	        return "myPage/posts"; // post.jsp 占쏙옙환
	    } else {
	        // 占쏙옙占실울옙 UserDTO占쏙옙 占쏙옙占신놂옙 占싸깍옙占싸듸옙占쏙옙 占쏙옙占쏙옙 占쏙옙占?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // 占싸깍옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占싱뤄옙트
	    }
	}
 
	
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신뤄옙占식깍옙
	@GetMapping("/reviews") 
	public String getMyreviews(HttpSession session, Model model) {
		  // 占쏙옙占실울옙占쏙옙 UserDTO 占쏙옙체 占쏙옙占쏙옙占쏙옙占쏙옙
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 占쏙옙占쏙옙
	        System.out.println("Extracted user_id: " + user_id);

	        // Service 호占쏙옙占싹울옙 占쌉시깍옙 占쏙옙占? 占쏙옙회
	        List<ReviewDTO> reviewList = userService.getMyreviewsByUserId(user_id);
	        System.out.println("reviewList: " + reviewList);
	        model.addAttribute("reviewList", reviewList);
	        return "myPage/reviews"; // reviews.jsp 占쏙옙환
	    } else {
	        // 占쏙옙占실울옙 UserDTO占쏙옙 占쏙옙占신놂옙 占싸깍옙占싸듸옙占쏙옙 占쏙옙占쏙옙 占쏙옙占?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // 占싸깍옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占싱뤄옙트
	    }
	
	}

	
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신뤄옙占식깍옙(占쏙옙占쏙옙占쏙옙튼 클占쏙옙占쏙옙)
	@PostMapping("/reviews/update")
	@ResponseBody
	public Map<String, Object> updateReview(@RequestParam int review_id,
	                                        @RequestParam int review_rate,
	                                        @RequestParam String review_content) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        userService.updateReview(review_id, review_rate, review_content);
	        response.put("success", true);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "후기 수정에 실패했습니다.");
	    }

	    return response;
	}

	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신뤄옙占식깍옙(占쏙옙占쏙옙占쏙옙튼 클占쏙옙占쏙옙)
		@PostMapping("/reviews/delete")
		@ResponseBody
		public Map<String, Object> deleteReview(@RequestParam int review_id){
			Map<String, Object> response = new HashMap<>();
			
			try {
				userService.deleteReview(review_id);
				response.put("success", true);
				response.put("message", "후기가 성공적으로 삭제되었습니다.");
				
			}catch(Exception e) {
				response.put("success", false);
				response.put("message", "후기 삭제에 실패했습니다.");
			}
			return response;
		}

	
     //占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙
//		@GetMapping("/reports") 
//		public String reports(Model model) {
//		return "myPage/reports"; 
//		}
		  
	//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙
		@GetMapping("/reports") 
		public String getMyreports(HttpSession session, Model model) {
			  // 占쏙옙占실울옙占쏙옙 UserDTO 占쏙옙체 占쏙옙占쏙옙占쏙옙占쏙옙
		    Object userObj = session.getAttribute("loggedInUser");
		    
		    if (userObj instanceof UserDTO) {
		        UserDTO user = (UserDTO) userObj;
		        int user_id = user.getUser_id(); // user_id 占쏙옙占쏙옙
		        System.out.println("Extracted user_id: " + user_id);

		        // Service 호占쏙옙占싹울옙 占쌉시깍옙 占쏙옙占? 占쏙옙회
		        List<ReportDTO> reportList = userService.getMyreportsByUserId(user_id);
		        System.out.println("reportList: " + reportList);
		        model.addAttribute("reportList", reportList);
		        return "myPage/reports"; // reports.jsp 占쏙옙환
		    } else {
		        // 占쏙옙占실울옙 UserDTO占쏙옙 占쏙옙占신놂옙 占싸깍옙占싸듸옙占쏙옙 占쏙옙占쏙옙 占쏙옙占?
		        System.out.println("Session does not contain a valid UserDTO.");
		        return "redirect:/login"; // 占싸깍옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占싱뤄옙트
		    }
		
		}
		 
	
	
		/*
		  //占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙(占쏙옙占쏙옙占쏙옙)
		  
		  @GetMapping("/reports") public String reports(Model model) {
		  
		  @Autowired reportService reportservice;
		  
		  model.addAttribute("reportList",reportservice.getAllReports());
		  
		  return "myPage/reports"; }
		  
		*/
		 
		  

	
	

		
		
		
		
}
