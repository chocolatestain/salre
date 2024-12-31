package com.salre.main.contract;

import java.io.IOException;
import java.util.Map;

public class ExcelWriterTest {
    public static void main(String[] args) {
        // ExcelWriter 인스턴스 생성
        ExcelWriter excelWriter = new ExcelWriter();

        // 데이터 준비
        Map<String, String> contractData = Map.ofEntries(
            Map.entry("payment_type", "월세"),
            Map.entry("address", "서울특별시 마포구 연남동"),
            Map.entry("deposit_CHAR", "1000만원"),
            Map.entry("deposit_INT", "10000000"),
            Map.entry("price", "500만원"),
            Map.entry("rentfee", "100만원"),
            Map.entry("manage_fee", "5만원"),
            Map.entry("contract_startdate(y)", "2023"),
            Map.entry("contract_startdate(m)", "12"),
            Map.entry("contract_startdate(d)", "01"),
            Map.entry("contract_enddate(y)", "2025"),
            Map.entry("contract_enddate(m)", "11"),
            Map.entry("contract_enddate(d)", "30"),
            Map.entry("contract_date(y)", "2024"),
            Map.entry("contract_date(m)", "01"),
            Map.entry("contract_date(d)", "15"),
            Map.entry("contract_rule1", "특약1 내용"),
            Map.entry("contract_rule2", "특약2 내용"),
            Map.entry("landlord_address", "서울 강남구"),
            Map.entry("landlord_resident_num", "123456-1234567"),
            Map.entry("landlord_phone_num", "010-1234-5678"),
           // Map.entry("landlord_name", "홍길동2"),
            Map.entry("landlord_sign", "홍길동 사인"),
            Map.entry("tenant_address", "서울 송파구"),
            Map.entry("tenant_resident_num", "765432-7654321"),
            Map.entry("tenant_phone_num", "010-8765-4321"),
            Map.entry("tenant_name", "김철수"),
            Map.entry("tenant_sign", "김철수 사인")
        );

        // 파일 경로
        String filePath = "src/main/webapp/excel/contractTmp_last.xlsx";

        // 메서드 호출
        try {
            ExcelWriter.writeContractData(filePath, contractData);
            System.out.println("엑셀 데이터 입력 완료!");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}