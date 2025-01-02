package com.salre.main.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	public UserService userService;
	
	
	//모두조회
	@GetMapping("/user.do")
	public String getUserAll(Model model,HttpServletRequest request) {
		List<UserDTO> userlist = userService.getselectAll();
		model.addAttribute("userlist",userlist);
		return "user/user";
	}
	
	
	 // 계약 ID로 조회
    @GetMapping("/list/{user_id}")
    public String getUserById(@PathVariable int user_id,Model model) {
        UserDTO user = userService.getUserById(user_id);
        model.addAttribute("user",user);
        return "user/user";
    }
    
   
    
}
