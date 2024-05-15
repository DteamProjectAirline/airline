package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import dao.DBHelper;

public class FlightDAO {
	
	
	
	public static ArrayList<HashMap<String, Object>> selectFlightList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "SELECT CONCAT('FL', fl.flight_id) AS flightId, CONCAT('RT', fl.route_id) AS routeId, DATE_FORMAT(fl.departure_time, '%Y-%m-%d %H:%i') AS departureTime, DATE_FORMAT(fl.arrival_time, '%Y-%m-%d %H:%i') arrivalTime1, DATE_FORMAT(ADDTIME(fl.departure_time, rt.flight_duration), '%Y-%m-%d %H:%i') AS arrivalTime2, CONCAT('PL', fl.plane_id) AS planeId, fl.status status, fl.update_date updateDate, fl.create_date createDate, pl.plane_name planeName, depCT.city_name departureCity, arrCT.city_name arrivalCity, rt.flight_duration flightDuration, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id INNER JOIN route rt ON rt.route_id = fl.route_id INNER JOIN city depCT ON rt.departure_city = depCT.city_name INNER JOIN country depNA ON depCT.country_id = depNA.country_id INNER JOIN city arrCT ON rt.arrival_city = arrCT.city_name INNER JOIN country arrNA ON arrCT.country_id = arrNA.country_id ORDER BY fl.flight_id desc limit ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getString("flightId"));
			m.put("routeId", rs.getString("routeId"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime1", rs.getString("arrivalTime1"));
			m.put("arrivalTime2", rs.getString("arrivalTime2"));
			m.put("planeId", rs.getString("planeId"));
			m.put("status", rs.getString("status"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));		
			m.put("planeName", rs.getString("planeName"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("flightDuration", rs.getString("flightDuration"));
			m.put("departureCountryName", rs.getString("departureCountryName"));
			m.put("arrivalCountryName", rs.getString("arrivalCountryName"));

			selectFlightList.add(m);

		}
		System.out.println("selectFlightList(flight테이블 리스트) : " + selectFlightList);
		conn.close();

		return selectFlightList;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectAllFlightList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "SELECT CONCAT('FL', fl.flight_id) AS flightId, CONCAT('RT', fl.route_id) AS routeId, DATE_FORMAT(fl.departure_time, '%Y-%m-%d %H:%i') AS departureTime, DATE_FORMAT(fl.arrival_time, '%Y-%m-%d %H:%i') arrivalTime1, DATE_FORMAT(ADDTIME(fl.departure_time, rt.flight_duration), '%Y-%m-%d %H:%i') AS arrivalTime2, CONCAT('PL', fl.plane_id) AS planeId, fl.status status, fl.update_date updateDate, fl.create_date createDate, pl.plane_name planeName, depCT.city_name departureCity, arrCT.city_name arrivalCity, rt.flight_duration flightDuration, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id INNER JOIN route rt ON rt.route_id = fl.route_id INNER JOIN city depCT ON rt.departure_city = depCT.city_name INNER JOIN country depNA ON depCT.country_id = depNA.country_id INNER JOIN city arrCT ON rt.arrival_city = arrCT.city_name INNER JOIN country arrNA ON arrCT.country_id = arrNA.country_id ORDER BY fl.flight_id desc";
		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getString("flightId"));
			m.put("routeId", rs.getString("routeId"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime1", rs.getString("arrivalTime1"));
			m.put("arrivalTime2", rs.getString("arrivalTime2"));
			m.put("planeId", rs.getString("planeId"));
			m.put("status", rs.getString("status"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));		
			m.put("planeName", rs.getString("planeName"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("flightDuration", rs.getString("flightDuration"));
			m.put("departureCountryName", rs.getString("departureCountryName"));
			m.put("arrivalCountryName", rs.getString("arrivalCountryName"));
			
			selectAllFlightList.add(m);

		}
		System.out.println("selectAllFlightList(flight테이블 전체도시 리스트) : " + selectAllFlightList);
		conn.close();

		return selectAllFlightList;
	}
	
	
	

	
	
	public static ArrayList<HashMap<String, Object>> selectTotalFlightList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		//
		String sql = "select count(*) cnt from flight order by flight_id";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalFlightList.add(m);

		}
		System.out.println("selectTotalFlightList(flight테이블 전체 리스트) : " + selectTotalFlightList);
		conn.close();

		return selectTotalFlightList;
	}
	
	
	
	public static ArrayList<HashMap<String, Object>> selectAvailablePlaneList(String date, String time, String flightDuration)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAvailablePlaneList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT  concat('PL',fl.plane_id) AS stringPlaneId,  \r\n"
				+ "fl.plane_id planeId, pl.plane_name planeName, pl.airline airline, pl.state state \r\n"
				+ "FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id \r\n"
				+ "WHERE fl.plane_id NOT IN ( \r\n"
				+ "SELECT excluded_plane_id FROM\r\n"
				+ "( SELECT fl.plane_id AS excluded_plane_id \r\n"
				+ "FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id \r\n"
				+ "WHERE CONCAT( ?, ' ', ?, ':00') BETWEEN DATE_SUB(fl.departure_time, INTERVAL 1 DAY) AND DATE_ADD(fl.arrival_time, INTERVAL 1 DAY)\r\n"
				+ "OR ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?) BETWEEN DATE_SUB(fl.departure_time, INTERVAL 1 DAY) AND DATE_ADD(fl.arrival_time, INTERVAL 1 DAY)\r\n"
				+ "OR fl.departure_time BETWEEN DATE_SUB(CONCAT( ?, ' ', ? , ':00'), INTERVAL 1 DAY) AND  DATE_ADD(ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?), INTERVAL 1 DAY) \r\n"
				+ "OR fl.arrival_time BETWEEN DATE_SUB(CONCAT( ?, ' ', ?, ':00'), INTERVAL 1 DAY) AND  DATE_ADD(ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?), INTERVAL 1 DAY) \r\n"
				+ ")AS excluded_planes) \r\n"
				+ "AND pl.state = '운영가능' \r\n"
				+ "GROUP BY pl.plane_id \r\n"
				+ "ORDER BY pl.plane_id";
		
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, date);
		stmt.setString(2, time);
		stmt.setString(3, date);
		stmt.setString(4, time);
		stmt.setString(5, flightDuration);
		stmt.setString(6, date);
		stmt.setString(7, time);
		stmt.setString(8, date);
		stmt.setString(9, time);
		stmt.setString(10, flightDuration);
		stmt.setString(11, date);
		stmt.setString(12, time);
		stmt.setString(13, date);
		stmt.setString(14, time);
		stmt.setString(15, flightDuration);
		


		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("stringPlaneId", rs.getString("stringPlaneId"));
			m.put("planeId", rs.getInt("planeId"));
			m.put("planeName", rs.getString("planeName"));
			m.put("airline", rs.getString("airline"));
			m.put("state", rs.getString("state"));


			selectAvailablePlaneList.add(m);

		}
		System.out.println("selectAvailablePlaneList(입력 가능한 항공기 테이블 항공기 리스트) : " + selectAvailablePlaneList);
		conn.close();

