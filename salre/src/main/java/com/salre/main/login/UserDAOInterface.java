package com.salre.main.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.salre.main.myPage.LikeDTO;
import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

// Interface(�԰ݼ�): ���Ǵ� �ְ� ������ ����.
@Mapper
public interface UserDAOInterface {

			// ȸ������
			public int insertUser(UserDTO user);
			
			public UserDTO selectById(int  user_id);
			
			// �α���
			//public UserDTO selectUserById(String id,String password);
			public UserDTO selectUserById(String id);
			
			// IDã��
			/* public String findIdByEmail(String email); */
			public String findIdByEmailAndName(String email, String name);
			
		    // PWã��
		    public boolean checkUser(String id, String email) ;
		    public void updatePassword(String email, String newPassword) ;
			
			// ȸ��Ż��
			public void deleteUser(String id);
			
			// ID�ߺ�üũ
		    public UserDTO selectUserById2(String id);

			//admin-handleBoardReport
		    public  List<ReportDTO> getBoardReportsByUserId(int user_id);

		    //마이페이지 - 나의 거래현황 목록 조회(구매자)
		    public List<ProductDTO> getBuyerTransactionByUserId(int user_id);

		    //마이페이지 - 나의 거래현황 목록 조회
		    public List<ProductDTO> getTransactionByUserId(int user_id);

		    //마이페이지 - 나의 관심매물
		  	public List<ProductDTO> getFavoritesByUserId(int user_id);
		  	
		    //마이페이지 - 나의 관심매물추가
			public void insertFavorite(LikeDTO userlike);
			
			//마이페이지 - 나의 관심매물상태변경(1>0) 
			public void updateFavorite(LikeDTO userlike);
			  
			//마이페이지 - 나의 관심매물삭제  
			public void deleteFavorite(LikeDTO userlike);
		  
		    //���������� - ���� �ۼ��� �� ��� ��ȸ(Ư�� ������� �Խñ� ��� ��ȸ)
		    public List<PostDTO> selectPostsByUserId(int user_id);
		    
			//���������� - ���� �ۼ��� �ı�
			public List<ReviewDTO> selectReviewsByUserId(int user_id);
			
			//���������� - ���� �ۼ��� �ı�(����)
			public void updateReview(int review_id, int review_rate, String review_content);
			
			//���������� - ���� �ۼ��� �ı�(����)
			public void deleteReview(int review_id);
			  
			//���������� - ���� �Ű�����
			public List<ReportDTO> selectReportsByUserId(int user_id);
			  
			// ���������� - ȸ����������
		    public void updateUserInfo(UserDTO user);
					 


}