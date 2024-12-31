package com.salre.main.contract;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

public class ExcelWriter {

	

    public static void writeContractData(String filePath, Map<String, String> data) throws IOException {
        // 엑셀 파일 읽기
        FileInputStream fis = new FileInputStream(filePath);
        System.out.println(fis+"문서로드 완료");
        Workbook workbook = new XSSFWorkbook(fis);
        Sheet sheet = workbook.getSheetAt(0); // 첫 번째 시트 사용

        // 데이터 매핑: 데이터명과 셀 위치를 설정
        Map<String, String> cellMappings = Map.ofEntries(
        		  Map.entry("payment_type", "C2"),
                  Map.entry("address", "C5"),
                  Map.entry("land_type", "E6"),
                  Map.entry("land_area", "Q6"),
                  Map.entry("building_structure", "E7"),
                  Map.entry("building_usage", "H7"),
                  Map.entry("building_area", "Q7"),
                  Map.entry("rental_area", "C8"),
                  Map.entry("area", "Q8"),
                  Map.entry("deposit_CHAR", "C11"),
                  Map.entry("deposit_INT", "N11"),
                  Map.entry("rentfee", "C15"),
                  Map.entry("manage_feeCHAR", "E16"),
                  Map.entry("manage_fee", "N16"),
                  Map.entry("landlord_address", "D47"),
                  Map.entry("landlord_resident_num", "D48"),
                  Map.entry("landlord_phone_num", "K48"),
                  Map.entry("landlord_name", "V48"),
                  Map.entry("tenant_address", "D50"),
                  Map.entry("tenant_resident_num", "D51"),
                  Map.entry("tenant_phone_num", "K51"),
                  Map.entry("tenant_name", "V51"),
                  
                  Map.entry("price", "C12"), //INPUT
                  Map.entry("middle_payment", "C13"),//INPUT
                  Map.entry("balance_payment", "C14"),//INPUT
                  Map.entry("landlord_sign", "Y47"),//INPUT
                  Map.entry("contract_startdate(y)", "O18"),//INPUT
                  Map.entry("contract_startdate(m)", "S18"),//INPUT
                  Map.entry("contract_startdate(d)", "V18"),//INPUT
                  Map.entry("contract_enddate(y)", "H19"),//INPUT
                  Map.entry("contract_enddate(m)", "J19"),//INPUT
                  Map.entry("contract_enddate(d)", "L19"),//INPUT
                  Map.entry("contract_date(y)", "C35"),//INPUT
                  Map.entry("contract_date(m)", "E35"),//INPUT
                  Map.entry("contract_date(d)", "G35"),//INPUT
                  Map.entry("contract_date2(y)", "H46"),//INPUT
                  Map.entry("contract_date2(m)", "K46"),//INPUT
                  Map.entry("contract_date2(d)", "M46"),//INPUT
                  Map.entry("contract_rule1", "C37"),//INPUT
                  Map.entry("contract_rule2", "C38"),//INPUT
                  Map.entry("contract_rule3", "C39"),//INPUT
                  Map.entry("contract_rule4", "C40"),//INPUT
                  Map.entry("tenant_sign", "Y50")//INPUT
        );

        // 데이터를 엑셀 셀에 입력
        for (Map.Entry<String, String> entry : data.entrySet()) {
            String dataKey = entry.getKey(); // 데이터 이름
            String value = entry.getValue(); // 입력값
            String cellRef = cellMappings.get(dataKey); // 셀 위치
            
            if (cellRef != null) {
                // 셀 위치를 해석 (예: "C2" → 1행 2열)
                int rowIndex = Integer.parseInt(cellRef.replaceAll("[^0-9]", "")) - 1; // 행 번호
                int colIndex = cellRef.charAt(0) - 'A'; // 열 번호
                Row row = sheet.getRow(rowIndex);
                if (row == null) {
                    row = sheet.createRow(rowIndex);
                }
                Cell cell = row.getCell(colIndex);
                if (cell == null) {
                    cell = row.createCell(colIndex);
                }
                cell.setCellValue(value); // 셀에 값 설정
            }
        }

        // 엑셀 파일 저장
        String outputPath = "C:/Users/User/git/salre/salre/src/main/webapp/excel/contractTmp_last_output.xlsx";
        FileOutputStream fos = new FileOutputStream(outputPath);
        System.out.println("파일이 저장될 절대 경로: " + new File(outputPath).getAbsolutePath());
        workbook.write(fos);

        // 자원 정리
        fos.close();
        workbook.close();
        fis.close();
    }
}

