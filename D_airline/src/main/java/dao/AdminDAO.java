package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;


public class AdminDAO {
	//modifyEmp페이지 들어갔을때 admin값 출력
	public static ArrayList<HashMap<String, Object>> selectAdmin(String adminId, String pw, String hireDate, String post) throws Exception{
		ArrayList<HashMap<String, Object>> selectAdmin = new ArrayList<HashMap<String, Object>>();

		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT admin_id adminId, password, hire_date hireDate, post FROM admin";
		stmt = conn.prepareStatement(sql);
		System.out.println(stmt+"<--emp정보조회");
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("adminId", rs.getString("adminId"));
			m.put("password", rs.getString("password"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("post", rs.getString("post"));
			
			selectAdmin.add(m);
		}
		conn.close();
		return selectAdmin;
	}
	
	//관리자 정보변경
	public static int modifyEmp(String adminId, String pw, String hireDate, String post) throws Exception{
		int modifyEmp = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "UPDATE admin SET password=?, hire_date hireDate=?, post=? WHERE admin_id=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pw);
		stmt.setString(2, hireDate);
		stmt.setString(3, post);
		stmt.setString(4, adminId);
		System.out.println(stmt+"<--emp정보변경");
		modifyEmp = stmt.executeUpdate();
		
		if(modifyEmp==1) {
			System.out.println("관리자정보를 변경하는데 성공하였습니다.");
		} else {
			System.out.println("관리자정보를 변경하는데 실패하였습니다.");
		}
		
		conn.close();
		return modifyEmp;
	}

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