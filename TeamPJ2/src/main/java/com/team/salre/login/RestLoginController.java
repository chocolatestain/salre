package com.team.salre.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController //반환값이 JSP와 같은 View가 아니라 JSON이나 XML 등의 데이터 형식으로 반환
public class RestLoginController {
	
    @Autowired
    private UserService userService;

    //ID중복조회
    @GetMapping("/checkId")
    public ResponseEntity<String> checkId(@RequestParam("id") String id) {
        boolean isAvailable = userService.isIdAvailable(id);
        System.out.println("@@@id = "+ id);
        return isAvailable ? ResponseEntity.ok("available") : ResponseEntity.ok("unavailable");
    }

}





