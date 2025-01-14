package com.salre.main.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.salre.main.myPage.LikeDTO;
import com.salre.main.myPage.PostDTO;
import com.salre.main.myPage.ReportDAO;
import com.salre.main.myPage.ReportDTO;
import com.salre.main.myPage.ReviewDTO;
import com.salre.main.product.ProductDTO;

import at.favre.lib.crypto.bcrypt.BCrypt;

@Service
public class UserService {

	@Autowired
	@Qualifier("UserDAO")
	public UserDAO userDAO;
	@Autowired
	public ReportDAO reportDAO;
	// --ȸ������
	public int registerUser(UserDTO user) {
		// ��й�ȣ ��ȣȭ
		String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
		user.setPassword(hashedPassword); // ��ȣȭ�� ��й�ȣ�� ����

		// DB�� ����
		return userDAO.insertUser(user);
	}

	// admin-handleBoardReport
	public List<ReportDTO> getBoardReportsByUserId(int user_id) {
		return userDAO.getBoardReportsByUserId(user_id);
	}

	// �α���
	public UserDTO loginUser(String id, String password) {
		// 1. ID�� ����� ��ȸ
		UserDTO user = userDAO.selectUserById(id);
		if (user == null) {
			return null; // ����� ������ ������ �α��� ����
		}

		// 2. ��й�ȣ ����
		boolean isPasswordMatch = at.favre.lib.crypto.bcrypt.BCrypt.verifyer()
				.verify(password.toCharArray(), user.getPassword()).verified;

		if (isPasswordMatch) {
			// ��й�ȣ ���� ����: ��й�ȣ�� null�� �����Ͽ� ��ȯ
			user.setPassword(null);
			return user;
		}

		// ��й�ȣ ���� ����
		return null;
	}

	// --���̵� ã��
	public String findIdByEmailAndName(String email, String name) {
		String find_id = userDAO.findIdByEmailAndName(email, name);
		System.out.println("UserService/ find Id @@@email = " + find_id);
		return find_id;

	}

	// --PWã��
	@Autowired
	private JavaMailSender mailSender;

	private final Map<String, String> verificationCodes = new HashMap<>();

	public boolean validateUser(String id, String email) {
		return userDAO.checkUser(id, email);
	}

	public void generateVerificationCode(String email) {// ������ȣ ���� �� �߼�
		String verificationCode = String.valueOf(new Random().nextInt(900000) + 100000);
		verificationCodes.put(email, verificationCode);
		sendEmail(email, "[살래?]비밀번호 찾기 인증코드", "인증코드: " + verificationCode);
	}

	public boolean verifyCode(String email, String verificationCode) {// ������ȣ Ȯ��
		return verificationCode.equals(verificationCodes.get(email));
	}

	public void updatePassword(String email, String newPassword) {// ��й�ȣ ��ȣȭ �� ������Ʈ
		String encodedPassword = new BCryptPasswordEncoder().encode(newPassword);
		userDAO.updatePassword(email, encodedPassword);
	}

	private void sendEmail(String to, String subject, String body) {// �̸��� �߼�
		SimpleMailMessage message = new SimpleMailMessage(); // �̸��� �޽����� ����
		message.setTo(to);// �̸��� ������ �ּҸ� ����
		message.setSubject(subject);// �̸��� ������ ����
		message.setText(body);// �̸��� ������ ����
		mailSender.send(message);// ������ �̸��� �޽����� �߼�..mailSender�� JavaMailSender ��ü�̸�, ���� ����
									// ������ ������� �̸����� �߼�
	}

	// --ȸ��Ż��
	public void deleteUser(String id) {
		userDAO.deleteUser(id);
	}

	// --ID�ߺ���ȸ
	public boolean isIdAvailable(String id) {
		// userDAO.selectUserById2(id): null-�����ͺ��̽��� �ش� ID�� �������� ���� �� ���
		// ������ ID./���� ����-�����ͺ��̽��� �ش� ID�� ������ �� �ߺ��� ID.
		return userDAO.selectUserById2(id) == null;
	}

	public boolean isEmailAvailable(String email) {
		int count = userDAO.countByEmail(email);
		return count == 0;
	}

