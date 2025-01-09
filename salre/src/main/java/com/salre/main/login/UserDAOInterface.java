package com.salre.main.login;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;

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