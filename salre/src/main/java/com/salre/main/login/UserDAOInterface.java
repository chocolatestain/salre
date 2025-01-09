package com.salre.main.login;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

// Interface(占쌉격쇽옙): 占쏙옙占실댐옙 占쌍곤옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙.
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
		    
		    //admin-handleBoardReport
		    public  List<ReportDTO> getBoardReportsByUserId(int user_id);
		    
		    //마이페이지 - 나의 거래현황 목록 조회(구매자)
		    public List<ProductDTO> getBuyerTransactionByUserId(int user_id);
		    
		    //마이페이지 - 나의 거래현황 목록 조회
		    public List<ProductDTO> getTransactionByUserId(int user_id);
		    
		    //마이페이지 - 나의 관심매물
		  	public List<ProductDTO> getFavoritesByUserId(int user_id);
		    
		    //마이페이지 - 내가 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
		    public List<PostDTO> selectPostsByUserId(int user_id);
		    
			//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占쌜쇽옙占쏙옙 占식깍옙
			public List<ReviewDTO> selectReviewsByUserId(int user_id);
			
			//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占쌜쇽옙占쏙옙 占식깍옙(占쏙옙占쏙옙)
			public void updateReview(int review_id, int review_rate, String review_content);
			
			//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占쌜쇽옙占쏙옙 占식깍옙(占쏙옙占쏙옙)
			public void deleteReview(int review_id);
			  
			//占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙
			public List<ReportDTO> selectReportsByUserId(int user_id);
			  
			// 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 - 회占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙
		    public void updateUserInfo(UserDTO user);
					 


}