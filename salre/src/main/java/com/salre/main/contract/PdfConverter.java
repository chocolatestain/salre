package com.salre.main.contract;

import java.io.File;
import java.io.FileInputStream;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellReference;

public class PdfConverter {

    public static void convertExcelToPdf(String excelPath, String pdfPath) throws Exception {
        try (FileInputStream fis = new FileInputStream(new File(excelPath));
             Workbook workbook = WorkbookFactory.create(fis);
             PDDocument pdfDocument = new PDDocument()) {

            Sheet sheet = workbook.getSheetAt(0);

            // Excel 범위 계산
            CellReference startRef = new CellReference("A1"); // 시작 셀
            CellReference endRef = new CellReference("Y53"); // 종료 셀

            int startRow = startRef.getRow();
            int endRow = endRef.getRow();
            int startCol = startRef.getCol();
            int endCol = endRef.getCol();

            // PDF 페이지 생성
            PDPage page = new PDPage();
            pdfDocument.addPage(page);

            // 한글 폰트 로드 (맑은 고딕)
            PDType0Font font = PDType0Font.load(pdfDocument, new File("C:/Windows/Fonts/malgun.ttf"));

            try (PDPageContentStream contentStream = new PDPageContentStream(pdfDocument, page)) {
                contentStream.setFont(font, 12); // 폰트 크기 설정
                contentStream.beginText();

                float startX = 50; // 시작 X 좌표
                float startY = 750; // 시작 Y 좌표
                float rowHeight = 15; // 행 높이
                float colWidth = 100; // 열 너비

                contentStream.newLineAtOffset(startX, startY);

                // Excel 범위 데이터를 PDF에 작성
                for (int rowIdx = startRow; rowIdx <= endRow; rowIdx++) {
                    Row row = sheet.getRow(rowIdx);
                    if (row == null) continue;

                    float currentX = startX; // 열 시작 위치
                    for (int colIdx = startCol; colIdx <= endCol; colIdx++) {
                        Cell cell = row.getCell(colIdx, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                        String cellText = sanitizeText(cell.toString());

                        // 셀 데이터 출력
                        contentStream.newLineAtOffset(currentX - startX, 0);
                        contentStream.showText(cellText.trim());

                        // 다음 열로 이동
                        currentX += colWidth;
                    }

                    // 다음 행으로 이동
                    contentStream.newLineAtOffset(0, -rowHeight);
                }

                contentStream.endText();
            }

            // PDF 저장
            pdfDocument.save(pdfPath);
            System.out.println("PDF 저장 경로: " + pdfPath);
        }
    }

    private static String sanitizeText(String text) {
        // 출력 불가능한 문자 대체
        return text.replace("\u2024", ".") // "․" → "."
                   .replace("\t", "    ") // 탭 → 4개의 공백
                   .replaceAll("[^\\p{Print}]", "?"); // 비출력 문자 → "?"로 대체
    }
}
