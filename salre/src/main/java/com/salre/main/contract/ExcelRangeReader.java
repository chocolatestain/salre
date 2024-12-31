package com.salre.main.contract;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellReference;

import java.io.FileInputStream;
import java.io.IOException;

public class ExcelRangeReader {

    public static String[][] readExcelRange(String excelPath) throws IOException {
        try (FileInputStream fis = new FileInputStream(excelPath);
             Workbook workbook = WorkbookFactory.create(fis)) {

            Sheet sheet = workbook.getSheetAt(0);

            // 시작 셀과 종료 셀의 행/열 계산
            CellReference startRef = new CellReference("A1"); // 예: "A1"
            CellReference endRef = new CellReference("Y53");     // 예: "Y53"

            int startRow = startRef.getRow();
            int endRow = endRef.getRow();
            int startCol = startRef.getCol();
            int endCol = endRef.getCol();

            // 범위를 읽어 2차원 배열에 저장
            String[][] rangeData = new String[endRow - startRow + 1][endCol - startCol + 1];

            for (int rowIdx = startRow; rowIdx <= endRow; rowIdx++) {
                Row row = sheet.getRow(rowIdx);
                if (row == null) continue;

                for (int colIdx = startCol; colIdx <= endCol; colIdx++) {
                    Cell cell = row.getCell(colIdx, Row.MissingCellPolicy.CREATE_NULL_AS_BLANK);
                    rangeData[rowIdx - startRow][colIdx - startCol] = cell.toString(); // 셀 데이터를 문자열로 저장
                }
            }

            return rangeData; // 2차원 배열 반환
        }
    }
}