		return selectAvailablePlaneList;
	}
	
	public static ArrayList<HashMap<String, Object>> selectRouteInfo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectRouteInfo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT fl.plane_id planeId, pl.plane_name planeName, fl.flight_id flightId, rt.route_id routeId, flight_duration flightDuration,\r\n"
				+ "fl.departure_time departureTime, fl.arrival_time arrivalTime, fl.status status,\r\n"
				+ "rt.departure_city departureCity, rt.arrival_city arrivalCity, rt.basefare basefare\r\n"
				+ "FROM flight fl INNER JOIN route rt ON fl.route_id = rt.route_id\r\n"
				+ "INNER JOIN plane pl ON fl.plane_id = pl.plane_id\r\n"
				+ "WHERE fl.flight_id = ?";
		
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, flightId);
	
		


		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getString("flightId"));
			m.put("routeId", rs.getInt("routeId"));
			m.put("flightDuration", rs.getString("flightDuration"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime", rs.getString("arrivalTime"));
			m.put("status", rs.getString("status"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("basefare", rs.getString("basefare"));
			m.put("planeId", rs.getString("planeId"));
			m.put("planeName", rs.getString("planeName"));


			selectRouteInfo.add(m);

		}
		System.out.println("selectRouteInfo(항공편에 해당하는 간단 노선정보) : " + selectRouteInfo);
		conn.close();

		return selectRouteInfo;
	}
	
	
	

	public static int insertFlight(int intRouteId, int planeId, String date, String time, String flightDuration)
			throws Exception {

		int insertFlight = 0;

		Connection conn = DBHelper.getConnection();
	

		String sql = "INSERT INTO flight(route_id, plane_id, departure_time, arrival_time, STATUS, update_date, create_date)\r\n"
				+ "VALUES (?, ?, CONCAT(?, ' ', ?, ':00'), ADDTIME(CONCAT(?, ' ', ?, ':00'), ?),\r\n"
				+ "CASE\r\n"
				+ "WHEN CONCAT(?, ' ', ?, ':00') > NOW() THEN '이륙전'\r\n"
				+ "WHEN ADDTIME(CONCAT(?, ' ', ?, ':00'), ?) > NOW() THEN '운항중'\r\n"
				+ "ELSE '운항종료'\r\n"
				+ "END,\r\n"
				+ "NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, intRouteId);
		stmt.setInt(2, planeId);
		stmt.setString(3, date);
		stmt.setString(4, time);
		stmt.setString(5, date);
		stmt.setString(6, time);
		stmt.setString(7, flightDuration);
		stmt.setString(8, date);
		stmt.setString(9, time);
		stmt.setString(10, date);
		stmt.setString(11, time);
		stmt.setString(12, flightDuration);
		
		
		insertFlight = stmt.executeUpdate();
		
		if (insertFlight == 1) {

			System.out.println("항공편 신규 등록에 성공하였습니다.");

		} else {
			System.out.println("항공편 신규등록에 실패하였습니다");
		}

		return insertFlight;
	}
	

	

	public static int updateFlightStatusBeforeTakeOff()
			throws Exception {

		int updateFlightStatusBeforeTakeOff = 0;

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "UPDATE flight SET status = '이륙전' WHERE departure_time > NOW()";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		
		
		
		updateFlightStatusBeforeTakeOff = stmt.executeUpdate();
		
		if (updateFlightStatusBeforeTakeOff == 1) {

			System.out.println("항공편 상태변경(이륙전)");

		} else {
			System.out.println("항공편 상태변경(이륙전)실패");
		}

		return updateFlightStatusBeforeTakeOff;
	}
	
	
	
	
	public static int updateFlightStatusInOperation()
			throws Exception {

		int updateFlightStatusInOperation = 0;

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "UPDATE flight SET status = '운항중' WHERE departure_time <= NOW() AND arrival_time > NOW()"; 
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		
		
		
		updateFlightStatusInOperation = stmt.executeUpdate();
		
		if (updateFlightStatusInOperation == 1) {

			System.out.println("항공편 상태변경(운항중)");

		} else {
			System.out.println("항공편 상태변경(운항중)실패");
		}

		return updateFlightStatusInOperation;
	}
	
	
	public static int updateFlightStatusEnded()
			throws Exception {

		int updateFlightStatusEnde = 0;

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "UPDATE flight SET STATUS = '운항종료' WHERE arrival_time <= NOW()";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		
		
		
		updateFlightStatusEnde = stmt.executeUpdate();
		
		if (updateFlightStatusEnde == 1) {

			System.out.println("항공편 상태변경(운항종료)");

		} else {
			System.out.println("항공편 상태변경(운항종료)실패");
		}

		return updateFlightStatusEnde;
	}
	
	
	public static int updateFlight(int intRouteId, int planeId, String date, String time, String flightDuration, int flightId)

			throws Exception {

		int updatePlane = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "UPDATE flight \r\n"
				+ "SET route_id = ?, \r\n"
				+ "plane_id = ?, \r\n"
				+ "departure_time = CONCAT( ?, ' ', ?, ':00'), \r\n"
				+ "arrival_time = ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?), \r\n"
				+ "update_date = NOW(),\r\n"
				+ "status = CASE \r\n"
				+ "	WHEN CONCAT( ?, ' ', ?, ':00') > NOW() THEN '이륙전'\r\n"
				+ " WHEN ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?) < NOW() THEN '운항종료'\r\n"
				+ " ELSE '운항중'\r\n"
				+ "END\r\n"
				+ "WHERE flight_id = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, intRouteId);
		stmt.setInt(2, planeId);
		stmt.setString(3, date);
		stmt.setString(4, time);
		stmt.setString(5, date);
		stmt.setString(6, time);
		stmt.setString(7, flightDuration);
		stmt.setString(8, date);
		stmt.setString(9, time);
		stmt.setString(10, date);
		stmt.setString(11, time);
		stmt.setString(12, flightDuration);
		stmt.setInt(13, flightId);
	
		
		updatePlane = stmt.executeUpdate();
		
		if (updatePlane == 1) {

			System.out.println("항공편 정보변경에 성공하였습니다.");

		} else {
			System.out.println("항공편 정보변경에 실패하였습니다");
		}

		return updatePlane;
	}
	
	
	
	

	public static int deleteFlight(String flightId)
			throws Exception {

		int deleteFlight = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "DELETE FROM flight WHERE flight_id = ? ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, flightId);
	
		deleteFlight = stmt.executeUpdate();
		
		if (deleteFlight == 1) {

			System.out.println("항공편 삭제에 성공하였습니다.");

		} else {
			System.out.println("항공편 삭제에 실패하였습니다");
		}

		return deleteFlight;
	}

}
