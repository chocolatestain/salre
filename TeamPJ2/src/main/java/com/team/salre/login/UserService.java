package com.team.salre.login;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		public String findIdByEmail(String email) {
			String find_id = userDAO.findIdByEmail(email);
			System.out.println("UserService/ find Id @@@email = " + find_id);
			return find_id;
		}



		/* //--본인인증 테스트코드(블로그참고) 
		 * public static UserDTO getMember(String email){////////????? // 
		 * TODO Auto-generated method stub 
		 * return null; }
		 */
	     
	     
		//--회원탈퇴
		  public void deleteUser(String id) {
		        userDAO.deleteUser(id);
		    }
		  
		//--ID중복조회		  
		  public boolean isIdAvailable(String id) {
			  //userDAO.selectUserById2(id): null-데이터베이스에 해당 ID가 존재하지 않음 → 사용 가능한 ID./값이 있음-데이터베이스에 해당 ID가 존재함 → 중복된 ID.
		      return userDAO.selectUserById2(id) == null;
		    }



		//마이페이지 - 내가 작성한 글 목록 조회(특정 사용자의 게시글 목록 조회)
		public List<PostDTO> getPostsByUserId(int user_id) {
			   return userDAO.selectPostsByUserId(user_id);
		}

	
}
