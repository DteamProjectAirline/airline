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
	
	
	
	public static ArrayList<HashMap<String, Object>> selectAvailablePlaneList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "SELECT fl.plane_id planeId, pl.plane_name planeName, pl.airline airline, pl.state state FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id WHERE fl.plane_id NOT IN( SELECT excluded_planeId FROM SELECT fl.plane_id excluded_planeId FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id WHERE fl.departure_time BETWEEN ? AND ? OR fl.arrival_time BETWEEN ? AND ?) AS exclude) AND pl.state = '운영가능' ORDER BY pl.plane_id";
				
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
