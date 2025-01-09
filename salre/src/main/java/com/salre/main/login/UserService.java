package com.salre.main.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

import at.favre.lib.crypto.bcrypt.BCrypt;

@Service
public class UserService {

	  @Autowired
	    private UserDAO userDAO;
	  



	  
	    //--회占쏙옙占쏙옙占쏙옙
	    public int registerUser(UserDTO user) {
	        // 占쏙옙橘占싫� 占쏙옙호화
	        String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
	    	user.setPassword(hashedPassword); // 占쏙옙호화占쏙옙 占쏙옙橘占싫ｏ옙占� 占쏙옙占쏙옙

	        // DB占쏙옙 占쏙옙占쏙옙
	        return userDAO.insertUser(user);
	    }

	    
	    //admin-handleBoardReport
	    public  List<ReportDTO> getBoardReportsByUserId(int user_id){
	    	return userDAO.getBoardReportsByUserId(user_id);
	    }
	
		
	    
	    //占싸깍옙占쏙옙
	    public UserDTO loginUser(String id, String password) {
	        // 1. ID占쏙옙 占쏙옙占쏙옙占� 占쏙옙회
	        UserDTO user = userDAO.selectUserById(id);
	        if (user == null) {
	            return null; // 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占싸깍옙占쏙옙 占쏙옙占쏙옙
	        }

	        // 2. 占쏙옙橘占싫� 占쏙옙占쏙옙
	        boolean isPasswordMatch = at.favre.lib.crypto.bcrypt.BCrypt.verifyer()
	                                   .verify(password.toCharArray(), user.getPassword())
	                                   .verified;

	        if (isPasswordMatch) {
	            // 占쏙옙橘占싫� 占쏙옙占쏙옙 占쏙옙占쏙옙: 占쏙옙橘占싫ｏ옙占� null占쏙옙 占쏙옙占쏙옙占싹울옙 占쏙옙환
	            user.setPassword(null);
	            return user;
	        }

	        // 占쏙옙橘占싫� 占쏙옙占쏙옙 占쏙옙占쏙옙
	        return null;
	    }




	    //--占쏙옙占싱듸옙 찾占쏙옙
		public String findIdByEmailAndName(String email, String name) {
			String find_id = userDAO.findIdByEmailAndName(email, name);
			System.out.println("UserService/ find Id @@@email = " + find_id);
			return find_id;
			
		}
		
		
		//--PW찾占쏙옙
		  @Autowired
		    private JavaMailSender mailSender;

		    private final Map<String, String> verificationCodes = new HashMap<>();

		    public boolean validateUser(String id, String email) {
		        return userDAO.checkUser(id, email);
		    }

		    public void generateVerificationCode(String email) {//占쏙옙占쏙옙占쏙옙호 占쏙옙占쏙옙 占쏙옙 占쌩쇽옙
		        String verificationCode = String.valueOf(new Random().nextInt(900000) + 100000);
		        verificationCodes.put(email, verificationCode);
		        sendEmail(email, "占쏙옙橘占싫� 찾占쏙옙 占쏙옙占쏙옙占쏙옙호", "占쏙옙占쏙옙占쏙옙호: " + verificationCode);
		    }

		    public boolean verifyCode(String email, String verificationCode) {//占쏙옙占쏙옙占쏙옙호 확占쏙옙
		        return verificationCode.equals(verificationCodes.get(email));
		    }

		    public void updatePassword(String email, String newPassword) {//占쏙옙橘占싫� 占쏙옙호화 占쏙옙 占쏙옙占쏙옙占쏙옙트
		        String encodedPassword = new BCryptPasswordEncoder().encode(newPassword);
		        userDAO.updatePassword(email, encodedPassword);
		    }

		    private void sendEmail(String to, String subject, String body) {//占싱몌옙占쏙옙 占쌩쇽옙
		        SimpleMailMessage message = new SimpleMailMessage(); //占싱몌옙占쏙옙 占쌨쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
		        message.setTo(to);//占싱몌옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌍소몌옙 占쏙옙占쏙옙
		        message.setSubject(subject);//占싱몌옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
		        message.setText(body);//占싱몌옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
		        mailSender.send(message);//占쏙옙占쏙옙占쏙옙 占싱몌옙占쏙옙 占쌨쏙옙占쏙옙占쏙옙 占쌩쇽옙..mailSender占쏙옙 JavaMailSender 占쏙옙체占싱몌옙, 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占� 占싱몌옙占쏙옙占쏙옙 占쌩쇽옙
		    }
	     
		//--회占쏙옙탈占쏙옙
		  public void deleteUser(String id) {
		        userDAO.deleteUser(id);
		    }
		  
		//--ID占쌩븝옙占쏙옙회		  
		  public boolean isIdAvailable(String id) {
			  //userDAO.selectUserById2(id): null-占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙 占쌔댐옙 ID占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙 占쏙옙占� 占쏙옙占쏙옙占쏙옙 ID./占쏙옙占쏙옙 占쏙옙占쏙옙-占쏙옙占쏙옙占싶븝옙占싱쏙옙占쏙옙 占쌔댐옙 ID占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙 占쌩븝옙占쏙옙 ID.
		      return userDAO.selectUserById2(id) == null;
		    }
		//email 중복조회
		  public boolean isEmailAvailable(String email) {
			  int count = userDAO.countByEmail(email);
			  return count==0;
		  }
		  
		//마이페이지 - 나의 거래현황 목록 조회(구매자)
		  public List<ProductDTO> getBuyerTransactionByUserId(int user_id) {
				return userDAO.getBuyerTransactionByUserId(user_id);
		  	}
		  
		//마이페이지 - 나의 거래현황 목록 조회
		public List<ProductDTO> getTransactionByUserId(int user_id) {
				return userDAO.getTransactionByUserId(user_id);
				    }

		//마이페이지 - 나의 거래현황 - 후기작성
		public void registerReview(ReviewDTO review) {
			      userDAO.insertReview(review);
			    }
		
		//마이페이지 - 나의 관심매물 
		public List<ProductDTO> getFavoritesByUserId(int user_id){
			return userDAO.getFavoritesByUserId(user_id);
		}

		//마이페이지 - 내가 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회))
		public List<PostDTO> getPostsByUserId(int user_id) {
			   return userDAO.selectPostsByUserId(user_id);
		}
		
		//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占쌜쇽옙占쏙옙 占식깍옙
		public  List<ReviewDTO> getMyreviewsByUserId(int user_id) {
				return userDAO.selectReviewsByUserId(user_id);
		}
		
		//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占쌜쇽옙占쏙옙 占식깍옙(占쏙옙占쏙옙)
		
		public void updateReview(int review_id, int review_rate, String review_content) { 
			  userDAO.updateReview(review_id, review_rate,  review_content); 
		 }
		  
		//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신뤄옙占식깍옙(占쏙옙占쏙옙)
		public void deleteReview(int review_id) {
			    userDAO.deleteReview(review_id);
			}

		  
		// 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙  
		public List<ReportDTO> getMyreportsByUserId(int user_id){
			  return userDAO.selectReportsByUserId(user_id);
		  }

		// 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 회占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙
		public void updateUserInfo(UserDTO user) {
			userDAO.updateUserInfo(user);
		};
		 
		
		
}
