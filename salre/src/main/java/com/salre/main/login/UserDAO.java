package com.salre.main.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;



@Repository("UserDAO")
public class UserDAO implements UserDAOInterface {

	@Autowired
	private SqlSession sqlSession;
	String namespace = "com.salre.main.login.UserDAOInterface.";


	public UserDTO selectById(int user_id) {
		UserDTO user = sqlSession.selectOne(namespace +"selectById",user_id);
		return user;
		
	}
	// ȸ������
	public int insertUser(UserDTO user) {
		int result = sqlSession.insert(namespace + "insertUser", user);
		return result;
	}

	// �α��� ������ڵ� ����.. UserService ������ user.setPassword(password); ����� �κ� ����
	/*
	 * public UserDTO selectUserById(String id, String password) {
	 * Map<String,Object> paramMap = new HashMap<String, Object>();
	 * System.out.println("id : " + id); System.out.println("password : " +
	 * password); paramMap.put("id", id); //ù ��° �� paramMap.put("password",
	 * password); // �� ��° �� return return sqlSession.selectOne(namespace +
	 * "selectUserById", paramMap); }
	 */

//    �α��� �׽�Ʈ�ڵ� Map�ƴϰ� DTO�� ����..???????????
//    public UserDTO selectUserById(String id, String password) {
//        UserDTO userParam = new UserDTO();
//        userParam.setId(id);  // DTO�� id ����
//        userParam.setPassword(password);  // DTO�� password ����
//        return sqlSession.selectOne(namespace + "selectUserById", userParam);
//    }
	
	//�α���
	public UserDTO selectUserById(String id) {
	    return sqlSession.selectOne(namespace + "selectUserById", id);
	}


	
	// IDã��
    public String findIdByEmailAndName(String email, String name) {
    	System.out.println("UserDAO/ email = " + email);
    	System.out.println("UserDAO/ name = " + name);
    	
    	// ������ ���� Map ��ü ����
        Map<String, String> params = new HashMap<>();
        params.put("email", email);
        params.put("name", name);
    	
    	String find_id = sqlSession.selectOne(namespace + "findIdByEmailAndName", params);
    	System.out.println("UserDAO/ find Id @@@email = " + find_id);
    	return find_id;
        //return userMapper.findIdByEmail(email);
    }
    
    // PWã��
    public boolean checkUser(String id, String email) {
        Map<String, String> params = new HashMap<>();
        params.put("id", id);
        params.put("email", email);
        return sqlSession.selectOne(namespace+"checkUser", params) != null;
    }

    public void updatePassword(String email, String encodedPassword) {
        Map<String, String> params = new HashMap<>();
        params.put("email", email);
        params.put("password", encodedPassword);
        sqlSession.update(namespace+"updatePassword", params);
    }
   
    
   // ȸ��Ż��
    @Override
    public void deleteUser(String id) {
            sqlSession.delete(namespace + "deleteUser", id);
        }
    
    // ID�ߺ�üũ
    public UserDTO selectUserById2(String id) {
        return sqlSession.selectOne(namespace + "selectUserById2", id);
    }
    
    // email �ߺ�üũ
    public int countByEmail(String email) {
    	return sqlSession.selectOne(namespace + "countByEmail",email); 
    }
    
    //���������� - ���� �ŷ���Ȳ - �ı��ۼ�
    public void insertReview(ReviewDTO review) {
        sqlSession.insert(namespace + "insertReview", review);
          
    }
  
    //���������� - ���� �ۼ��� �� ��� ��ȸ(Ư�� ������� �Խñ� ��� ��ȸ)
    public List<PostDTO> selectPostsByUserId(int user_id) {
        return sqlSession.selectList(namespace + "selectPostsByUserId", user_id);
    }
    
	//���������� - ���� �ۼ��� �ı�
	public  List<ReviewDTO> selectReviewsByUserId(int user_id) {
			return sqlSession.selectList(namespace+"selectReviewsByUserId", user_id);
	}

	//���������� - ���� �ۼ��� �ı�(����)
	  public void updateReview(int review_id, int review_rate, String review_content) {
		  sqlSession.update(namespace+"updateReview",
	  Map.of("review_id", review_id, "review_rate", review_rate, "review_content",
	  review_content)); }
	  
	//���������� - ���� �ۼ��� �ı�(����)
	  public void deleteReview(int review_id) {
		  sqlSession.delete(namespace+"deleteReview",review_id);
		}
	  
	//���������� - ���� �Ű�����
	  public List<ReportDTO> selectReportsByUserId(int user_id){
		  return sqlSession.selectList(namespace + "selectReportsByUserId", user_id);
	  }
	  
	// ���������� - ȸ����������
	public void updateUserInfo(UserDTO user) {
//	    sqlSession.updateUserInfo(namespace+"updateUserInfo",user);
	    sqlSession.update(namespace+"updateUserInfo",user);
		};
		 

	  
	  
}
