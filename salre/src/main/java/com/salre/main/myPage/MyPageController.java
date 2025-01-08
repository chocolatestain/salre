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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.salre.main.login.UserDTO;
import com.salre.main.login.UserService;
import com.salre.main.myPage.ReviewDTO;

@Controller
public class MyPageController {

	@Autowired
	private UserService userService;
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	@GetMapping("/myPage")
	public String userInfo(HttpSession session, Model model) {	    
		return "myPage/myPage";	
	}
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
 
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½Ç°ï¿½ï¿½É¸Å¹ï¿½
	@GetMapping("/favorites")
	public String favorites() {
		return "myPage/favorites";
		}
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å·ï¿½ï¿½ï¿½È²
	@GetMapping("/transactions")
	public String transactions() {
		return "myPage/transactions";
	}

	//¸¶ÀÌÆäÀÌÁö - ³ªÀÇ °Å·¡ÇöÈ²(ÈÄ±âÀÛ¼º¹öÆ° Å¬¸¯½Ã)
			@PostMapping("/transactions/registerReview")
			@ResponseBody
			public Map<String, Object> updateReview(ReviewDTO review, HttpSession session) {
				
				 Map<String, Object> response = new HashMap<>();
				 
				 // ¼¼¼Ç¿¡¼­ UserDTO °´Ã¼ °¡Á®¿À±â
			    Object userObj = session.getAttribute("loggedInUser");
			        UserDTO user = (UserDTO) userObj;
			        int user_id = user.getUser_id(); // user_id ÃßÃâ
			        System.out.println("###userid" + user_id);

			    try {
			    	review.setUser_id(user_id);
			        userService.registerReview(review);
			        System.out.println("@@@@review @@@= " + review.getReview_content());
			        response.put("success", true);
			    } catch (Exception e) {
			        response.put("success", false);
			        response.put("message", "ÈÄ±â µî·Ï¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
			    }

			    return response;
			}
			
			
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Û¼ï¿½ï¿½ï¿½ ï¿½ï¿½.. ï¿½ï¿½ï¿? ï¿½ï¿½È¸
	@GetMapping("/posts")
	public String getMyPosts(HttpSession session, Model model) {
	    // ï¿½ï¿½ï¿½Ç¿ï¿½ï¿½ï¿½ UserDTO ï¿½ï¿½Ã¼ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id ï¿½ï¿½ï¿½ï¿½
	        System.out.println("Extracted user_id: " + user_id);

	        // Service È£ï¿½ï¿½ï¿½Ï¿ï¿½ ï¿½Ô½Ã±ï¿½ ï¿½ï¿½ï¿? ï¿½ï¿½È¸
	        List<PostDTO> postList = userService.getPostsByUserId(user_id);
	        System.out.println("postList: " + postList);
	        model.addAttribute("postList", postList);
	        return "myPage/posts"; // post.jsp ï¿½ï¿½È¯
	    } else {
	        // ï¿½ï¿½ï¿½Ç¿ï¿½ UserDTOï¿½ï¿½ ï¿½ï¿½ï¿½Å³ï¿½ ï¿½Î±ï¿½ï¿½Îµï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // ï¿½Î±ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½Ì·ï¿½Æ®
	    }
	}
 
	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å·ï¿½ï¿½Ä±ï¿½
	@GetMapping("/reviews") 
	public String getMyreviews(HttpSession session, Model model) {
		  // ï¿½ï¿½ï¿½Ç¿ï¿½ï¿½ï¿½ UserDTO ï¿½ï¿½Ã¼ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id ï¿½ï¿½ï¿½ï¿½
	        System.out.println("Extracted user_id: " + user_id);

	        // Service È£ï¿½ï¿½ï¿½Ï¿ï¿½ ï¿½Ô½Ã±ï¿½ ï¿½ï¿½ï¿? ï¿½ï¿½È¸
	        List<ReviewDTO> reviewList = userService.getMyreviewsByUserId(user_id);
	        System.out.println("reviewList: " + reviewList);
	        model.addAttribute("reviewList", reviewList);
	        return "myPage/reviews"; // reviews.jsp ï¿½ï¿½È¯
	    } else {
	        // ï¿½ï¿½ï¿½Ç¿ï¿½ UserDTOï¿½ï¿½ ï¿½ï¿½ï¿½Å³ï¿½ ï¿½Î±ï¿½ï¿½Îµï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿?
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // ï¿½Î±ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½Ì·ï¿½Æ®
	    }
	
	}

	
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å·ï¿½ï¿½Ä±ï¿½(ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Æ° Å¬ï¿½ï¿½ï¿½ï¿½)
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
	        response.put("message", "ÈÄ±â ¼öÁ¤¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
	    }

	    return response;
	}

	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å·ï¿½ï¿½Ä±ï¿½(ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Æ° Å¬ï¿½ï¿½ï¿½ï¿½)
		@PostMapping("/reviews/delete")
		@ResponseBody
		public Map<String, Object> deleteReview(@RequestParam int review_id){
			Map<String, Object> response = new HashMap<>();
			
			try {
				userService.deleteReview(review_id);
				response.put("success", true);
				response.put("message", "ÈÄ±â°¡ ¼º°øÀûÀ¸·Î »èÁ¦µÇ¾ú½À´Ï´Ù.");
				
			}catch(Exception e) {
				response.put("success", false);
				response.put("message", "ÈÄ±â »èÁ¦¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
			}
			return response;
		}

	
     //ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å°ï¿½ï¿½ï¿½ï¿½ï¿½
//		@GetMapping("/reports") 
//		public String reports(Model model) {
//		return "myPage/reports"; 
//		}
		  
	//ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å°ï¿½ï¿½ï¿½ï¿½ï¿½
		@GetMapping("/reports") 
		public String getMyreports(HttpSession session, Model model) {
			  // ï¿½ï¿½ï¿½Ç¿ï¿½ï¿½ï¿½ UserDTO ï¿½ï¿½Ã¼ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
		    Object userObj = session.getAttribute("loggedInUser");
		    
		    if (userObj instanceof UserDTO) {
		        UserDTO user = (UserDTO) userObj;
		        int user_id = user.getUser_id(); // user_id ï¿½ï¿½ï¿½ï¿½
		        System.out.println("Extracted user_id: " + user_id);

		        // Service È£ï¿½ï¿½ï¿½Ï¿ï¿½ ï¿½Ô½Ã±ï¿½ ï¿½ï¿½ï¿? ï¿½ï¿½È¸
		        List<ReportDTO> reportList = userService.getMyreportsByUserId(user_id);
		        System.out.println("reportList: " + reportList);
		        model.addAttribute("reportList", reportList);
		        return "myPage/reports"; // reports.jsp ï¿½ï¿½È¯
		    } else {
		        // ï¿½ï¿½ï¿½Ç¿ï¿½ UserDTOï¿½ï¿½ ï¿½ï¿½ï¿½Å³ï¿½ ï¿½Î±ï¿½ï¿½Îµï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿?
		        System.out.println("Session does not contain a valid UserDTO.");
		        return "redirect:/login"; // ï¿½Î±ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½Ì·ï¿½Æ®
		    }
		
		}
		 
	
	
		/*
		  //ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - ï¿½ï¿½ï¿½ï¿½ ï¿½Å°ï¿½ï¿½ï¿½ï¿½ï¿½(ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½)
		  
		  @GetMapping("/reports") public String reports(Model model) {
		  
		  @Autowired reportService reportservice;
		  
		  model.addAttribute("reportList",reportservice.getAllReports());
		  
		  return "myPage/reports"; }
		  
		*/
		 
		  

	
	

		
		
		
		
}
