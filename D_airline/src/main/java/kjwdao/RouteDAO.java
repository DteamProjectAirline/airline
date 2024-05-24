package kjwdao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import kjwdao.DBHelper;

public class RouteDAO {
	
	
	//SELECT문----------
	
	//모든 노선 정보 출력 - limit함수로 행수 제한  [param]- 시작페이지, 페이지당행수 변수값 받음
	//해당하는 노선의 정보값 받아오는 쿼리
	public static ArrayList<HashMap<String, Object>> selectRouteList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql1 = "SELECT concat('RT' ,route_id) as routeId, departure_city departureCity, arrival_city arrivalCity, format(basefare,0) as basefare, "
				+ "flight_duration flightDuration, update_date updateDate, create_date createDate "
				+ "from route "
				+ "order by route_id "
				+ "limit ?,?";

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
		System.out.println("selectRouteList(모든 노선 정보 출력-limit) : " + selectRouteList);
		conn.close();

		return selectRouteList;
	}
	
	
	//모든 노선 정보 출력 
	//해당하는 노선의 정보값 받아오는 쿼리
	public static ArrayList<HashMap<String, Object>> selectAllRouteList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT concat('RT' ,route_id) as routeId, departure_city departureCity, arrival_city arrivalCity, format(basefare,0) as basefare, "
				+ "hour(flight_duration) hour, minute(flight_duration) minute , update_date updateDate, create_date createDate "
				+ "from route "
				+ "order by route_id";

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
		System.out.println("selectAllRouteList(모든 노선 정보 출력) : " + selectAllRouteList);
		conn.close();

		return selectAllRouteList;
	}
	
	//노선id에 해당하는 특정 노선 정보 출력 [param] 노선id
	public static ArrayList<HashMap<String, Object>> selectSearchRouteList(String intRouteId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		
		String sql = "SELECT concat('RT' ,route_id) as routeId, departure_city departureCity, arrival_city arrivalCity, format(basefare,0) as basefare, flight_duration flightDuration, "
				+ "hour(flight_duration) hour, minute(flight_duration) minute , update_date updateDate, create_date createDate "
				+ "from route where route_id = ? "
				+ "order by route_id";

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
		System.out.println("selectAllRouteList(노선id에 해당하는 특정 노선 정보) : " + selectAllRouteList);
		conn.close();

		return selectAllRouteList;
	}
	
	
	
	//모든 노선 정보 출력 - 해당 노선과 조인된 테이블의 관련정보까지 추출
	//출발도시-출발국가-도착도시-도착국가-노선 조인테이블
	public static ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql ="SELECT CONCAT('NA',depNA.country_id) AS departureCountryId, CONCAT('NA',arrNA.country_id) AS arrivalCountryId, "
				+ "depCT.airport departureAirport, arrCT.airport arrivalAirport, depNA.country_name departureCountryName, "
				+ "arrNA.country_name arrivalCountryName, ct.update_date cityUpdateDate, ct.create_date cityCreateDate, "
				+ "CONCAT('RT', route_id) AS routeId, rt.route_id intRouteId, rt.departure_city departureCity, rt.arrival_city arrivalCity, "
				+ "FORMAT(basefare, 0) AS basefare, HOUR(flight_duration) AS hour, MINUTE(flight_duration) AS minute, "
				+ "rt.update_date routeUpdateDate, rt.create_date routeCreateDate "
				+ "FROM city ct INNER JOIN country na ON ct.country_id = na.country_id "
				+ "LEFT OUTER JOIN route rt ON ct.city_name IN (rt.departure_city, rt.arrival_city) "
				+ "LEFT JOIN city depCT ON rt.departure_city = depCT.city_name "
				+ "LEFT JOIN country depNA ON depCT.country_id = depNA.country_id "
				+ "LEFT JOIN city arrCT ON rt.arrival_city = arrCT.city_name "
				+ "LEFT JOIN country arrNA ON arrCT.country_id = arrNA.country_id "
				+ "GROUP BY rt.route_id "
				+ "HAVING rt.route_id IS NOT NULL "
				+ "ORDER BY rt.route_id";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			//기본 int값 노선id
			m.put("intRouteId", rs.getInt("intRouteId"));
			//RT문자와 결합된 노선id
			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			//노선에 책정된 기본 운임
			m.put("basefare", rs.getString("basefare"));
			//운항시간 시간값 추출
			m.put("hour", rs.getString("hour"));
			//운항시간 분 데이터 추출
			m.put("minute", rs.getString("minute"));
			m.put("updateDate", rs.getString("routeUpdateDate"));
			m.put("createDate", rs.getString("routeCreateDate"));
			//출발도시
			m.put("departureCity", rs.getString("departureCity"));
			//도착도시
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("departureAirport", rs.getString("departureAirport"));
			m.put("arrivalAirport", rs.getString("arrivalAirport"));
			//출발국가
			m.put("departureCountry", rs.getString("departureCountryName"));
			//도착국가
			m.put("arrivalCountry", rs.getString("arrivalCountryName"));
			m.put("departureCountryId", rs.getString("departureCountryId"));
			m.put("arrivalCountryId", rs.getString("arrivalCountryId"));
			
			selectAllRouteCityCountryList.add(m);

		}
		System.out.println("selectAllRouteCityCountryList(모든 노선 정보 출력) : " + selectAllRouteCityCountryList);
		conn.close();

		return selectAllRouteCityCountryList;
	}
	
	
	//모든 노선 정보 출력 - flightManage페이지에서 항공편 정보 수정위해 항공편id를 입력하였을 때 항공편 목록 최상단에 해당하는 노선을 위치시키고 그 외 모든 노선 출력 
	//case문을 통해 해당하는 항공편이 존재하는지 여부를 flightExists 변수로 확인가능
	//출발도시-출발국가-도착도시-도착국가-노선-항공편 조인테이블
	public static ArrayList<HashMap<String, Object>> selectAllRouteCityCountryListSearchFirst(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllRouteCityCountryListSearchFirst = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		
		String sql = "SELECT DISTINCT CONCAT('NA',depNA.country_id) AS departureCountryId, "
				+ "CONCAT('NA',arrNA.country_id) AS arrivalCountryId, depCT.airport departureAirport, "
				+ "arrCT.airport arrivalAirport, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName, "
				+ "ct.update_date cityUpdateDate, ct.create_date cityCreateDate, CONCAT('RT', rt.route_id) AS routeId, "
				+ "rt.route_id intRouteId, rt.departure_city departureCity, rt.arrival_city arrivalCity, FORMAT(rt.basefare, 0) AS basefare, "
				+ "HOUR(flight_duration) AS hour, MINUTE(flight_duration) AS minute, rt.update_date routeUpdateDate, "
				+ "rt.create_date routeCreateDate, rt.flight_duration flightDuration, "
				+ "CASE "
				+ "	WHEN EXISTS(SELECT 1 FROM flight WHERE flight_id = ?) "
				+ "	THEN 'Y' "
				+ "	ELSE 'N' "
				+ "END AS flightExists "
				+ "FROM city ct INNER JOIN country na ON ct.country_id = na.country_id "
				+ "LEFT OUTER JOIN route rt ON ct.city_name IN (rt.departure_city, rt.arrival_city) "
				+ "LEFT JOIN city depCT ON rt.departure_city = depCT.city_name "
				+ "LEFT JOIN country depNA ON depCT.country_id = depNA.country_id "
				+ "LEFT JOIN city arrCT ON rt.arrival_city = arrCT.city_name "
				+ "LEFT JOIN country arrNA ON arrCT.country_id = arrNA.country_id "
				+ "LEFT JOIN flight fl ON rt.route_id = fl.route_id "
				+ "GROUP BY  depNA.country_id, arrNA.country_id, depCT.airport, arrCT.airport,depNA.country_name, "
				+ "arrNA.country_name, ct.update_date, ct.create_date, rt.route_id, rt.departure_city, rt.arrival_city, rt.basefare, "
				+ "flight_duration, rt.update_date, rt.create_date , rt.flight_duration, flightExists "
				+ "HAVING rt.route_id IS NOT NULL "
				+ "ORDER BY (rt.route_id = (SELECT route_id FROM flight WHERE flight_id = ? )) DESC, rt.route_id";	
				

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, flightId);
		stmt.setInt(2, flightId);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			//노선id 기본 int값
			m.put("intRouteId", rs.getInt("intRouteId"));
			//노선id RT문자 추가된 값
			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			//노선 기본 책정운임
			m.put("basefare", rs.getString("basefare"));
			//운항시간 시간 추출값
			m.put("hour", rs.getString("hour"));
			//운항시간 분 단위 추출값
			m.put("minute", rs.getString("minute"));
			m.put("updateDate", rs.getString("routeUpdateDate"));
			m.put("createDate", rs.getString("routeCreateDate"));
			m.put("departureAirport", rs.getString("departureAirport"));
			m.put("arrivalAirport", rs.getString("arrivalAirport"));
			m.put("departureCountry", rs.getString("departureCountryName"));
			m.put("arrivalCountry", rs.getString("arrivalCountryName"));
			m.put("departureCountryId", rs.getString("departureCountryId"));
			m.put("arrivalCountryId", rs.getString("arrivalCountryId"));
			m.put("flightDuration", rs.getString("flightDuration"));
			//항공편 존재여부 확인 Y,N값
			m.put("flightExists", rs.getString("flightExists"));
			

			selectAllRouteCityCountryListSearchFirst.add(m);

		}
		System.out.println("selectAllRouteCityCountryListSearchFirst(검색한 항공편의 노선이 첫번째 행으로. 모든 노선조회) : " + selectAllRouteCityCountryListSearchFirst);
		conn.close();

		return selectAllRouteCityCountryListSearchFirst;
	}
	
	
	
	//특정 하나의 노선 정보 출력
	//노선id를 통해 관련된 조인테이블의 정보를 추출하기위한 쿼리
	//출발도시-출발국가-도착도시-도착국가-노선-항공편 조인테이블
	public static ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList(int intRouteId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql =  "SELECT CONCAT('NA',depNA.country_id) AS departureCountryId, CONCAT('NA',arrNA.country_id) AS arrivalCountryId, depCT.airport departureAirport, "
				+ "arrCT.airport arrivalAirport, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName, ct.update_date cityUpdateDate, "
				+ "ct.create_date cityCreateDate, CONCAT('RT', route_id) AS routeId, rt.route_id intRouteId, rt.departure_city departureCity, rt.arrival_city arrivalCity, "
				+ "FORMAT(basefare, 0) AS basefare, HOUR(flight_duration) AS hour, MINUTE(flight_duration) AS minute, rt.update_date routeUpdateDate, rt.create_date routeCreateDate "
				+ "FROM city ct INNER JOIN country na ON ct.country_id = na.country_id "
				+ "LEFT OUTER JOIN route rt ON ct.city_name IN (rt.departure_city, rt.arrival_city) "
				+ "LEFT JOIN city depCT ON rt.departure_city = depCT.city_name "
				+ "LEFT JOIN country depNA ON depCT.country_id = depNA.country_id "
				+ "LEFT JOIN city arrCT ON rt.arrival_city = arrCT.city_name "
				+ "LEFT JOIN country arrNA ON arrCT.country_id = arrNA.country_id "
				+ "GROUP BY rt.route_id "
				+ "HAVING rt.route_id IS NOT null AND rt.route_id = ? "
				+ "ORDER BY rt.route_id";


		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, intRouteId);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			//노선id 기본int값
			m.put("intRouteId", rs.getInt("intRouteId"));
			//노선id RT추가된 값
			m.put("routeId", rs.getString("routeId"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			//노선에 책정된 기본 운임
			m.put("basefare", rs.getString("basefare"));
			//운항시간 시간 추출값
			m.put("hour", rs.getString("hour"));
			//운항시간 분 단위 추출값
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
	
	

	
	//전체 항공기 행수(count함수) 출력위한 쿼리  - 페이지네이션에 사용
	public static ArrayList<HashMap<String, Object>> selectTotalRouteList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalRouteList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql1 = "select count(*) cnt from route order by route_id";

		PreparedStatement stmt = conn.prepareStatement(sql1);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalRouteList.add(m);

		}
		System.out.println("selectTotalRouteList(전체 노선 행수) : " + selectTotalRouteList);
		conn.close();

		return selectTotalRouteList;
	}
	
	//INSERT문----------
	
	//노선 입력(insert)  - [param]- 출발도시, 도착도시, 노선에 책정될 기본운임, 운항시간(시간), 운항시간(분)
	public static int insertRoute(String departureCity, String arrivalCity, String basefare, String hour, String minute)
			throws Exception {

		int insertRoute = 0;

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "INSERT INTO route (departure_city, arrival_city, basefare, flight_duration, update_date, create_date ) "
				+ "VALUES (?, ?, ?, CAST(CONCAT(?, ':', ?) AS TIME), now(), now())";
		
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
	
	
	//UPDATE문----------
	
	//노선 정보변경(update)  - [param]- 출발도시, 도착도시, 노선에 책정될 기본운임, 운항시간(시간), 운항시간(분), 변경할 타겟 노선id
	public static int updateRoute(String departureCity, String arrivalCity, String basefare, String hour, String minute, String routeId)
			throws Exception {

		int updateRoute = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "update route set departure_city = ?, arrival_city = ?, basefare = ?, flight_duration = CAST(CONCAT(?, ':', ?) AS TIME), update_date = now() "
				+ "WHERE route_id = ? "; 

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
	
	
	//DELETE문----------
	
	//노선 삭제(delete)  - [param]- 항공기ID
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
