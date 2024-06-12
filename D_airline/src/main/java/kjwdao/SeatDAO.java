package kjwdao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class SeatDAO {
	
	
	//SELECT문----------
	
	//특정 항공편(좌석에 해당하는)에 해당하는 연관된 조인 테이블의 정보 추출  [param]- 항공편id
	//좌석-좌석가격-항공편-항공기-노선-출발도시-출발국가-도착도시-도착국가 테이블 조인
	//좌석선택 페이지에서 해당하는 좌석 항공편의 관련된 정보 추출용도
	public static ArrayList<HashMap<String, Object>> selectSelectedFlightInfo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectSelectedFlightInfo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT st.create_date createDate, SUM(seat_state) totalCountAvailableSeat,"
				+ "fl.flight_id flightId, CONCAT('FL', fl.flight_id) StringFlightId, fl.departure_time departureTime,fl.arrival_time arrivalTime, fl.status STATUS,"
				+ "pl.plane_id planeId, CONCAT('PL', pl.plane_id) StringPlaneId, pl.plane_name planeName, pl.airline airline, pl.state planeState,"
				+ "rt.basefare basefare, rt.flight_duration flightDuration,"
				+ "depCT.city_name depCityName, arrCt.city_name arrCityName, depCT.airport depAirport, arrCT.airport arrairport,"
				+ "depNA.country_id depCountryId, CONCAT('NA', depNA.country_id) StringDepCountryId, arrNa.country_id arrCountryId, CONCAT('NA',arrNA.country_id) StringArrCountryId,"
				+ "depNA.country_name depCountryName, arrNA.country_name arrCountryName "
				+ "FROM seat st INNER JOIN flight fl ON st.flight_id = fl.flight_id "
				+ "LEFT OUTER JOIN seatprice sp ON st.seat_grade = sp.seat_grade "
				+ "LEFT OUTER JOIN plane pl ON fl.plane_id = pl.plane_id "
				+ "LEFT OUTER JOIN route rt ON rt.route_id = fl.route_id "
				+ "LEFT OUTER JOIN city depCT ON depCT.city_name = rt.departure_city "
				+ "LEFT OUTER JOIN city arrCT ON arrCT.city_name = rt.arrival_city "
				+ "LEFT OUTER JOIN country depNA ON depNA.country_id = depCT.country_id "
				+ "LEFT OUTER JOIN country arrNA ON arrNA.country_id = arrCT.country_id "
				+ "WHERE fl.flight_id = ? "
				+ "ORDER BY st.seat_id";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,flightId);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getInt("flightId"));
			//현재 이용 가능한 좌석수
			m.put("totalCountAvailableSeat", rs.getInt("totalCountAvailableSeat"));
			m.put("createDat", rs.getString("createDate"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime", rs.getString("arrivalTime"));
			//항공편 운항상태
			m.put("status", rs.getString("status"));
			m.put("planeId", rs.getInt("planeId"));
			m.put("planeName", rs.getString("planeName"));
			m.put("airline", rs.getString("airline"));
			//항공기 상태
			m.put("planeState", rs.getString("planeState"));
			//노선에 책정된 기본운임
			m.put("basefare", rs.getInt("basefare"));
			m.put("flightDuration", rs.getString("flightDuration"));
			m.put("depCityName", rs.getString("depCityName"));
			m.put("arrCityName", rs.getString("arrCityName"));
			m.put("depAirport", rs.getString("depAirport"));
			m.put("arrAirport", rs.getString("arrAirport"));
			m.put("depCountryId", rs.getInt("depCountryId"));
			m.put("arrCountryId", rs.getInt("arrCountryId"));
			m.put("depCountryName", rs.getString("depCountryName"));
			m.put("arrCountryName", rs.getString("arrCountryName"));
			//항공편id값에 FL문자열 추가
			m.put("stringFlightId", rs.getString("stringFlightId"));
			//항공기id값에 PL문자열 추가
			m.put("stringPlaneId", rs.getString("stringPlaneId"));
			//출발국가id값에 NA문자열 추가
			m.put("stringDepCountryId", rs.getString("stringDepCountryId"));
			//도착국가 id값에 NA문자열 추가
			m.put("stringArrCountryId", rs.getString("stringArrCountryId"));
			
			

			selectSelectedFlightInfo.add(m);

		}
		System.out.println("selectSelectedFlightInfo(특정 항공편 관련 정보) : " + selectSelectedFlightInfo);
		conn.close();

		return selectSelectedFlightInfo;
	}
	
	//좌석에 해당하는 정보  [param]- 항공편id
	//좌석-좌석가격-항공편 테이블 조인
	//좌석선택 페이지에서 테이블 구조에 뿌려질 좌석넘버 및 grade(일등석,비지니스,일반석)정보 추출용
	public static ArrayList<HashMap<String, Object>> selectSeatNo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectSeatNo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT st.seat_id seatId, CONCAT('ST', st.seat_id) stringSeatId, fl.flight_id flightId, CONCAT('FL', fl.flight_id) stringFlightId, st.seat_grade seatGrade, "
				+ "st.seat_no seatNo, st.seat_state seatState, st.update_date updateDate, st.create_date createDate, "
				+ "fl.route_id routeId, CONCAT('RT', fl.route_id) stringRouteId, fl.plane_id planeId, CONCAT('PL', fl.plane_id) stringPlaneId, fl.departure_time departureTime, "
				+ "fl.arrival_time arrivalTime, fl.status flightStatus, sp.seat_price seatPrice "
				+ "FROM seat st INNER JOIN flight fl on st.flight_id = fl.flight_id "
				+ "INNER JOIN seatprice sp ON sp.seat_grade = st.seat_grade "
				+ "WHERE fl.flight_id = ? "
				+ "ORDER BY st.seat_id";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,flightId);
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			//좌석id int값
			m.put("seatId", rs.getInt("seatId"));
			//좌석id ST문자열 추가
			m.put("stringSeatId", rs.getString("stringSeatId"));
			//항공편id int값
			m.put("flightId", rs.getInt("flightId"));
			//항공편id FL문자열 추가
			m.put("stringFlightId", rs.getString("stringFlightId"));
			//좌석등급(퍼스트클래스,비지니스,이코노미)
			m.put("seatGrade", rs.getString("seatGrade"));
			m.put("seatNo", rs.getInt("seatNo"));
			//좌석 사용 유무(0은 사용중, 1은 사용가능)
			m.put("seatState", rs.getString("seatState"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			//노선id int값
			m.put("routeId", rs.getInt("routeId"));
			//노선id RT문자열 추가
			m.put("stringRouteId", rs.getString("stringRouteId"));
			//항공기id int값
			m.put("planeId", rs.getInt("planeId"));
			//항공기id PL문자열 추가
			m.put("stringPlaneId", rs.getString("stringPlaneId"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime", rs.getString("arrivalTime"));
			//항공편 상태(이륙전,운항중,운항종료)
			m.put("flightStatus", rs.getString("flightStatus"));
			//좌석에 매겨진 가격
			m.put("seatPrice", rs.getDouble("seatPrice"));
			
			
	
			selectSeatNo.add(m);

		}
		System.out.println("selectSeatNo(좌석 테이블 정보) : " + selectSeatNo);
		conn.close();

		return selectSeatNo;
	}
	
	
	//UPDATE문----------
	
	//노선 정보변경(update)  - [param]- 해당하는 항공편id, 좌석등급, 좌석번호
	//항공편이 추가되면 할당된 수만큼 시스템적으로 좌석이 생성됨
	//try catch finally 문법 사용하여 DB입력시 예외상황에 대해 대처하도록함
	public static int insertSeat(int flightId , String seatGrade, int seatNo)
			throws Exception {

		int insertSeat = 0;
		Connection conn = null;
        PreparedStatement stmt = null;
		
		try {
		conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO seat(flight_id, seat_grade, seat_no, seat_state, update_date, create_date)"
				+ "VALUES(?, ?, ?, "
				+ "	CASE "
				+ "	WHEN RAND() < 0.5 THEN 0 "
				+ "	ELSE 1 "
				+ "END, "
				+ "NOW(), NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, flightId);
		stmt.setString(2, seatGrade);
		stmt.setInt(3, seatNo);
		
		
		insertSeat = stmt.executeUpdate();
		
		if (insertSeat == 1) {

			System.out.println("FL"+flightId+"항공편의 "+seatNo+ "좌석("+seatGrade+") 신규 등록에 성공하였습니다.");

		} else {
			System.out.println("FL"+flightId+"항공편의 "+seatNo+ "좌석("+seatGrade+") 신규 등록에 실패하였습니다.");
		}

		
		} catch (SQLException e) {
	            e.printStackTrace();
	            throw new Exception("Database insertion error", e);
	           
	            
		} finally {
			if(stmt != null) {
				stmt.close();
					
			}else if(conn != null) {
				conn.close();
			}
		}
		
		return insertSeat;
	}
	
	
	//UPDATE문----------
	
	//좌석상태 변경 쿼리 [param] 좌석id 변수로받음 
	//seatManage 페이지에서 사용가능상태인 좌석을 사용중인 상태로 변경
	public static int updateSeatState(int seatId)
			throws Exception {

		int updateSeatState = 0;

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "UPDATE seat SET seat_state = 0 WHERE seat_id = ?";
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,  seatId);
		updateSeatState = stmt.executeUpdate();
		
		if (updateSeatState == 1) {

			System.out.println("좌석상태 변경(이용가능 -- > 사용불가)");

		} else {
			System.out.println("좌석 상태변경 실패");
		}

		return updateSeatState;
	}
	
}
