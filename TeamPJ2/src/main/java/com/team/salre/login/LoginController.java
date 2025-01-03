package com.team.salre.login;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
//@RequestMapping("/salre")
public class LoginController {

	@Autowired
	private UserService userService;

	// ȸ������ ������
	@GetMapping("/signup")
	public String signupPage() {
		return "logIn/signup"; // signup.jsp ��ȯ
	}

	@GetMapping("/logout")
	public String logout() {
		return "common/logout";
	}

	// ȸ������ ó��
	@PostMapping("/signup")
	public String registerUser(UserDTO user, Model model) {
		int result = userService.registerUser(user);
		model.addAttribute("message", result > 0 ? "ȸ������ ����" : "ȸ������ ����");

		return "redirect:login"; // ȸ������ �� �α��� �������� �̵� //salre/ �߰�����
	}

	// �α��� ������
	@GetMapping("/login")
	public String loginPage() {
		return "logIn/login"; // login.jsp ��ȯ
	}

	@GetMapping("/admin/myPage")
	public void admin() {
	}

	// �α��� ó��
	@PostMapping("/login")
	public String loginUser(@RequestParam String id, @RequestParam String password, HttpSession session, Model model) {
		UserDTO user = userService.loginUser(id, password);
		// System.out.println("user : " + user);
		if (user != null) {
			session.setAttribute("loggedInUser", user);
			if (id.equals("test15")) {
				session.setAttribute("contractStatusPending", 10); // 진행 전
				session.setAttribute("contractStatusNegotiating", 5); // 조율 중
				session.setAttribute("contractStatusOngoing", 15); // 진행 중
				session.setAttribute("contractStatusCompleted", 20); // 계약 완료
				session.setAttribute("propertyReportCount", 30); // 매물 신고 건수
				session.setAttribute("boardReportCount", 12); // 게시판 신고 건수
				session.setAttribute("userReportCount", 8); // 유저 신고 건수
				session.setAttribute("board1PostCount", 150); // 게시판 1 게시글 수
				session.setAttribute("board2PostCount", 120); // 게시판 2 게시글 수
				session.setAttribute("board3PostCount", 130); // 게시판 3 게시글 수
				session.setAttribute("contractCount", 50); // 전체 계약 건수
				return "redirect:admin/myPage";
			}
			model.addAttribute("user", user);
			return "myPage/transactions"; // �α��� ���� �� transactions.jsp�� �̵�

			// return "redirect:/home"; // �α��� ���� �� Ȩ���� �̵�
		}

		else {
			model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
			return "logIn/login"; // �α��� ���� �� �ٽ� �α��� ������
		}
	}

	// ID ã�� ������
	@GetMapping("/findId")
	public String findIdPage() {
		return "/logIn/findId";
	}

	// ID ã�� ó��
	@PostMapping("/findId")
	public String processFindId(@RequestParam("email") String email, Model model) {
		// �̸��Ϸ� ID�� ã�� ���� ȣ��
		String userId = userService.findIdByEmail(email);
		System.out.println("userID###### : " + userId);

		if (userId != null) {
			model.addAttribute("message", "Your ID is: " + userId);
		} else {
			model.addAttribute("error", "No account found with that email.");
		}

		return "/logIn/findId";
	}

	// ȸ��Ż�� ó��
	@PostMapping("/deleteUser")
	public String deleteUser(@RequestParam("id") String id, RedirectAttributes redirectAttributes) { // RedirectAttributes

		try {
			userService.deleteUser(id);
			redirectAttributes.addFlashAttribute("message", "ȸ��Ż�� �Ϸ�Ǿ����ϴ�."); // addFlashAttribute�� ����ϸ�
																					// �����̷�Ʈ�� ������������
																					// �޽����� ��ȿ
			return "redirect:/login";
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("error", "ȸ��Ż�� �� ������ �߻��߽��ϴ�.");
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

		HttpRequest request2 = HttpRequest.newBuilder()
				.uri(URI.create("https://api.iamport.kr/certifications/" + imp_uid))
				.header("Content-Type", "application/json").header("Authorization", "Bearer " + token)
				.method("GET", HttpRequest.BodyPublishers.ofString("")).build();

		HttpResponse<String> response2 = null;
		try {
			response2 = HttpClient.newHttpClient().send(request2, HttpResponse.BodyHandlers.ofString());
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
		String jsonResponse2 = response2.body();

		System.out.println(jsonResponse2);

		return jsonResponse2;

	}

	@GetMapping("/admin/boardreport")
	public String boardReport() {

		return "admin/boardreport";
	}

	@GetMapping("/admin/productreport")
	public String productReport() {

		return "admin/productreport";
	}

	@PostMapping("/admin/myPage")
	public String handleAdminPost(HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("loggedInUser");
		if (user == null) {
			return "redirect:/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
		}

		// 세션 데이터 확인 후 필요하면 추가 작업
		return "redirect:/admin/myPage"; // GET 요청으로 리다이렉트
	}

}
