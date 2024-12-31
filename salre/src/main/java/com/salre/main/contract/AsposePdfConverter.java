package com.salre.main.contract;

import com.aspose.cells.PdfSaveOptions;
import com.aspose.cells.Workbook;

public class AsposePdfConverter {
	 public static void convertExcelToPdf(String excelPath, String pdfPath) {
	        try {
	            // Excel 파일 로드
	        	System.out.println("pdf변환전 excel 파일로드"+excelPath);
	            Workbook workbook = new Workbook(excelPath);

	            // PDF 저장 옵션 설정
	            PdfSaveOptions saveOptions = new PdfSaveOptions();
	            saveOptions.setOnePagePerSheet(false); // 시트 크기에 따라 페이지 나누기

	            // PDF로 저장
	            workbook.save(pdfPath, saveOptions);

	            System.out.println("PDF 변환 완료: " + pdfPath);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

//	    public static void main(String[] args) {
//	        String excelPath = "C:/Users/User/git/salre/salre/src/main/webapp/excel/contractTmp_last_output.xlsx";
//	        String pdfPath = "C:/Users/User/git/salre/salre/src/main/webapp/pdf/contractTmp.pdf";
//
//	        convertExcelToPdf(excelPath, pdfPath);
//	    }
}
