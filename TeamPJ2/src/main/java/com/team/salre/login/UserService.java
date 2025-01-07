package com.team.salre.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import at.favre.lib.crypto.bcrypt.BCrypt;

@Service
public class UserService {

	  @Autowired
	    private UserDAO userDAO;
	  



	  
	    //--회원가입
	    public int registerUser(UserDTO user) {
	        // 비밀번호 암호화
	        String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
	    	user.setPassword(hashedPassword); // 암호화된 비밀번호로 설정

	        // DB에 저장
	        return userDAO.insertUser(user);
	    }

	    
	    
	   
		/*
		 * //--용범씨 로그인 public UserDTO loginUser(String id, String password) { UserDTO user =
		 * userDAO.selectUserById(id, password); //System.out.println("userDTO : " +
		 * user);
		 * 
		 * //사용자 정보가 없으면 null 반환 if(user ==null) { return null; }
		 * 
		 * // bcrypt 비밀번호 검증 (직접 bcrypt를 사용하여 비밀번호를 비교) if
		 * (at.favre.lib.crypto.bcrypt.BCrypt.verifyer().verify(password.toCharArray(),
		 * user.getPassword()).verified) {
		 * 
		 * 
		 * // 비밀번호가 일치하면 비밀번호는 null 처리 (보안상) user.setPassword(password);
		 * //user.setPassword(null); return user;
		 * 
		 * } else { // 비밀번호 불일치 시 null 반환 return null; } }
		 */
	    
	    
	    //로그인
	    public UserDTO loginUser(String id, String password) {
	        // 1. ID로 사용자 조회
	        UserDTO user = userDAO.selectUserById(id);
	        if (user == null) {
	            return null; // 사용자 정보가 없으면 로그인 실패
	        }

	        // 2. 비밀번호 검증
	        boolean isPasswordMatch = at.favre.lib.crypto.bcrypt.BCrypt.verifyer()
	                                   .verify(password.toCharArray(), user.getPassword())
	                                   .verified;

	        if (isPasswordMatch) {
	            // 비밀번호 검증 성공: 비밀번호를 null로 설정하여 반환
	            user.setPassword(null);
	            return user;
	        }

	        // 비밀번호 검증 실패
	        return null;
	    }




	    //--아이디 찾기
		public String findIdByEmailAndName(String email, String name) {
			String find_id = userDAO.findIdByEmailAndName(email, name);
			System.out.println("UserService/ find Id @@@email = " + find_id);
			return find_id;
			
		}
		
		
		//--PW찾기
		  @Autowired
		    private JavaMailSender mailSender;

		    private final Map<String, String> verificationCodes = new HashMap<>();

		    public boolean validateUser(String id, String email) {
		        return userDAO.checkUser(id, email);
		    }

		    public void generateVerificationCode(String email) {//인증번호 생성 및 발송
		        String verificationCode = String.valueOf(new Random().nextInt(900000) + 100000);
		        verificationCodes.put(email, verificationCode);
		        sendEmail(email, "비밀번호 찾기 인증번호", "인증번호: " + verificationCode);
		    }

		    public boolean verifyCode(String email, String verificationCode) {//인증번호 확인
		        return verificationCode.equals(verificationCodes.get(email));
		    }

		    public void updatePassword(String email, String newPassword) {//비밀번호 암호화 및 업데이트
		        String encodedPassword = new BCryptPasswordEncoder().encode(newPassword);
		        userDAO.updatePassword(email, encodedPassword);
		    }

		    private void sendEmail(String to, String subject, String body) {//이메일 발송
		        SimpleMailMessage message = new SimpleMailMessage(); //이메일 메시지를 생성
		        message.setTo(to);//이메일 수신자 주소를 설정
		        message.setSubject(subject);//이메일 제목을 설정
		        message.setText(body);//이메일 본문을 설정
		        mailSender.send(message);//설정한 이메일 메시지를 발송..mailSender는 JavaMailSender 객체이며, 메일 서버 설정을 기반으로 이메일을 발송
		    }
	     
		//--회원탈퇴
		  public void deleteUser(String id) {
		        userDAO.deleteUser(id);
		    }
		  
		//--ID중복조회		  
		  public boolean isIdAvailable(String id) {
			  //userDAO.selectUserById2(id): null-데이터베이스에 해당 ID가 존재하지 않음 → 사용 가능한 ID./값이 있음-데이터베이스에 해당 ID가 존재함 → 중복된 ID.
		      return userDAO.selectUserById2(id) == null;
		    }
		  
		  public boolean isEmailAvailable(String email) {
			  int count = userDAO.countByEmail(email);
			  return count==0;
		  }


		//마이페이지 - 내가 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
		public List<PostDTO> getPostsByUserId(int user_id) {
			   return userDAO.selectPostsByUserId(user_id);
		}
		
		//마이페이지 - 내가 작성한 후기
		public  List<ReviewDTO> getMyreviewsByUserId(int user_id) {
				return userDAO.selectReviewsByUserId(user_id);
		}
		
		//마이페이지 - 내가 작성한 후기(수정)
		
		public void updateReview(int review_id, int review_rate, String review_content) { 
			  userDAO.updateReview(review_id, review_rate,  review_content); 
		 }
		  
		//마이페이지 - 나의 거래후기(삭제)
		public void deleteReview(int review_id) {
			    userDAO.deleteReview(review_id);
			}

		  
		// 마이페이지 - 나의 신고내역  
		public List<ReportDTO> getMyreportsByUserId(int user_id){
			  return userDAO.selectReportsByUserId(user_id);
		  }

		// 마이페이지 - 회원정보수정
		public void updateUserInfo(UserDTO user) {
			userDAO.updateUserInfo(user);
		};
		 
		
		
}
