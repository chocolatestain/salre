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
import com.salre.main.product.ProductDTO;
import com.salre.main.product.ProductService;
@Controller
public class MyPageController {

	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕
	@GetMapping("/myPage")
	public String userInfo(HttpSession session, Model model) {	    
		return "myPage/myPage";	
	}
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕
 
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�떎怨ㅼ삕�뜝�떖留ㅻ콈�삕  
	/*@GetMapping("/favorites") public String favorites() { return
	  "myPage/favorites";
	    }*/
	
		
	//마이페이지 - 나의 관심매물
	 @GetMapping("/favorites")
	 public String getFavoriteItems(Model model, HttpSession session) {
	        UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
	        if (user == null) {
	            return "redirect:/login"; // 로그인 페이지로 리다이렉트
	        }
	        
	        int user_id = user.getUser_id();
	        List<ProductDTO> favoritesList = userService.getFavoritesByUserId(user_id);
	        model.addAttribute("favoritesList", favoritesList);
	        return "myPage/favorites"; // JSP 파일 경로
	    }
	

	
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊琉꾩삕�뜝�룞�삕�솴
	/*
	 * @GetMapping("/transactions") public String transactions() { return
	 * "myPage/transactions"; }
	 */
	@GetMapping("/transactions") 
	public String transactions(HttpSession session, Model model) {
	   Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id �뜝�룞�삕�뜝�룞�삕
	        System.out.println("Extracted user_id: " + user_id);

	        
	        // Service �샇�뜝�룞�삕�뜝�떦�슱�삕 �뜝�뙃�떆源띿삕 �뜝�룞�삕�뜝? �뜝�룞�삕�쉶
	        List<ProductDTO> buyerProductList = userService.getBuyerTransactionByUserId(user_id);
	        System.out.println("@#$buyerProductList: " + buyerProductList);
	        model.addAttribute("buyerProductList", buyerProductList);
	        List<ProductDTO> productList = userService.getTransactionByUserId(user_id);
//	        System.out.println("productList: " + productList);
	        model.addAttribute("productList", productList);
	       
	        return "myPage/transactions"; // reports.jsp �뜝�룞�삕�솚
	    } else {
	        // �뜝�룞�삕�뜝�떎�슱�삕 UserDTO�뜝�룞�삕 �뜝�룞�삕�뜝�떊�냲�삕 �뜝�떥源띿삕�뜝�떥�벝�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // �뜝�떥源띿삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�떛琉꾩삕�듃
	    }
	}
	
	
	@PostMapping("/transactions/registerReview")
	@ResponseBody
	public Map<String, Object> updateReview(@RequestBody ReviewDTO review, 
	                                        @RequestParam int product_id, 
	                                        HttpSession session) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        // �꽭�뀡�뿉�꽌 UserDTO 媛앹껜 媛��졇�삤湲�
	        Object userObj = session.getAttribute("loggedInUser");
	        if (userObj == null) {
	            throw new IllegalArgumentException("濡쒓렇�씤 �젙蹂닿� �뾾�뒿�땲�떎.");
	        }

	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 異붿텧
	        System.out.println("### user_id: " + user_id);

	        // ProductDTO瑜� �넻�빐 seller_id 媛��졇�삤湲�
	        ProductDTO product = productService.selectByIdService(product_id);
	        if (product == null) {
	            throw new IllegalArgumentException("�쑀�슚�븯吏� �븡�� product_id�엯�땲�떎.");
	        }
	        System.out.println(product_id);
	        int seller_id = product.getUser_id();
	        	
	        // ReviewDTO�뿉 user_id�� seller_id �꽕�젙
	        review.setUser_id(user_id);
	        review.setSeller_id(seller_id);

	        // �썑湲곕�� �벑濡�
	        userService.registerReview(review);

	        response.put("success", true);
	    } catch (IllegalArgumentException e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "�썑湲� �벑濡� 以� �븣 �닔 �뾾�뒗 �삤瑜섍� 諛쒖깮�뻽�뒿�땲�떎.");
	        e.printStackTrace();
	    }

	    return response;
	}

			
			
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�뙗�눦�삕�뜝�룞�삕 �뜝�룞�삕.. �뜝�룞�삕�뜝? �뜝�룞�삕�쉶
	@GetMapping("/posts")
	public String getMyPosts(HttpSession session, Model model) {
	    // �뜝�룞�삕�뜝�떎�슱�삕�뜝�룞�삕 UserDTO �뜝�룞�삕泥� �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id �뜝�룞�삕�뜝�룞�삕
	        System.out.println("Extracted user_id: " + user_id);

	        // Service �샇�뜝�룞�삕�뜝�떦�슱�삕 �뜝�뙃�떆源띿삕 �뜝�룞�삕�뜝? �뜝�룞�삕�쉶
	        List<PostDTO> postList = userService.getPostsByUserId(user_id);
	        System.out.println("postList: " + postList);
	        model.addAttribute("postList", postList);
	        return "myPage/posts"; // post.jsp �뜝�룞�삕�솚
	    } else {
	        // �뜝�룞�삕�뜝�떎�슱�삕 UserDTO�뜝�룞�삕 �뜝�룞�삕�뜝�떊�냲�삕 �뜝�떥源띿삕�뜝�떥�벝�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // �뜝�떥源띿삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�떛琉꾩삕�듃
	    }
	}
 
	
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊琉꾩삕�뜝�떇源띿삕
	@GetMapping("/reviews") 
	public String getMyreviews(HttpSession session, Model model) {
		  // �뜝�룞�삕�뜝�떎�슱�삕�뜝�룞�삕 UserDTO �뜝�룞�삕泥� �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id �뜝�룞�삕�뜝�룞�삕
	        System.out.println("Extracted user_id: " + user_id);

	        // Service �샇�뜝�룞�삕�뜝�떦�슱�삕 �뜝�뙃�떆源띿삕 �뜝�룞�삕�뜝? �뜝�룞�삕�쉶
	        List<ReviewDTO> reviewList = userService.getMyreviewsByUserId(user_id);
	        System.out.println("reviewList: " + reviewList);
	        model.addAttribute("reviewList", reviewList);
	        return "myPage/reviews"; // reviews.jsp �뜝�룞�삕�솚
	    } else {
	        // �뜝�룞�삕�뜝�떎�슱�삕 UserDTO�뜝�룞�삕 �뜝�룞�삕�뜝�떊�냲�삕 �뜝�떥源띿삕�뜝�떥�벝�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // �뜝�떥源띿삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�떛琉꾩삕�듃
	    }
	
	}

	
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊琉꾩삕�뜝�떇源띿삕(�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�듉 �겢�뜝�룞�삕�뜝�룞�삕)
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
	        response.put("message", "�썑湲� �닔�젙�뿉 �떎�뙣�뻽�뒿�땲�떎.");
	    }

	    return response;
	}

	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊琉꾩삕�뜝�떇源띿삕(�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�듉 �겢�뜝�룞�삕�뜝�룞�삕)
		@PostMapping("/reviews/delete")
		@ResponseBody
		public Map<String, Object> deleteReview(@RequestParam int review_id){
			Map<String, Object> response = new HashMap<>();
			
			try {
				userService.deleteReview(review_id);
				response.put("success", true);
				response.put("message", "�썑湲곌� �꽦怨듭쟻�쑝濡� �궘�젣�릺�뿀�뒿�땲�떎.");
				
			}catch(Exception e) {
				response.put("success", false);
				response.put("message", "�썑湲� �궘�젣�뿉 �떎�뙣�뻽�뒿�땲�떎.");
			}
			return response;
		}

	
     //�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊怨ㅼ삕�뜝�룞�삕�뜝�룞�삕
