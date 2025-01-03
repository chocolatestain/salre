package com.team.salre.login;

import java.io.IOException;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
//@RequestMapping("/salre")
public class LoginController {

	@Autowired
	private UserService userService;
	
//	@Autowired 
//	ProductService productService; //설 코드 합칠경우
	
	// 본인인증 페이지
	@GetMapping("/signup")
	public String signupPage() {
		return "logIn/signUpAuth"; // signup.jsp 반환
	}
	
	
	  // 본인인증 처리
	  @PostMapping("/certify")
//	  @ResponseBody //메서드의 반환값을 JSON 또는 문자열과 같은 HTTP 응답 본문에 직접 포함
	  public ResponseEntity<String> processCertification(@RequestParam("certificationResult") boolean certificationResult, HttpSession session){ 
	  if(certificationResult) {
	  session.setAttribute("isCertified", true); // 인증 성공 상태 저장 return
	  return ResponseEntity.ok("Certification Successful"); 
	  }else {
	  session.setAttribute("isCertified", false); // 인등 실패 상태 저장 return
	  return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Certification Failed"); 
	  	}
	  }
	  
	
	
	// 회원가입 처리
	@PostMapping("/signup")
	public String registerUser(UserDTO user, Model model) {
		int result = userService.registerUser(user);
		model.addAttribute("message", result > 0 ? "회원가입 성공" : "회원가입 실패");
		
		return "redirect:login"; // 회원가입 후 로그인 페이지로 이동 //salre/ 추가했음
	}

	
	// 회원정보입력 페이지
		@GetMapping("/signUpInfo")
		public String signupInfoPage() {
			return "logIn/signUpInfo"; // signup.jsp 반환
		}
		
		
/*		
	// 회원정보입력 페이지
	@GetMapping("/signUpInfo")
	public String signUpInfoPage(HttpSession session) {
		// 본인인증 여부 확인(세션에 인증 여부 저장한다고 가정)
		Boolean isCertified=(Boolean) session.getAttribute("isCertified");
		
		if(isCertified !=null&& isCertified) {
			return "logIn/signUpInfo";//회원정보입력 페이지 반환
		}else {
			return "redirect:/signup";//인증이 완료되지 않았다면 다시 본인인증 페이지로 리다이렉트
		}
	}
	
	*/
	
	// 로그인 페이지
	@GetMapping("/login")
	public String loginPage() {
		return "logIn/login"; // login.jsp 반환
	}

	// 로그인 처리
	@PostMapping("/login")
	public String loginUser(@RequestParam String id, @RequestParam String password, HttpSession session, Model model) {
		UserDTO user = userService.loginUser(id, password);
		// System.out.println("user : " + user);
		if (user != null) {
			session.setAttribute("loggedInUser", user);
			model.addAttribute("user", user);
			return "myPage/transactions"; // 로그인 성공 시 transactions.jsp로 이동

			// return "redirect:/home"; // 로그인 성공 시 홈으로 이동

		} else {
			model.addAttribute("error", "로그인 실패: 아이디 또는 비밀번호가 잘못되었습니다.");
			return "logIn/login"; // 로그인 실패 시 다시 로그인 페이지
		}
	}

	// ID 찾기 페이지
	@GetMapping("/findId")
	public String findIdPage() {
		return "/logIn/findId";
	}

	// ID 찾기 처리
	@PostMapping("/findId")
	public String processFindId(@RequestParam("email") String email, Model model) {
		// 이메일로 ID를 찾는 서비스 호출
		String userId = userService.findIdByEmail(email);
		System.out.println("userID###### : " + userId);

		if (userId != null) {
			model.addAttribute("message", "Your ID is: " + userId);
		} else {
			model.addAttribute("error", "No account found with that email.");
		}

		return "/logIn/findId";
	}

	// 회원탈퇴 처리
	@PostMapping("/deleteUser")
	public String deleteUser(@RequestParam("id") String id, RedirectAttributes redirectAttributes) { // RedirectAttributes
		
		try {
			userService.deleteUser(id);
			redirectAttributes.addFlashAttribute("message", "회원탈퇴가 완료되었습니다."); // addFlashAttribute를 사용하면 리다이렉트된 페이지에서만
																				// 메시지가 유효
			return "redirect:/login";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "회원탈퇴 중 오류가 발생했습니다.");
			return "redirect:/myPage";
		}
	}

	@ResponseBody
	@PostMapping(value = "/rspTest")
	public String rspTest(String imp_uid) {

		String impKey = "3773152135261483";
		String impSecret = "qgNu6fc4TSvhlM064OnoUI7L9L5VAFcacvog2ilCmiyq8C6xLbB6XnOyYNNyksDrzoMx3KN5DgKaoUaA";

		String jsonBody = "{\"imp_key\":\"" + impKey + "\", \"imp_secret\":\"" + impSecret + "\"}";

		HttpRequest request = HttpRequest.newBuilder().uri(URI.create("https://api.iamport.kr/users/getToken"))
				.header("Content-Type", "application/json")
				.method("POST", HttpRequest.BodyPublishers.ofString(jsonBody)).build();
		HttpResponse<String> response = null;
		try {
			response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
		String jsonResponse = response.body();
		ObjectMapper objectMapper = new ObjectMapper();

		JsonNode rootNode = null;
		try {
			rootNode = objectMapper.readTree(jsonResponse);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		String token = rootNode.path("response").path("access_token").asText();
		
		HttpRequest request2 = HttpRequest.newBuilder().uri(URI.create("https://api.iamport.kr/certifications/" + imp_uid))
				.header("Content-Type", "application/json")
				.header("Authorization", "Bearer " + token)
				.method("GET", HttpRequest.BodyPublishers.ofString("")).build();
		
		HttpResponse<String> response2 = null;
		try {
			response2 = HttpClient.newHttpClient().send(request2, HttpResponse.BodyHandlers.ofString());
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
		String jsonResponse2 = response2.body();
 
		
		System.out.println(jsonResponse2); 
		
		return  jsonResponse2;

	}
 
	
	
	 
    
	

	/*
	 * 광진 테스트코드 본인인증 //rspTest
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping(value = "/rspTest", consumes=MediaType.APPLICATION_JSON_VALUE,
	 * produces="text/plain;charset=utf-8") public String rspTest(String imp_uid) {
	 * String uid = imp_uid;
	 * 
	 * return uid; }
	 */

	/*
	 * 테스트코드 본인인증 //rspTest
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/rspTest") public String rspTest(String imp_uid) { String uid =
	 * imp_uid;
	 * 
	 * return "/logIn/rspTest"; }
	 */

	/*
	 * 테스트코드 본인인증 블로그참고 // 본인인증완료 후 빼내 온 정보 중 핸드폰 번호와 입력한 핸드폰 번호가 일치한지 확인하고 // 일치하면
	 * true 아니면 false 를 반환해서 완벽하게 이루어 졌나 확인 한다.
	 * 
	 * @GetMapping("/rspTest") public Map handleRedirect(@RequestParam("imp_uid")
	 * String impUid, @RequestParam("email") String email) { boolean flag = false;
	 * Map map = new HashMap<>(); System.out.println("Received imp_uid: " + impUid);
	 * map = SignUpService.getAccessToken(impUid); UserDTO dto =
	 * UserService.getMember(email);
	 * 
	 * String phone = (String) map.get("phone"); String name = (String)
	 * map.get("name");
	 * 
	 * if (dto != null) { if (dto.getPhone_num().equals(phone)) { flag = true; } }
	 * map.put("flag", flag); map.put("name", name); return map; }
	 */
}
