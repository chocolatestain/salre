package com.salre.main.contract;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Locale;
import java.util.Map;
import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

public class ContractPaper {
	@RequestMapping(value = "/makePaper.do", method = RequestMethod.POST)
	public void makeContractPaper(HttpServletRequest request, HttpServletResponse response, Locale locale, Model model)
			throws Exception {
		String fileName = "contractPaper.xlsx";
		String userId = "";
		HttpSession session = request.getSession();
		userId = (String) session.getAttribute("SESSION_USER_ID");

		// ÇÁ·ÎÁ§Æ® ¾È¿¡ ¿¢¼¿ ¾ç½ÄÀ» ³Ö¾îµÒ
		String path = this.getClass().getClassLoader().getResource("").getPath();
		String fullPath = URLDecoder.decode(path, "UTF-8");
		String pathArr[] = fullPath.split("/WEB-INF/classes/");
		fullPath = pathArr[0] + "/WEB-INF/views/contractPaper";
		String reponsePath = "";

		// ±âº» ¾ç½Ä ¿¢¼¿ ÆÄÀÏÀ» º¹»çÇÑ´Ù.
		String baseFolder = new File(fullPath).getPath() + File.separatorChar;
		String baseFileName = "contractPaper.xlsx";
		String outFileName = "contractPaper_" + userId + ".xlsx";
		reponsePath = baseFolder + outFileName;
		fileCopy(baseFolder + baseFileName, reponsePath);

		File file = new File(reponsePath);
		InputStream workFileInputStream = new FileInputStream(reponsePath);
		Workbook wb = WorkbookFactory.create(workFileInputStream);
		Sheet sheet = wb.getSheetAt(0);

		// ¿¢¼¿¿¡ ³»¿ë ÀÔ·ÂÇÏ±â
		JSONArray jsonDataArray = new JSONArray(request.getParameter("param").toString());
		int iLength = jsonDataArray.length();
		for (int rownum = 0; rownum < iLength; rownum++) {
			Row row = sheet.createRow(rownum + 4);
			JSONObject jsonObject = jsonDataArray.getJSONObject(rownum);
			Map<String, Object> map = JsonUtil.JsonToMap(jsonObject.toString());

			String value = "";

			value = ("null".equals(String.valueOf(map.get("listNo"))) ? "" : String.valueOf(map.get("listNo")));
			row.createCell(0).setCellValue(value);

			value = ("null".equals(String.valueOf(map.get("listPreqNo"))) ? "" : String.valueOf(map.get("listPreqNo")));
			row.createCell(1).setCellValue(value);

			value = ("null".equals(String.valueOf(map.get("listBillingDate"))) ? ""
					: String.valueOf(map.get("listBillingDate")));
			row.createCell(2).setCellValue(value);

			value = ("null".equals(String.valueOf(map.get("listBillingGubun"))) ? ""
					: String.valueOf(map.get("listBillingGubun")));
			row.createCell(3).setCellValue(value);

			value = ("null".equals(String.valueOf(map.get("listSiteCd"))) ? "" : String.valueOf(map.get("listSiteCd")));
			row.createCell(4).setCellValue(value);
		}

		// ¿¢¼¿¿¡ ¾²±â
		FileOutputStream fileOut = new FileOutputStream(reponsePath);
		wb.write(fileOut);
		fileOut.close();

		// ¿¢¼¿ ´Ù¿î·Îµå Ã³¸®
		FileInputStream fileInputStream = null;
		ServletOutputStream servletOutputStream = null;

		try {
			String downName = null;
			String browser = request.getHeader("User-Agent");

			// ÆÄÀÏ ÀÎÄÚµù
			if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
				downName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			} else {
				downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			}

			response.setHeader("Content-Disposition", "attachment;filename=\"" + downName + "\"");
			response.setContentType("application/octer-stream");
			response.setHeader("Content-Transfer-Encoding", "binary;");

			fileInputStream = new FileInputStream(file);
			servletOutputStream = response.getOutputStream();

			byte[] b = new byte[1024];
			int data;
			while ((data = fileInputStream.read(b, 0, b.length)) != -1) {
				servletOutputStream.write(b, 0, data);
			}

			servletOutputStream.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (servletOutputStream != null) {
				servletOutputStream.close();
			}
			if (fileInputStream != null) {
				fileInputStream.close();
			}
		}
	}

	public static void fileCopy(String inFileName, String outFileName) {
		try {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);

			int data;
			while ((data = fis.read()) != -1) {
				fos.write(data);
			}

			fis.close();
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	


	public static class JsonUtil {
	    public static Map<String, Object> JsonToMap(String jsonString) throws IOException {
	        ObjectMapper mapper = new ObjectMapper();
	        return mapper.readValue(jsonString, Map.class);
	    }
	}
}
