package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class AdminDAO {


	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("", "");
	public static HashMap<String, Object> SelectAdminLogin(String id, String pw) throws Exception {
			
		HashMap<String, Object> SelectMemberLogin = null;

		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "select admin_id adminId, hire_date hireDate, post from admin where admin_id =? and password = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			SelectMemberLogin = new HashMap<String, Object>();
			SelectMemberLogin.put("adminId", rs.getString("admin_id"));
			SelectMemberLogin.put("hireDate", rs.getString("hire_date"));
			SelectMemberLogin.put("post", rs.getString("post"));
		
		}
		conn.close();
		return SelectMemberLogin;
	}



}