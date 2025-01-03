package com.salre.main.contract;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.salre.main.product.ProductContractDTO;



@Service
public class ContractService {

	@Autowired
	public ContractMybatis contractDAO;
	
	// 계약 ID로 조회
    public ContractDTO getContractById(int contract_id) {
        return contractDAO.selectById(contract_id);
    }
    //매물,회원정보 조회 화면
    public void beforeContract() {
  
    }
  
    // 계약 ID로 모든 매물, 판매자조회
    public ProductContractDTO getContractPById(int contract_id) {
    	return contractDAO.selectContractPById(contract_id);
    }
    
    //계약서 변환(excel > pdf > image)
    public String processContract(Map<String,String> formData, int contract_id, String imagePath) throws Exception {
        // 1. 데이터 조회
    	ProductContractDTO contract = contractDAO.selectContractPById(contract_id);
    	System.out.println("계약서 데이터 조회완료");
        // 2. 엑셀에 데이터 입력
        Map<String, String> data = new HashMap<>();
       //(1).부동산의 표시
        data.put("payment_type", contract.getPayment_type()); //거래유형 C2
        data.put("address",contract.getAddress());//소재지
        data.put("land_type", "대");//토지 지목
        data.put("land_area", "22");//토지 면적
        data.put("building_structure", "철근콘크리트");//건물 용도
        data.put("building_usage", "다세대주택및제2종근린생활시설"); //건물 용도
        data.put("building_area", "184.1분의12.483"); //임대할 부분 건물면적
        data.put("rental_area", "3층의 제303호 전유 전부"); // 임대할부분 글자
        data.put("area",String.valueOf(contract.getArea()));//임대할부분 면적
        
        //(2).계약 내용
        data.put("deposit_INT", String.valueOf(contract.getDeposit()));//보증금 숫자
        data.put("deposit_CHAR", "금오천만원정"); //보증금 문자
        data.put("manage_fee", String.valueOf(contract.getManage_fee()));//관리비 숫자
        data.put("manage_feeCHAR","금일십오만원정"); //관리비 글자
        data.put("middle_payment", "0"); //중도금
        data.put("balance_payment", "0"); //잔금
        data.put("price", String.valueOf(contract.getPrice())); //계약금
        
        for(Map.Entry<String, String> entry: formData.entrySet()) {
        	data.put(entry.getKey(), entry.getValue());
        }
        
        System.out.println("폼 데이터 병합 완료"+data);
        
        //(3) 서명부분
        data.put("landlord_address", "경기도 시흥시 블바라 999-34");//임대인 주소
        data.put("landlord_resident_num", "951111-222222");//임대인 주민등록번호
        data.put("landlord_phone_num","010-8987-9999");//임대인 전화
        data.put("landlord_name", "이태한");//임대인 이름
        data.put("tenant_address", "서울시 마포구 블바라 239-34");//임차인 주소
        data.put("tenant_resident_num", "031211-11111");//임차인 주민등록번호
        data.put("tenant_phone_num","010-4544-9343");//임차인 전화번호
        data.put("tenant_name", "박스프링");//임차인 이름
       
        //(4) 날짜
        LocalDate today = LocalDate.now();
        Date sqlStartDate = contract.getContract_startdate();
        Date sqlEndDate = contract.getContract_enddate();
        LocalDate localStartDate = sqlStartDate.toLocalDate();
        LocalDate localEndDate = sqlEndDate.toLocalDate();
        data.put("contract_startdate(y)", String.valueOf(localStartDate.getYear()));//임대시작일(y)
        data.put("contract_startdate(m)", String.valueOf(localStartDate.getMonthValue()));//임대시작일(m)
        data.put("contract_startdate(d)",String.valueOf(localStartDate.getDayOfMonth()));//임대시작일(d)
        data.put("contract_enddate(y)", String.valueOf(localEndDate.getYear()));//임대종료일(y)
        data.put("contract_enddate(m)", String.valueOf(localEndDate.getMonthValue()));//임대종료일(m)
        data.put("contract_enddate(d)", String.valueOf(localEndDate.getDayOfMonth()));//임대종료일(d)
        data.put("contract_date(y)", String.valueOf(today.getYear())); //계약일(y)
        data.put("contract_date(m)", String.valueOf(today.getMonthValue())); //계약일(m)
        data.put("contract_date(d)", String.valueOf(today.getDayOfMonth())); //계약일(d)
        data.put("contract_date2(y)", String.valueOf(today.getYear())); //계약일(y)
        data.put("contract_date2(m)", String.valueOf(today.getMonthValue())); //계약일(m)
        data.put("contract_date2(d)", String.valueOf(today.getDayOfMonth())); //계약일(d)
        data.put("contract_rule", "임대인과 임차인은 계약에 충실한다.");//특약사항 1

        
        data.put("contract_id", String.valueOf(contract.getContract_id()));
        data.put("user_id", String.valueOf(contract.getUser_id()));
        data.put("product_id", String.valueOf(contract.getProduct_id()));
        data.put("account",String.valueOf(contract.getAccount()));
        
    	
        String excelPath = imagePath + "/excel/contractTmp_last.xlsx";
        ExcelWriter.writeContractData(excelPath, data);
      
        System.out.println("엑셀에 데이터 입력완료");
        
        // 3. PDF로 변환
        String pdfPath = imagePath + "/pdf/contractTmp.pdf";
        excelPath = imagePath + "/excel/contractTmp_last_output.xlsx";
        AsposePdfConverter.convertExcelToPdf(excelPath, pdfPath);
        
        System.out.println("pdf변환 완료");
        // 4. 이미지로 변환    C:\Users\User\git\salre\salre\src\main\webapp\images
        //String imagePath =   "/salre/src/main/webapp/resources/images/contract.png";
        String imageName  = "/resources/paperImages/" + UUID.randomUUID() + "_contract.png";
        String upload_imagePath = imagePath + imageName;
        ImageConverter.convertPdfToImage(pdfPath, upload_imagePath  );
        System.out.println("이미지로 변환 완료");
        
        return "/salre/" + imageName; // 최종 이미지 경로 반환
    }
    // 계약 생성
    public int saveContract(ContractDTO contractDTO) {
        // DB 저장 로직
        return contractDAO.saveContract(contractDTO);
    }
//    // 계약 ID로 모든 매물, 판매자조회
//    public ContractUserDTO getContractAllById(int contract_id) {
//    	return contractDAO.selectAllById(contract_id);
//    }
}

