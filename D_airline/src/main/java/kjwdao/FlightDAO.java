package kjwdao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import kjwdao.DBHelper;

public class FlightDAO {
	
	
	//SELECT문----------
	
	//모든 항공편 정보 출력 - limit함수로 행수 제한  [param]- 시작페이지, 페이지당행수 변수값 받음
	//항공편 - 항공기 - 노선 - 출발도시 - 도착도시 - 출발국가 - 도착국가 테이블 조인하여 
	//해당하는 항공편의 조인된 테이블의 모든 정보값까지 받아오는 쿼리
	public static ArrayList<HashMap<String, Object>> selectFlightList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		String sql = "SELECT CONCAT('FL', fl.flight_id) AS flightId, CONCAT('RT', fl.route_id) AS routeId, DATE_FORMAT(fl.departure_time, '%Y-%m-%d %H:%i') AS departureTime, "
				+ "DATE_FORMAT(fl.arrival_time, '%Y-%m-%d %H:%i') arrivalTime1, DATE_FORMAT(ADDTIME(fl.departure_time, rt.flight_duration), '%Y-%m-%d %H:%i') AS arrivalTime2, "
				+ "CONCAT('PL', fl.plane_id) AS planeId, fl.status status, fl.update_date updateDate, fl.create_date createDate, pl.plane_name planeName, depCT.city_name departureCity, "
				+ "arrCT.city_name arrivalCity, rt.flight_duration flightDuration, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName "
				+ "FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id "
				+ "INNER JOIN route rt ON rt.route_id = fl.route_id "
				+ "INNER JOIN city depCT ON rt.departure_city = depCT.city_name "
				+ "INNER JOIN country depNA ON depCT.country_id = depNA.country_id "
				+ "INNER JOIN city arrCT ON rt.arrival_city = arrCT.city_name "
				+ "INNER JOIN country arrNA ON arrCT.country_id = arrNA.country_id "
				+ "ORDER BY fl.flight_id desc limit ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getString("flightId"));
			m.put("routeId", rs.getString("routeId"));
			m.put("departureTime", rs.getString("departureTime"));
			//항공편에 이미 입력된 도착날짜
			m.put("arrivalTime1", rs.getString("arrivalTime1"));
			//출발날짜와 노선의 운항시간의 합으로 연산된 도착날짜
			m.put("arrivalTime2", rs.getString("arrivalTime2"));
			m.put("planeId", rs.getString("planeId"));
			m.put("status", rs.getString("status"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));		
			m.put("planeName", rs.getString("planeName"));
			//출발도시
			m.put("departureCity", rs.getString("departureCity"));
			//도착도시
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("flightDuration", rs.getString("flightDuration"));
			//출발국가
			m.put("departureCountryName", rs.getString("departureCountryName"));
			//도착국가
			m.put("arrivalCountryName", rs.getString("arrivalCountryName"));

