package com.salre.main.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;

// Interface(규격서): 정의는 있고 구현은 없다.
@Mapper
public interface UserDAOInterface {

			// 회원가입
			public int insertUser(UserDTO user);
			
			// 로그인
			//public UserDTO selectUserById(String id,String password);
			public UserDTO selectUserById(String id);
			
			// ID찾기
			/* public String findIdByEmail(String email); */
			public String findIdByEmailAndName(String email, String name);
			
		    // PW찾기
		    public boolean checkUser(String id, String email) ;
		    public void updatePassword(String email, String newPassword) ;
			
			// 회원탈퇴
			public void deleteUser(String id);
			
			// ID중복체크
		    public UserDTO selectUserById2(String id);
		  
		    //마이페이지 - 내가 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
		    public List<PostDTO> selectPostsByUserId(int user_id);
		    
			//마이페이지 - 내가 작성한 후기
			public List<ReviewDTO> selectReviewsByUserId(int user_id);
			
			//마이페이지 - 내가 작성한 후기(수정)
			public void updateReview(int review_id, int review_rate, String review_content);
			
			//마이페이지 - 내가 작성한 후기(삭제)
			public void deleteReview(int review_id);
			  
			//마이페이지 - 나의 신고내역
			public List<ReportDTO> selectReportsByUserId(int user_id);
			  
			// 마이페이지 - 회원정보수정
		    public void updateUserInfo(UserDTO user);
					 


}