package com.salre.main.login;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

// �׽�Ʈ Service ����.. �������� ���α�

@Service
public class SignUpService {
	private static String impKey = "imp74358381";
	private static String impSecret = "qgNu6fc4TSvhlM064OnoUI7L9L5VAFcacvog2ilCmiyq8C6xLbB6XnOyYNNyksDrzoMx3KN5DgKaoUaA";

	public static HashMap getAccessToken(String impUid) {
//	public HashMap getAccessToken(String impUid) {
		HashMap map = new HashMap<>();
		System.out.println("impUid");
		
		String strUrl = "https://api.iamport.kr/users/getToken"; // ��ū ��û ���� �ּ�
		String access_token = "";
		String phone = "";
		String name = "";

		try {
			URL url = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // url Http ���� ����

			// POST ��û
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);// outputStreamm���� post �����͸� �ѱ�

			conn.setRequestProperty("content-Type", "application/json");
			conn.setRequestProperty("Accept", "application/json");

			// �Ķ���� ����
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

			JSONObject requestData = new JSONObject();
			requestData.put("imp_key", impKey);
			requestData.put("imp_secret", impSecret);

			bw.write(requestData.toString());
			bw.flush();
			bw.close();

			int resposeCode = conn.getResponseCode();

			System.out.println("�����ڵ� =============" + resposeCode);
			if (resposeCode == 200) {// ����
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				StringBuilder sb = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line + "\n");
				}

				br.close();

				// ��ū �� ����
				String response = sb.toString();
				JsonParser parser = new JsonParser();
				JsonObject responseJson = parser.parse(response).getAsJsonObject();
				access_token = responseJson.getAsJsonObject("response").get("access_token").getAsString();
				System.out.println("Access Token: " + access_token);

				// ���������� ��� ���� ������
				String getPaymentUrl = "https://api.iamport.kr/certifications/" + impUid;
				HttpURLConnection getConn = (HttpURLConnection) new URL(getPaymentUrl).openConnection();
				getConn.setRequestMethod("GET");
				getConn.setRequestProperty("Content-Type", "application/json");
				getConn.setRequestProperty("Authorization", "Bearer " + access_token);

				int getResponseCode = getConn.getResponseCode();
				System.out.println("GET �����ڵ� =============" + getResponseCode);

				if (getResponseCode == 200) { // ����
					BufferedReader getBr = new BufferedReader(new InputStreamReader(getConn.getInputStream()));
					StringBuilder getResponseSb = new StringBuilder();
					String getLine;
					while ((getLine = getBr.readLine()) != null) {
						getResponseSb.append(getLine).append("\n");
					}
					getBr.close();

					String getResponse = getResponseSb.toString();
					System.out.println("GET ���� ���: " + getResponse);
					JsonParser parser1 = new JsonParser();
					JsonObject phoneJson1 = parser1.parse(getResponse).getAsJsonObject();

					// ��ȭ��ȣ �� ����
					phone = phoneJson1.getAsJsonObject("response").get("phone").getAsString();
					System.out.println("phone: " + phone);

					map.put("phone", phone);
					// �̸� �� ����
					name = phoneJson1.getAsJsonObject("response").get("name").getAsString();
					System.out.println("�̸�>>>>>" + name);
					map.put("name", name);

				} else {
					System.out.println("GET ���� ���� �޽���: " + getConn.getResponseMessage());
				}
			} else {
				System.out.println(conn.getResponseMessage());
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return map;
	}

}