	// 마이페이지 - 나의 거래현황 목록 조회(구매자)
	public List<ProductDTO> getBuyerTransactionByUserId(int user_id) {
		return userDAO.getBuyerTransactionByUserId(user_id);
	}

	// 마이페이지 - 나의 거래현황 목록 조회
	public List<ProductDTO> getTransactionByUserId(int user_id) {
		return userDAO.getTransactionByUserId(user_id);
	}

	// ���������� - ���� �ŷ���Ȳ - �ı��ۼ�
	public void registerReview(ReviewDTO review) {
		userDAO.insertReview(review);
	}

	// 마이페이지 - 나의 관심매물
	public List<ProductDTO> getFavoritesByUserId(int user_id) {
		return userDAO.getFavoritesByUserId(user_id);
	}
	
	//testcode
	//마이페이지 - 나의 관심매물추가  
	/*
	 * public ResponseEntity<String> toggleLike(@RequestBody LikeDTO likeDTO) {
	 * boolean updatedStatus = userService.toggleLike(likeDTO); return
	 * ResponseEntity.ok(updatedStatus ? "Liked" : "Unliked"); }
	 */
	
	//마이페이지 - 나의 관심매물추가
	public void insertFavorite(LikeDTO userlike) {
		userDAO.insertFavorite(userlike); 
	  }
	
	//마이페이지 - 나의 관심매물상태변경(1>0) 
	public void updateFavorite(LikeDTO userlike) {
		//System.out.println("userlike user_id : " + userlike.getUser_id());
		//System.out.println("userlike product_id : " + userlike.getProduct_id());
		
		 userDAO.updateFavorite(userlike);
	}
	
	
	//마이페이지 - 나의 관심매물삭제  
	public void deleteFavorite(LikeDTO userlike) {
		userDAO.deleteFavorite(userlike); 
	  }
	 

	// ���������� - ���� �ۼ��� �� ��� ��ȸ(Ư�� ������� �Խñ� ��� ��ȸ)
	public List<PostDTO> getPostsByUserId(int user_id) {
		return userDAO.selectPostsByUserId(user_id);
	}

	// ���������� - ���� �ۼ��� �ı�
	public List<ReviewDTO> getMyreviewsByUserId(int user_id) {
		return userDAO.selectReviewsByUserId(user_id);
	}

	// 마이페이지 - 나의거래현황 - 거래완료 - 리뷰작성
//	public boolean isReviewWritten(int user_id, int product_id) {
//	    return userDAO.checkReviewExists(user_id, product_id);
//	}
	public boolean isReviewWritten(ReviewDTO reviewDTO) {
		return userDAO.checkReviewExists(reviewDTO);
	}

	
	// ���������� - ���� �ۼ��� �ı�(����)
	public void updateReview(int review_id, int review_rate, String review_content) {
		userDAO.updateReview(review_id, review_rate, review_content);
	}

	// ���������� - ���� �ŷ��ı�(����)
	public void deleteReview(int review_id) {
		userDAO.deleteReview(review_id);
	}

	// ���������� - ���� �Ű�����
	public List<ReportDTO> getMyreportsByUserId(int user_id) {
		return userDAO.selectReportsByUserId(user_id);
	}
	public  void addReport(int user_id,int product_id,String report_content,int report_class)  {
		 reportDAO.addReport(user_id, product_id, report_content, report_class);
	}
	
	// ���������� - ȸ����������
	public void updateUserInfo(UserDTO user) {
		userDAO.updateUserInfo(user);
	};

	// 추가
	public UserDTO getUserById(int user_id) {
		return userDAO.selectById(user_id);
	}
	

	//admin-매물신고내역조회
	public List<ReportDTO> getAdminPropertiesReportsByReportClass(int report_class) {
		return userDAO.selectAdminPropertiesReportsByReportClass(report_class);
	}
	//admin-신고처리무효화
	public void updateReportStatus(int report_id, String status) {
		userDAO.updateReportStatus(report_id, status);
	}
	//admin-매물삭제  
	public void deletePropertyById(int product_id) {
		userDAO.deletePropertyById(product_id);
	}

}
