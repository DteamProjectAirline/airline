package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import dao.DBHelper;

public class RouteDAO {
	
	
	
	public static ArrayList<HashMap<String, Object>> selectRouteList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql1 = "SELECT concat('RT' ,route_id) as routeId, departure_city departureCity, arrival_city arrivalCity, format(basefare,0) as basefare, flight_duration flightDuration, update_date updateDate, create_date createDate from route order by route_id limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql1);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("basefare", rs.getString("basefare"));
			m.put("flightDuration", rs.getString("flightDuration"));

			selectRouteList.add(m);

		}
		System.out.println("selectRouteList(route테이블 리스트) : " + selectRouteList);
		conn.close();

		return selectRouteList;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectAllRouteList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "SELECT concat('RT' ,route_id) as routeId, departure_city departureCity, arrival_city arrivalCity, format(basefare,0) as basefare, hour(flight_duration) hour, minute(flight_duration) minute , update_date updateDate, create_date createDate from route order by route_id";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("basefare", rs.getString("basefare"));
			m.put("hour", rs.getString("hour"));
			m.put("minute", rs.getString("minute"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectAllRouteList.add(m);

		}
		System.out.println("selectAllRouteList(route테이블 전체도시 리스트) : " + selectAllRouteList);
		conn.close();

		return selectAllRouteList;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectSearchRouteList(String intRouteId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "SELECT concat('RT' ,route_id) as routeId, departure_city departureCity, arrival_city arrivalCity, format(basefare,0) as basefare, flight_duration flightDuration, hour(flight_duration) hour, minute(flight_duration) minute , update_date updateDate, create_date createDate from route where route_id = ? order by route_id";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, intRouteId);	
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			
			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("basefare", rs.getString("basefare"));
			m.put("flightDuration", rs.getString("flightDuration"));
			m.put("hour", rs.getString("hour"));
			m.put("minute", rs.getString("minute"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectAllRouteList.add(m);

		}
		System.out.println("selectAllRouteList(route테이블 전체도시 리스트) : " + selectAllRouteList);
		conn.close();

		return selectAllRouteList;
	}
	
	
	
	
	public static ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql =  "SELECT CONCAT('NA',depNA.country_id) AS departureCountryId, CONCAT('NA',arrNA.country_id) AS arrivalCountryId, depCT.airport departureAirport, arrCT.airport arrivalAirport, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName, ct.update_date cityUpdateDate, ct.create_date cityCreateDate, CONCAT('RT', route_id) AS routeId, rt.route_id intRouteId, rt.departure_city departureCity, rt.arrival_city arrivalCity, FORMAT(basefare, 0) AS basefare, HOUR(flight_duration) AS hour, MINUTE(flight_duration) AS minute, rt.update_date routeUpdateDate, rt.create_date routeCreateDate FROM city ct INNER JOIN country na ON ct.country_id = na.country_id LEFT OUTER JOIN route rt ON ct.city_name IN (rt.departure_city, rt.arrival_city) LEFT JOIN city depCT ON rt.departure_city = depCT.city_name LEFT JOIN country depNA ON depCT.country_id = depNA.country_id LEFT JOIN city arrCT ON rt.arrival_city = arrCT.city_name LEFT JOIN country arrNA ON arrCT.country_id = arrNA.country_id GROUP BY rt.route_id HAVING rt.route_id IS NOT null ORDER BY rt.route_id";


		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("intRouteId", rs.getInt("intRouteId"));
			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("basefare", rs.getString("basefare"));
			m.put("hour", rs.getString("hour"));
			m.put("minute", rs.getString("minute"));
			m.put("updateDate", rs.getString("routeUpdateDate"));
			m.put("createDate", rs.getString("routeCreateDate"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("departureAirport", rs.getString("departureAirport"));
			m.put("arrivalAirport", rs.getString("arrivalAirport"));
			m.put("departureCountry", rs.getString("departureCountryName"));
			m.put("arrivalCountry", rs.getString("arrivalCountryName"));
			m.put("departureCountryId", rs.getString("departureCountryId"));
			m.put("arrivalCountryId", rs.getString("arrivalCountryId"));
			
			
			

			selectAllRouteCityCountryList.add(m);

		}
		System.out.println("selectAllRouteCityCountryList(route,city,country 조인 테이블 리스트) : " + selectAllRouteCityCountryList);
		conn.close();

		return selectAllRouteCityCountryList;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList(int intRouteId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql =  "SELECT CONCAT('NA',depNA.country_id) AS departureCountryId, CONCAT('NA',arrNA.country_id) AS arrivalCountryId, depCT.airport departureAirport, arrCT.airport arrivalAirport, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName, ct.update_date cityUpdateDate, ct.create_date cityCreateDate, CONCAT('RT', route_id) AS routeId, rt.route_id intRouteId, rt.departure_city departureCity, rt.arrival_city arrivalCity, FORMAT(basefare, 0) AS basefare, HOUR(flight_duration) AS hour, MINUTE(flight_duration) AS minute, rt.update_date routeUpdateDate, rt.create_date routeCreateDate FROM city ct INNER JOIN country na ON ct.country_id = na.country_id LEFT OUTER JOIN route rt ON ct.city_name IN (rt.departure_city, rt.arrival_city) LEFT JOIN city depCT ON rt.departure_city = depCT.city_name LEFT JOIN country depNA ON depCT.country_id = depNA.country_id LEFT JOIN city arrCT ON rt.arrival_city = arrCT.city_name LEFT JOIN country arrNA ON arrCT.country_id = arrNA.country_id GROUP BY rt.route_id HAVING rt.route_id IS NOT null AND rt.route_id = ? ORDER BY rt.route_id";


		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, intRouteId);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			m.put("intRouteId", rs.getInt("intRouteId"));
			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("basefare", rs.getString("basefare"));
			m.put("hour", rs.getString("hour"));
			m.put("minute", rs.getString("minute"));
			m.put("updateDate", rs.getString("routeUpdateDate"));
			m.put("createDate", rs.getString("routeCreateDate"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("departureAirport", rs.getString("departureAirport"));
			m.put("arrivalAirport", rs.getString("arrivalAirport"));
			m.put("departureCountry", rs.getString("departureCountryName"));
			m.put("arrivalCountry", rs.getString("arrivalCountryName"));
			m.put("departureCountryId", rs.getString("departureCountryId"));
			m.put("arrivalCountryId", rs.getString("arrivalCountryId"));
			
			
			

			selectOneRouteCityCountryList.add(m);

		}
		System.out.println("selectOneRouteCityCountryList(route,city,country 조인 테이블 리스트-하나 노선 특정) : " + selectOneRouteCityCountryList);
		conn.close();

		return selectOneRouteCityCountryList;
	}
	
	

	
	
	public static ArrayList<HashMap<String, Object>> selectTotalRouteList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		//
		String sql1 = "select count(*) cnt from route order by route_id";

		PreparedStatement stmt = conn.prepareStatement(sql1);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalRouteList.add(m);

		}
		System.out.println("selectTotalRouteList(route테이블 전체 리스트) : " + selectTotalRouteList);
		conn.close();

		return selectTotalRouteList;
	}
	
	
	public static int insertRoute(String departureCity, String arrivalCity, String basefare, String hour, String minute)
			throws Exception {

		int insertRoute = 0;

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "INSERT INTO route (departure_city, arrival_city, basefare, flight_duration, update_date, create_date ) VALUES (?, ?, ?, CAST(CONCAT(?, ':', ?) AS TIME), now(), now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, departureCity);
		stmt.setString(2, arrivalCity);
		stmt.setString(3, basefare);
		stmt.setString(4, hour);
		stmt.setString(5, minute);
		
		
		insertRoute = stmt.executeUpdate();
		
		if (insertRoute == 1) {

			System.out.println("노선 신규 등록에 성공하였습니다.");

		} else {
			System.out.println("노선 신규등록에 실패하였습니다");
		}

		return insertRoute;
	}
	
	

	public static int updateRoute(String departureCity, String arrivalCity, String basefare, String hour, String minute, String routeId)
			throws Exception {

		int updateRoute = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "update route set departure_city = ?, arrival_city = ?, basefare = ?, flight_duration = CAST(CONCAT(?, ':', ?) AS TIME), update_date = now() WHERE route_id = ? "; 

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, departureCity);
		stmt.setString(2, arrivalCity);
		stmt.setString(3, basefare);
		stmt.setString(4, hour);
		stmt.setString(5, minute);
		stmt.setString(6, routeId);
	
		
		updateRoute = stmt.executeUpdate();
		
		if (updateRoute == 1) {

			System.out.println("노선 정보변경에 성공하였습니다.");

		} else {
			System.out.println("노선 정보변경에 실패하였습니다");
		}

		return updateRoute;
	}
	
	

	public static int deleteRoute(String routeId)
			throws Exception {

		int deleteRoute = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "DELETE FROM route WHERE route_id = ? ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, routeId);
	
		deleteRoute = stmt.executeUpdate();
		
		if (deleteRoute == 1) {

			System.out.println("노선 삭제에 성공하였습니다.");

		} else {
			System.out.println("노선 삭제에 실패하였습니다");
		}

		return deleteRoute;
	}

}
