package com.team.salre.login;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

@RestController // 반환값이 JSP와 같은 View가 아니라 JSON이나 XML 등의 데이터 형식으로 반환
public class RestLoginController {

	@Autowired
	private UserService userService;

	// ID중복조회
	@GetMapping("/checkId")
    public ResponseEntity<String> checkId(@RequestParam("id") String id) {
        boolean isAvailable = userService.isIdAvailable(id);
        System.out.println("@@@id = "+ id);
        return isAvailable ? ResponseEntity.ok("available") : ResponseEntity.ok("unavailable");
    	}


		/*
		 * // 인증 데이터를 세션에 저장
		 * 
		 * @PostMapping("/saveCertificationData") public ResponseEntity<Void>
		 * saveCertificationData(@RequestBody Map<String, String> userData, HttpSession
		 * session) { // 전달받은 데이터 String name = userData.get("name"); String phone =
		 * userData.get("phone");
		 * 
		 * // 세션에 데이터 저장 session.setAttribute("certifiedName", name);
		 * session.setAttribute("certifiedPhone", phone);
		 * 
		 * return ResponseEntity.ok().build(); }
		 */
  
}