			selectFlightList.add(m);

		}
		System.out.println("selectFlightList(모든 항공편 정보 출력- limit) : " + selectFlightList);
		conn.close();

		return selectFlightList;
	}
	
	//flightId에 해당하는 항공편 관련 정보 출력(조인된 테이블 정보 포함) -  [param]- flightId 변수값 받음
	//항공편 - 항공기 - 노선 - 출발도시 - 도착도시 - 출발국가 - 도착국가 조인하여 
	//해당하는 항공편의 조인된 테이블의 모든 정보값까지 받아오는 쿼리
	//seatSelection1.jsp, seatSelection2.jsp 좌석선택 페이지에서 관련정보출력 용도로 사용됨
	public static ArrayList<HashMap<String, Object>> selectSeatPageFlightInfo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectSeatPageFlightInfo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		String sql = "SELECT date(fl.departure_time) departureTimeDate, TIME(fl.departure_time) departureTimeTime, "
				+ "date(fl.arrival_time) arrivalTimeDate, TIME(fl.arrival_time) arrivalTimeTime, depCT.city_name depCity, arrCT.city_name arrCity, "
				+ "pl.plane_name planeName, depNA.country_name depCountryName, arrNA.country_name arrCountryName "
				+ "FROM flight fl INNER JOIN route rt ON fl.route_id = rt.route_id "
				+ "INNER JOIN plane pl ON pl.plane_id = fl.plane_id "
				+ "LEFT JOIN city depCT ON depCT.city_name = rt.departure_city "
				+ "LEFT JOIN city arrCT ON arrCT.city_name = rt.arrival_city "
				+ "LEFT JOIN country depNA ON depNA.country_id = depCT.country_id "
				+ "LEFT JOIN country arrNA ON arrNA.country_id = arrCT.country_id "
				+ "WHERE fl.flight_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, flightId);


		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

				//출발날짜의 년-월-일 정보
				m.put("departureTimeDate", rs.getString("departureTimeDate"));
				//출발날짜의 시각-분 정보
				m.put("departureTimeTime", rs.getString("departureTimeTime"));
				//도착날짜의 년-월-일 정보
				m.put("arrivalTimeDate", rs.getString("arrivalTimeDate"));
				//도착날짜의 시각-분 정보
		        m.put("arrivalTimeTime", rs.getString("arrivalTimeTime"));
		        //출발도시
		        m.put("depCity", rs.getString("depCity"));
		        //도착도시
		        m.put("arrCity", rs.getString("arrCity"));
		        m.put("planeName", rs.getString("planeName"));
		        //출발국가
		        m.put("depCountryName", rs.getString("depCountryName"));
		        //도착국가
		        m.put("arrCountryName", rs.getString("arrCountryName"));

			selectSeatPageFlightInfo.add(m);

		}
		System.out.println("selectSeatPageFlightInfo(flightId에 해당하는 항공편 관련 정보 출력) : " + selectSeatPageFlightInfo);
		conn.close();

		return selectSeatPageFlightInfo;
	}
	
	
	
	//DB에 있는 모든 항공편 관련 정보 출력(조인된 테이블 정보 포함)
	//항공편 - 항공기 - 노선 - 출발도시 - 도착도시 - 출발국가 - 도착국가 조인하여 
	//해당하는 항공편의 조인된 테이블의 모든 정보값까지 받아오는 쿼리
	//flightManage 페이지에서 모든 항공편 정보 출력 용도
	public static ArrayList<HashMap<String, Object>> selectAllFlightList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT CONCAT('FL', fl.flight_id) AS flightId, CONCAT('RT', fl.route_id) AS routeId, DATE_FORMAT(fl.departure_time, '%Y-%m-%d %H:%i') AS departureTime, "
				+ "DATE_FORMAT(fl.arrival_time, '%Y-%m-%d %H:%i') arrivalTime1, DATE_FORMAT(ADDTIME(fl.departure_time, rt.flight_duration), '%Y-%m-%d %H:%i') AS arrivalTime2, "
				+ "CONCAT('PL', fl.plane_id) AS planeId, fl.status status, fl.update_date updateDate, fl.create_date createDate, pl.plane_name planeName, depCT.city_name departureCity, "
				+ "arrCT.city_name arrivalCity, rt.flight_duration flightDuration, depNA.country_name departureCountryName, arrNA.country_name arrivalCountryName "
				+ "FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id "
				+ "INNER JOIN route rt ON rt.route_id = fl.route_id "
				+ "INNER JOIN city depCT ON rt.departure_city = depCT.city_name "
				+ "INNER JOIN country depNA ON depCT.country_id = depNA.country_id "
				+ "INNER JOIN city arrCT ON rt.arrival_city = arrCT.city_name "
				+ "INNER JOIN country arrNA ON arrCT.country_id = arrNA.country_id "
				+ "ORDER BY fl.flight_id desc";
		
		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getString("flightId"));
			m.put("routeId", rs.getString("routeId"));
			m.put("departureTime", rs.getString("departureTime"));
			//항공편에 이미 입력된 도착날짜
			m.put("arrivalTime1", rs.getString("arrivalTime1"));
			//출발날짜와 노선의 운항시간의 합으로 연산된 도착날짜
			m.put("arrivalTime2", rs.getString("arrivalTime2"));
			m.put("planeId", rs.getString("planeId"));
			m.put("status", rs.getString("status"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));		
			m.put("planeName", rs.getString("planeName"));
			//출발도시
			m.put("departureCity", rs.getString("departureCity"));
			//도착도시
			m.put("arrivalCity", rs.getString("arrivalCity"));
			m.put("flightDuration", rs.getString("flightDuration"));
			//출발국가
			m.put("departureCountryName", rs.getString("departureCountryName"));
			//도착국가
			m.put("arrivalCountryName", rs.getString("arrivalCountryName"));
			
			selectAllFlightList.add(m);

		}
		System.out.println("selectAllFlightList(모든 항공편 관련 정보) : " + selectAllFlightList);
		conn.close();

		return selectAllFlightList;
	}
	
	
	//전체 항공편 행수(count함수) 출력위한 쿼리  - 페이지네이션에 사용
	public static ArrayList<HashMap<String, Object>> selectTotalFlightList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalFlightList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		
		String sql = "select count(*) cnt from flight order by flight_id";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalFlightList.add(m);

		}
		System.out.println("selectTotalFlightList(전체 항공편 행수) : " + selectTotalFlightList);
		conn.close();

		return selectTotalFlightList;
	}
	
	

	//조건에 부합하는 항공기 출력쿼리 --
	//항공편 생성시 시간과 노선을 입력하는데 그 시간에 겹치지 않는(+ 운항시간 전후로 하루씩 여유추가) 이용가능한 항공기만 선별하는 쿼리
	//[param] 년-월-일 날짜값, 시-분 시간값, 노선의 운항시간 변수값을 받음
	//항공편 - 항공기 조인 
	//서브쿼리에서 설정한 범위 내에 운항중인 항공기를 제외함
	//flightManage 페이지에서 사용가능한 항공기 정보 출력 용도
	public static ArrayList<HashMap<String, Object>> selectAvailablePlaneList(String date, String time, String flightDuration)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAvailablePlaneList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT  concat('PL',fl.plane_id) AS stringPlaneId, "
				+ "fl.plane_id planeId, pl.plane_name planeName, pl.airline airline, pl.state state "
				+ "FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id "
				+ "WHERE fl.plane_id NOT IN ( "
				+ "SELECT excluded_plane_id FROM "
				+ "( SELECT fl.plane_id AS excluded_plane_id "
				+ "FROM flight fl INNER JOIN plane pl ON fl.plane_id = pl.plane_id "
				+ "WHERE CONCAT( ?, ' ', ?, ':00') BETWEEN DATE_SUB(fl.departure_time, INTERVAL 1 DAY) AND DATE_ADD(fl.arrival_time, INTERVAL 1 DAY) "
				+ "OR ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?) BETWEEN DATE_SUB(fl.departure_time, INTERVAL 1 DAY) AND DATE_ADD(fl.arrival_time, INTERVAL 1 DAY) "
				+ "OR fl.departure_time BETWEEN DATE_SUB(CONCAT( ?, ' ', ? , ':00'), INTERVAL 1 DAY) AND  DATE_ADD(ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?), INTERVAL 1 DAY) "
				+ "OR fl.arrival_time BETWEEN DATE_SUB(CONCAT( ?, ' ', ?, ':00'), INTERVAL 1 DAY) AND  DATE_ADD(ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?), INTERVAL 1 DAY) "
				+ ")AS excluded_planes) "
				+ "AND pl.state = '운영가능' "
				+ "GROUP BY pl.plane_id "
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

			//항공기ID 에 PL문자가 붙여진 데이터
			m.put("stringPlaneId", rs.getString("stringPlaneId"));
			//기본 int값 항공기ID
			m.put("planeId", rs.getInt("planeId"));
			m.put("planeName", rs.getString("planeName"));
			m.put("airline", rs.getString("airline"));
			//항공기 상태
			m.put("state", rs.getString("state"));


			selectAvailablePlaneList.add(m);

		}
		System.out.println("selectAvailablePlaneList(조건에 부합하는 항공기 출력) : " + selectAvailablePlaneList);
		conn.close();

		return selectAvailablePlaneList;
	}
	
	//항공편에 해당하는 노선정보 출력 [param] 항공편ID
	//항공편 - 노선 - 항공기 조인
	//좌석선택 페이지에서 정보 출력 용도
	public static ArrayList<HashMap<String, Object>> selectRouteInfo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectRouteInfo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT fl.plane_id planeId, pl.plane_name planeName, fl.flight_id flightId, rt.route_id routeId, flight_duration flightDuration, "
				+ "fl.departure_time departureTime, fl.arrival_time arrivalTime, fl.status status, "
				+ "rt.departure_city departureCity, rt.arrival_city arrivalCity, rt.basefare basefare "
				+ "FROM flight fl INNER JOIN route rt ON fl.route_id = rt.route_id "
				+ "INNER JOIN plane pl ON fl.plane_id = pl.plane_id "
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
			//항공편 운항상태
			m.put("status", rs.getString("status"));
			m.put("departureCity", rs.getString("departureCity"));
			m.put("arrivalCity", rs.getString("arrivalCity"));
			//노선에 책정된 기본 운임
			m.put("basefare", rs.getString("basefare"));
			m.put("planeId", rs.getString("planeId"));
			m.put("planeName", rs.getString("planeName"));


			selectRouteInfo.add(m);

		}
		System.out.println("selectRouteInfo(항공편에 해당하는 간단 노선정보) : " + selectRouteInfo);
		conn.close();

		return selectRouteInfo;
	}
	
	
	
	//가장 최근에 입력(insert)된 항공편 정보 출력
	//flightManageAddAction.jsp에서 방금 입력된 항공편을 특정하기 위함
	public static ArrayList<HashMap<String, Object>> selectInsertedFlightLatest()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectInsertedFlightLatest = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
			
		String sql = "SELECT max(flight_id) flightId FROM flight ORDER BY create_date";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getInt("flightId"));


			selectInsertedFlightLatest.add(m);

		}
		System.out.println("selectInsertedFlightLatest(직전에 생성된 간단 항공편ID정보) : " + selectInsertedFlightLatest);
		conn.close();

		return selectInsertedFlightLatest;
	}
	
	
	
	
	//INSERT문----------
	
	//항공편 입력(insert)  - [param]- 노선id, 항공기id, 출발일(년-월-일), 출발시간(시-분), 노선에 책정된 운항시간
	//노선과 항공기 출발날짜를 입력하여 항공편 생성
	//추가로 현재 시간값과 비교하여 항공편의 운항상태를 설정
	public static int insertFlight(int intRouteId, int planeId, String date, String time, String flightDuration)
			throws Exception {

		int insertFlight = 0;

		Connection conn = DBHelper.getConnection();
	

		String sql = "INSERT INTO flight(route_id, plane_id, departure_time, arrival_time, STATUS, update_date, create_date) "
				+ "VALUES (?, ?, CONCAT(?, ' ', ?, ':00'), ADDTIME(CONCAT(?, ' ', ?, ':00'), ?), "
				+ "CASE "
				+ "WHEN CONCAT(?, ' ', ?, ':00') > NOW() THEN '이륙전' "
				+ "WHEN ADDTIME(CONCAT(?, ' ', ?, ':00'), ?) > NOW() THEN '운항중' "
				+ "ELSE '운항종료' "
				+ "END, "
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
	

	
	//UPDATE문----------
	
	//모든 항공편 status 변경(update)
	//출발날짜가 현재보다 뒤의 날짜이면 이륙전으로 변경함
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
	
	
	
	//모든 항공편 status 변경(update)
	//현재 시간이 출발날짜와 도착날짜 사이에 속하면 운항중으로 상태변경
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
	
	//모든 항공편 status 변경(update)
	//도착날짜가 현재보다 앞의 날짜이면 운항종료로 변경함
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
	

	//항공편 기본 정보 변경(update) [param] 노선id, 항공기id, 출발일(년-월-일), 출발시간(시-분), 운항시간, 변경하려는 항공편id
	//도착날짜가 현재보다 앞의 날짜이면 운항종료로 변경함
	//추가로 현재시간과 비교하여 상태에 맞는 status상태로 변경
	//flightManage페이지에서 항공편 수정시 용도
	public static int updateFlight(int intRouteId, int planeId, String date, String time, String flightDuration, int flightId)

			throws Exception {

		int updatePlane = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "UPDATE flight "
				+ "SET route_id = ?, "
				+ "plane_id = ?, "
				+ "departure_time = CONCAT( ?, ' ', ?, ':00'), "
				+ "arrival_time = ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?), "
				+ "update_date = NOW(), "
				+ "status = CASE "
				+ "	WHEN CONCAT( ?, ' ', ?, ':00') > NOW() THEN '이륙전' "
				+ " WHEN ADDTIME(CONCAT( ?, ' ', ?, ':00'), ?) < NOW() THEN '운항종료' "
				+ " ELSE '운항중' "
				+ "END "
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
	
	
	
	
	//DELETE문----------
	
	//국가 삭제(delete)  - [param]- 삭제하려는 항공편id
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
