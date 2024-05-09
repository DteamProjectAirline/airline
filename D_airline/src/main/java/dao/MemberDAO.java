package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class MemberDAO {


	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("", "");
	public static HashMap<String, Object> SelectMemberLogin(String id, String pw) throws Exception {
			
		HashMap<String, Object> SelectMemberLogin = null;

		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "select member_id memberId, name, phone, nation, birth_date birthDate, mileage where member_id =? and password = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			SelectMemberLogin = new HashMap<String, Object>();
			SelectMemberLogin.put("memberId", rs.getString("memberId"));
			SelectMemberLogin.put("name", rs.getString("name"));
			SelectMemberLogin.put("phone", rs.getString("phone"));
			SelectMemberLogin.put("nation", rs.getString("nation"));
			SelectMemberLogin.put("birthDate", rs.getString("birthDate"));
			SelectMemberLogin.put("mileage", rs.getString("mileage"));
		
		}
		conn.close();
		return SelectMemberLogin;
	}



}