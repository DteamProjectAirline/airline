package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class SeatDAO {
	
	public static int insertSeat(int flightId , String seatGrade, int seatNo)
			throws Exception {

		int insertSeat = 0;
		Connection conn = null;
        PreparedStatement stmt = null;
		
		
		try {
		conn = DBHelper.getConnection();
		
		
		String sql = "INSERT INTO seat(flight_id, seat_grade, seat_no, seat_state, update_date, create_date)\r\n"
				+ "VALUES(?, ?, ?, \r\n"
				+ "	CASE \r\n"
				+ "	WHEN RAND() < 0.5 THEN 0 \r\n"
				+ "	ELSE 1 \r\n"
				+ "END, \r\n"
				+ "NOW(), NOW())\r\n";
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
	
	
	public static ArrayList<HashMap<String, Object>> selectSelectedFlightInfo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectSelectedFlightInfo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT st.create_date createDate, SUM(seat_state) totalCountAvailableSeat,\r\n"
				+ "fl.flight_id flightId, CONCAT('FL', fl.flight_id) StringFlightId, fl.departure_time departureTime,fl.arrival_time arrivalTime, fl.status STATUS,\r\n"
				+ "pl.plane_id planeId, CONCAT('PL', pl.plane_id) StringPlaneId, pl.plane_name planeName, pl.airline airline, pl.state planeState,\r\n"
				+ "rt.basefare basefare, rt.flight_duration flightDuration,\r\n"
				+ "depCT.city_name depCityName, arrCt.city_name arrCityName, depCT.airport depAirport, arrCT.airport arrairport,\r\n"
				+ "depNA.country_id depCountryId, CONCAT('NA', depNA.country_id) StringDepCountryId, arrNa.country_id arrCountryId, CONCAT('NA',arrNA.country_id) StringArrCountryId,"
				+ "depNA.country_name depCountryName, arrNA.country_name arrCountryName\r\n"
				+ "FROM seat st INNER JOIN flight fl ON st.flight_id = fl.flight_id\r\n"
				+ "LEFT OUTER JOIN seatprice sp ON st.seat_grade = sp.seat_grade\r\n"
				+ "LEFT OUTER JOIN plane pl ON fl.plane_id = pl.plane_id\r\n"
				+ "LEFT OUTER JOIN route rt ON rt.route_id = fl.route_id\r\n"
				+ "LEFT OUTER JOIN city depCT ON depCT.city_name = rt.departure_city\r\n"
				+ "LEFT OUTER JOIN city arrCT ON arrCT.city_name = rt.arrival_city\r\n"
				+ "LEFT OUTER JOIN country depNA ON depNA.country_id = depCT.country_id\r\n"
				+ "LEFT OUTER JOIN country arrNA ON arrNA.country_id = arrCT.country_id\r\n"
				+ "WHERE fl.flight_id = ? \r\n"
				+ "ORDER BY st.seat_id";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,flightId);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("flightId", rs.getInt("flightId"));
			m.put("totalCountAvailableSeat", rs.getInt("totalCountAvailableSeat"));
			m.put("createDat", rs.getString("createDate"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime", rs.getString("arrivalTime"));
			m.put("status", rs.getString("status"));
			m.put("planeId", rs.getInt("planeId"));
			m.put("planeName", rs.getString("planeName"));
			m.put("airline", rs.getString("airline"));
			m.put("planeState", rs.getString("planeState"));
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
			m.put("stringFlightId", rs.getString("stringFlightId"));
			m.put("stringPlaneId", rs.getString("stringPlaneId"));
			m.put("stringDepCountryId", rs.getString("stringDepCountryId"));
			m.put("stringArrCountryId", rs.getString("stringArrCountryId"));
			
			

			selectSelectedFlightInfo.add(m);

		}
		System.out.println("selectSelectedFlightInfo(좌석Manage페이지에서 선택된 항공편ID정보) : " + selectSelectedFlightInfo);
		conn.close();

		return selectSelectedFlightInfo;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectSeatNo(int flightId)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectSeatNo = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT st.seat_id seatId, CONCAT('ST', st.seat_id) stringSeatId, fl.flight_id flightId, CONCAT('FL', fl.flight_id) stringFlightId, st.seat_grade seatGrade, st.seat_no seatNo, st.seat_state seatState, st.update_date updateDate, st.create_date createDate, \r\n"
				+ "fl.route_id routeId, CONCAT('RT', fl.route_id) stringRouteId, fl.plane_id planeId, CONCAT('PL', fl.plane_id) stringPlaneId, fl.departure_time departureTime, fl.arrival_time arrivalTime, fl.status flightStatus, sp.seat_price seatPrice\r\n"
				+ "FROM seat st INNER JOIN flight fl on st.flight_id = fl.flight_id\r\n"
				+ "INNER JOIN seatprice sp ON sp.seat_grade = st.seat_grade \r\n"
				+ "WHERE fl.flight_id = ?\r\n"
				+ "ORDER BY st.seat_id";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,flightId);
		
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("seatId", rs.getInt("seatId"));
			m.put("stringSeatId", rs.getString("stringSeatId"));
			m.put("flightId", rs.getInt("flightId"));
			m.put("stringFlightId", rs.getString("stringFlightId"));
			m.put("seatGrade", rs.getString("seatGrade"));
			m.put("seatNo", rs.getInt("seatNo"));
			m.put("seatState", rs.getString("seatState"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			m.put("routeId", rs.getInt("routeId"));
			m.put("stringRouteId", rs.getString("stringRouteId"));
			m.put("planeId", rs.getInt("planeId"));
			m.put("stringPlaneId", rs.getString("stringPlaneId"));
			m.put("departureTime", rs.getString("departureTime"));
			m.put("arrivalTime", rs.getString("arrivalTime"));
			m.put("flightStatus", rs.getString("flightStatus"));
			m.put("seatPrice", rs.getDouble("seatPrice"));
			
			
			

			selectSeatNo.add(m);

		}
		System.out.println("selectSeatNo(좌석 테이블 정보) : " + selectSeatNo);
		conn.close();

		return selectSeatNo;
	}
	
	
	
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
