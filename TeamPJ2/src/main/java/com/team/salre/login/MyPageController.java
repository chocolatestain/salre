package com.team.salre.login;

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

@Controller
public class MyPageController {

	@Autowired
	private UserService userService;
	
	//마이페이지 - 나의정보
	@GetMapping("/myPage")
	public String userInfo(HttpSession session, Model model) {	    
		return "myPage/myPage";	
	}
	//마이페이지 - 나의정보
	@ResponseBody
	@PostMapping("/myPage/myPage")  // ???강사님 ajax
	public String userInfoPost(HttpSession session, Model model, UserDTO user) {
		System.out.println(user);
		//userService.update(user);
		session.setAttribute("loggedInUser", user);
		
		return "mmmm";//@ResponseBody
		
	}
	
	//마이페이지 - 나의관심매물
	@GetMapping("/favorites")
	public String favorites() {
		return "myPage/favorites";
		}
	
	//마이페이지 - 나의 거래현황
	@GetMapping("/transactions")
	public String transactions() {
		return "myPage/transactions";
	}

	
	/*
	//마이페이지 - 내가 작성한 글
	@GetMapping("/posts") 
	public String posts() {
		return "myPage/posts";
	}
	*/
	//마이페이지 - 내가 작성한 글.. 목록 조회
	@GetMapping("/posts")
	public String getMyPosts(HttpSession session, Model model) {
	    // 세션에서 UserDTO 객체 가져오기
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 추출
	        System.out.println("Extracted user_id: " + user_id);

	        // Service 호출하여 게시글 목록 조회
	        List<PostDTO> postList = userService.getPostsByUserId(user_id);
	        System.out.println("postList: " + postList);
	        model.addAttribute("postList", postList);
	        return "myPage/posts"; // post.jsp 반환
	    } else {
	        // 세션에 UserDTO가 없거나 로그인되지 않은 경우
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // 로그인 페이지로 리다이렉트
	    }
	}
	
	/*
	//마이페이지 - 나의 거래후기
	@GetMapping("/reviews") 
	public String reviews() {
		return "myPage/reviews";
	}
	*/
	
	//마이페이지 - 나의 거래후기
	@GetMapping("/reviews") 
	public String getMyreviews(HttpSession session, Model model) {
		  // 세션에서 UserDTO 객체 가져오기
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id 추출
	        System.out.println("Extracted user_id: " + user_id);

	        // Service 호출하여 게시글 목록 조회
	        List<ReviewDTO> reviewList = userService.getMyreviewsByUserId(user_id);
	        System.out.println("reviewList: " + reviewList);
	        model.addAttribute("reviewList", reviewList);
	        return "myPage/reviews"; // reviews.jsp 반환
	    } else {
	        // 세션에 UserDTO가 없거나 로그인되지 않은 경우
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // 로그인 페이지로 리다이렉트
	    }
	
	}

	
	//마이페이지 - 나의 거래후기(수정버튼 클릭시)
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

	//마이페이지 - 나의 거래후기(삭제버튼 클릭시)
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

	
     //마이페이지 - 나의 신고내역
//		@GetMapping("/reports") 
//		public String reports(Model model) {
//		return "myPage/reports"; 
//		}
		  
	//마이페이지 - 나의 신고내역
		@GetMapping("/reports") 
		public String getMyreports(HttpSession session, Model model) {
			  // 세션에서 UserDTO 객체 가져오기
		    Object userObj = session.getAttribute("loggedInUser");
		    
		    if (userObj instanceof UserDTO) {
		        UserDTO user = (UserDTO) userObj;
		        int user_id = user.getUser_id(); // user_id 추출
		        System.out.println("Extracted user_id: " + user_id);

		        // Service 호출하여 게시글 목록 조회
		        List<ReportDTO> reportList = userService.getMyreportsByUserId(user_id);
		        System.out.println("reportList: " + reportList);
		        model.addAttribute("reportList", reportList);
		        return "myPage/reports"; // reports.jsp 반환
		    } else {
		        // 세션에 UserDTO가 없거나 로그인되지 않은 경우
		        System.out.println("Session does not contain a valid UserDTO.");
		        return "redirect:/login"; // 로그인 페이지로 리다이렉트
		    }
		
		}
		 
	
	
		/*
		  //마이페이지 - 나의 신고내역(관리자)
		  
		  @GetMapping("/reports") public String reports(Model model) {
		  
		  @Autowired reportService reportservice;
		  
		  model.addAttribute("reportList",reportservice.getAllReports());
		  
		  return "myPage/reports"; }
		  
		*/
		 
		  

	
	

		
		
		
		
}