//		@GetMapping("/reports") 
//		public String reports(Model model) {
//		return "myPage/reports"; 
//		}
		  
	//�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊怨ㅼ삕�뜝�룞�삕�뜝�룞�삕
		@GetMapping("/reports") 
		public String getMyreports(HttpSession session, Model model) {
			  // �뜝�룞�삕�뜝�떎�슱�삕�뜝�룞�삕 UserDTO �뜝�룞�삕泥� �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕
		    Object userObj = session.getAttribute("loggedInUser");
		    
		    if (userObj instanceof UserDTO) {
		        UserDTO user = (UserDTO) userObj;
		        int user_id = user.getUser_id(); // user_id �뜝�룞�삕�뜝�룞�삕
		        System.out.println("Extracted user_id: " + user_id);

		        // Service �샇�뜝�룞�삕�뜝�떦�슱�삕 �뜝�뙃�떆源띿삕 �뜝�룞�삕�뜝? �뜝�룞�삕�쉶
		        List<ReportDTO> reportList = userService.getMyreportsByUserId(user_id);
		        System.out.println("reportList: " + reportList);
		        model.addAttribute("reportList", reportList);
		        return "myPage/reports"; // reports.jsp �뜝�룞�삕�솚
		    } else {
		        // �뜝�룞�삕�뜝�떎�슱�삕 UserDTO�뜝�룞�삕 �뜝�룞�삕�뜝�떊�냲�삕 �뜝�떥源띿삕�뜝�떥�벝�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝?
		        System.out.println("Session does not contain a valid UserDTO.");
		        return "redirect:/login"; // �뜝�떥源띿삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕�뜝�떛琉꾩삕�듃
		    }
		
		}
		 
	
	
		/*
		  //�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕 - �뜝�룞�삕�뜝�룞�삕 �뜝�떊怨ㅼ삕�뜝�룞�삕�뜝�룞�삕(�뜝�룞�삕�뜝�룞�삕�뜝�룞�삕)
		  
		  @GetMapping("/reports") public String reports(Model model) {
		  
		  @Autowired reportService reportservice;
		  
		  model.addAttribute("reportList",reportservice.getAllReports());
		  
		  return "myPage/reports"; }
		  
		*/
		 
		  

	
	

		
		
		
		
}
