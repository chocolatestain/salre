package com.team.salre.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class UserDAO implements UserDAOInterface {

	@Autowired
	private SqlSession sqlSession;
	String namespace = "com.team.salre.login.UserDAOInterface.";

	// 회원가입
	public int insertUser(UserDTO user) {
		int result = sqlSession.insert(namespace + "insertUser", user);
		return result;
	}

	// 로그인 용범씨코드 기준.. UserService 파일의 user.setPassword(password); 용범씨 부분 참고
	/*
	 * public UserDTO selectUserById(String id, String password) {
	 * Map<String,Object> paramMap = new HashMap<String, Object>();
	 * System.out.println("id : " + id); System.out.println("password : " +
	 * password); paramMap.put("id", id); //첫 번째 값 paramMap.put("password",
	 * password); // 두 번째 값 return return sqlSession.selectOne(namespace +
	 * "selectUserById", paramMap); }
	 */

//    로그인 테스트코드 Map아니고 DTO로 가능..???????????
//    public UserDTO selectUserById(String id, String password) {
//        UserDTO userParam = new UserDTO();
//        userParam.setId(id);  // DTO의 id 설정
//        userParam.setPassword(password);  // DTO의 password 설정
//        return sqlSession.selectOne(namespace + "selectUserById", userParam);
//    }
	
	//로그인
	public UserDTO selectUserById(String id) {
	    return sqlSession.selectOne(namespace + "selectUserById", id);
	}


	
	// ID찾기
    public String findIdByEmail(String email) {
    	System.out.println("UserDAO/ email = " + email);
    	
    	String find_id = sqlSession.selectOne(namespace + "findIdByEmail", email);
    	System.out.println("UserDAO/ find Id @@@email = " + find_id);
    	return find_id;
        //return userMapper.findIdByEmail(email);
    }
    
   // 회원탈퇴
    @Override
    public void deleteUser(String id) {
            sqlSession.delete(namespace + "deleteUser", id);
        }
    
    // ID중복체크
    public UserDTO selectUserById2(String id) {
        return sqlSession.selectOne(namespace + "selectUserById2", id);
    }
  
    //마이페이지 - 내가 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
    public List<PostDTO> selectPostsByUserId(int user_id) {
        return sqlSession.selectList(namespace + "selectPostsByUserId", user_id);
    }
    

	

	
}
