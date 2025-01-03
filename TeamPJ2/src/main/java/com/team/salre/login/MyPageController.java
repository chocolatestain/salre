package com.team.salre.login;

import java.util.List;

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
		
		
		
		return "myPage/reviews";
	}
 
	
	//���������� - ���� �Ű���
	@GetMapping("/reports") 
	public String reports() {
		return "myPage/reports";
	}
	

		
		
		
		
}
