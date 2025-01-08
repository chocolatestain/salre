package com.salre.main.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController // ��ȯ���� JSP�� ���� View�� �ƴ϶� JSON�̳� XML ���� ������ �������� ��ȯ
public class RestLoginController {

	@Autowired
	private UserService userService;

	// ID�ߺ���ȸ
	@GetMapping("/checkId")
    public ResponseEntity<String> checkId(@RequestParam("id") String id) {
        boolean isAvailable = userService.isIdAvailable(id);
        System.out.println("@@@id = "+ id);
        return isAvailable ? ResponseEntity.ok("available") : ResponseEntity.ok("unavailable");
    	}

	// email�ߺ���ȸ
	 @GetMapping("/checkEmail")
	    @ResponseBody
	    public String checkEmail(@RequestParam("email") String email) {
	        boolean isAvailable = userService.isEmailAvailable(email);
	        return isAvailable ? "available" : "unavailable";
	    }
	

		/*
		 * // ���� �����͸� ���ǿ� ����
		 * 
		 * @PostMapping("/saveCertificationData") public ResponseEntity<Void>
		 * saveCertificationData(@RequestBody Map<String, String> userData, HttpSession
		 * session) { // ���޹��� ������ String name = userData.get("name"); String phone =
		 * userData.get("phone");
		 * 
		 * // ���ǿ� ������ ���� session.setAttribute("certifiedName", name);
		 * session.setAttribute("certifiedPhone", phone);
		 * 
		 * return ResponseEntity.ok().build(); }
		 */
  
}