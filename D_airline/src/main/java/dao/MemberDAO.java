package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class MemberDAO {


	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("", "");
	public static HashMap<String, Object> selectMemberLogin(String id, String pw) throws Exception {
		System.out.println("id : "+id);
		System.out.println("pw : "+pw);
		HashMap<String, Object> selectMemberLogin = null;

		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "select member_id memberId, name, phone, nation, birth_date birthDate, mileage from member where member_id =? and password = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			selectMemberLogin = new HashMap<String, Object>();
			selectMemberLogin.put("memberId", rs.getString("memberId"));
			selectMemberLogin.put("name", rs.getString("name"));
			selectMemberLogin.put("phone", rs.getString("phone"));
			selectMemberLogin.put("nation", rs.getString("nation"));
			selectMemberLogin.put("birthDate", rs.getString("birthDate"));
			selectMemberLogin.put("mileage", rs.getInt("mileage"));
		
		}
		conn.close();
		return selectMemberLogin;
	}



}