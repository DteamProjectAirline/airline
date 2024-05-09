package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class AdminDAO {


	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("", "");
	public static HashMap<String, Object> selectAdminLogin(String id, String pw) throws Exception {
			System.out.println("[DAO진입]id : "+id);
			//System.out.println("[DAO진입]pw : "+pw);
		HashMap<String, Object> selectAdminLogin = null;

		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "select admin_id adminId, hire_date hireDate, post from admin where admin_id =? and password = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			selectAdminLogin = new HashMap<String, Object>();
			selectAdminLogin.put("adminId", rs.getString("adminId"));
			selectAdminLogin.put("hireDate", rs.getString("hireDate"));
			selectAdminLogin.put("post", rs.getString("post"));
		
		}
		conn.close();
		return selectAdminLogin;
	}



}