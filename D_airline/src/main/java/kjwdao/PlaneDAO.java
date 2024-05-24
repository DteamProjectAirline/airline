package kjwdao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import kjwdao.DBHelper;

public class PlaneDAO {
	
	
	
	//SELECT문----------
	
	//항공기 테이블의 모든 항공기 정보 출력 - limit함수로 행수 제한  [param]- 시작페이지, 페이지당행수 변수값 받음
	public static ArrayList<HashMap<String, Object>> selectPlaneList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectPlaneList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT plane_id planeId, plane_name planeName, airline, state ,update_date updateDate, create_date createDate "
				+ "from plane "
				+ "limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("planeId", rs.getString("planeId"));
			m.put("planeName", rs.getString("planeName"));
			m.put("airline", rs.getString("airline"));
			//항공기 상태
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectPlaneList.add(m);

		}
		System.out.println("selectPlaneList(모든 항공기 정보) : " + selectPlaneList);
		conn.close();

		return selectPlaneList;
	}
	
	//항공기 테이블의 모든 항공기 정보 출력
	public static ArrayList<HashMap<String, Object>> selectAllPlaneList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllPlaneList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		
		String sql = "SELECT concat('PL' ,plane_id) as planeId, plane_name planeName, airline, state, update_date updateDate, create_date createDate "
				+ "from plane";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("planeId", rs.getString("planeId"));
			m.put("planeName", rs.getString("planeName"));
			m.put("airline", rs.getString("airline"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectAllPlaneList.add(m);

		}
		System.out.println("selectAllPlaneList(모든 항공기 정보) : " + selectAllPlaneList);
		conn.close();

		return selectAllPlaneList;
	}
	
	
	//전체 항공기 행수(count함수) 출력위한 쿼리  - 페이지네이션에 사용
	public static ArrayList<HashMap<String, Object>> selectTotalPlaneList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalPlaneList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql = "select count(*) cnt from plane order by plane_id";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalPlaneList.add(m);

		}
		System.out.println("selectTotalPlaneList(plane테이블 전체 리스트) : " + selectTotalPlaneList);
		conn.close();

		return selectTotalPlaneList;
	}
	
	//INSERT문----------
	
	//항공기 입력(insert)  - [param]- 항공기이름, 항공사, 항공기상태
	public static int insertPlane(String planeName, String airline, String state)
			throws Exception {

		int insertPlane = 0;

		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO plane(plane_name, airline, state, update_date, create_date) "
				+ "VALUES(?, ?, ?, now(), now())";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, planeName);
		stmt.setString(2, airline);
		stmt.setString(3, state);
		
		
		insertPlane = stmt.executeUpdate();
		
		if (insertPlane == 1) {

			System.out.println("항공기 신규 등록에 성공하였습니다.");

		} else {
			System.out.println("항공기 신규등록에 실패하였습니다");
		}

		return insertPlane;
	}
	
	
	
	//UPDATE문----------
	
	//항공기 정보변경(update)  - [param]- 항공기이름, 항공사, 항공기상태, 항공기ID
	public static int updatePlane(String planeName, String airline, String state, String planeId)
			throws Exception {

		int updatePlane = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "update plane set plane_name = ?, airline = ?, state = ?, update_date = now() "
				+ "WHERE plane_id = ? "; 

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, planeName);
		stmt.setString(2, airline);
		stmt.setString(3, state);
		stmt.setString(4, planeId);
	
		
		updatePlane = stmt.executeUpdate();
		
		if (updatePlane == 1) {

			System.out.println("항공기 정보변경에 성공하였습니다.");

		} else {
			System.out.println("항공기 정보변경에 실패하였습니다");
		}

		return updatePlane;
	}
	
	
	//DELETE문----------
	
	//항공기 삭제(delete)  - [param]- 항공기ID
	public static int deletePlane(String planeId)
			throws Exception {

		int deletePlane = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "DELETE FROM plane WHERE plane_id = ? ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, planeId);
	
		deletePlane = stmt.executeUpdate();
		
		if (deletePlane == 1) {

			System.out.println("항공기 삭제에 성공하였습니다.");

		} else {
			System.out.println("항공기 삭제에 실패하였습니다");
		}

		return deletePlane;
	}

}
