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
	
	//���������� - ��������
	@GetMapping("/myPage")
	public String userInfo(HttpSession session, Model model) {	    
		return "myPage/myPage";	
	}
	//���������� - ��������
 
	//���������� - ���ǰ��ɸŹ�
	@GetMapping("/favorites")
	public String favorites() {
		return "myPage/favorites";
		}
	
	//���������� - ���� �ŷ���Ȳ
	@GetMapping("/transactions")
	public String transactions() {
		return "myPage/transactions";
	}

 
	//���������� - ���� �ۼ��� ��.. ��� ��ȸ
	@GetMapping("/posts")
	public String getMyPosts(HttpSession session, Model model) {
	    // ���ǿ��� UserDTO ��ü ��������
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id ����
	        System.out.println("Extracted user_id: " + user_id);

	        // Service ȣ���Ͽ� �Խñ� ��� ��ȸ
	        List<PostDTO> postList = userService.getPostsByUserId(user_id);
	        System.out.println("postList: " + postList);
	        model.addAttribute("postList", postList);
	        return "myPage/posts"; // post.jsp ��ȯ
	    } else {
	        // ���ǿ� UserDTO�� ���ų� �α��ε��� ���� ���
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // �α��� �������� �����̷�Ʈ
	    }
	}
 
	
	//���������� - ���� �ŷ��ı�
	@GetMapping("/reviews") 
	public String getMyreviews(HttpSession session, Model model) {
		  // ���ǿ��� UserDTO ��ü ��������
	    Object userObj = session.getAttribute("loggedInUser");
	    
	    if (userObj instanceof UserDTO) {
	        UserDTO user = (UserDTO) userObj;
	        int user_id = user.getUser_id(); // user_id ����
	        System.out.println("Extracted user_id: " + user_id);

	        // Service ȣ���Ͽ� �Խñ� ��� ��ȸ
	        List<ReviewDTO> reviewList = userService.getMyreviewsByUserId(user_id);
	        System.out.println("reviewList: " + reviewList);
	        model.addAttribute("reviewList", reviewList);
	        return "myPage/reviews"; // reviews.jsp ��ȯ
	    } else {
	        // ���ǿ� UserDTO�� ���ų� �α��ε��� ���� ���
	        System.out.println("Session does not contain a valid UserDTO.");
	        return "redirect:/login"; // �α��� �������� �����̷�Ʈ
	    }
	
	}

	
	//���������� - ���� �ŷ��ı�(������ư Ŭ����)
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
	        response.put("message", "�ı� ������ �����߽��ϴ�.");
	    }

	    return response;
	}

	//���������� - ���� �ŷ��ı�(������ư Ŭ����)
		@PostMapping("/reviews/delete")
		@ResponseBody
		public Map<String, Object> deleteReview(@RequestParam int review_id){
			Map<String, Object> response = new HashMap<>();
			
			try {
				userService.deleteReview(review_id);
				response.put("success", true);
				response.put("message", "�ıⰡ ���������� �����Ǿ����ϴ�.");
				
			}catch(Exception e) {
				response.put("success", false);
				response.put("message", "�ı� ������ �����߽��ϴ�.");
			}
			return response;
		}

	
     //���������� - ���� �Ű�����
//		@GetMapping("/reports") 
//		public String reports(Model model) {
//		return "myPage/reports"; 
//		}
		  
	//���������� - ���� �Ű�����
		@GetMapping("/reports") 
		public String getMyreports(HttpSession session, Model model) {
			  // ���ǿ��� UserDTO ��ü ��������
		    Object userObj = session.getAttribute("loggedInUser");
		    
		    if (userObj instanceof UserDTO) {
		        UserDTO user = (UserDTO) userObj;
		        int user_id = user.getUser_id(); // user_id ����
		        System.out.println("Extracted user_id: " + user_id);

		        // Service ȣ���Ͽ� �Խñ� ��� ��ȸ
		        List<ReportDTO> reportList = userService.getMyreportsByUserId(user_id);
		        System.out.println("reportList: " + reportList);
		        model.addAttribute("reportList", reportList);
		        return "myPage/reports"; // reports.jsp ��ȯ
		    } else {
		        // ���ǿ� UserDTO�� ���ų� �α��ε��� ���� ���
		        System.out.println("Session does not contain a valid UserDTO.");
		        return "redirect:/login"; // �α��� �������� �����̷�Ʈ
		    }
		
		}
		 
	
	
		/*
		  //���������� - ���� �Ű�����(������)
		  
		  @GetMapping("/reports") public String reports(Model model) {
		  
		  @Autowired reportService reportservice;
		  
		  model.addAttribute("reportList",reportservice.getAllReports());
		  
		  return "myPage/reports"; }
		  
		*/
		 
		  

	
	

		
		
		
		
}
