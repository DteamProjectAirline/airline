package sjwdao;

import java.sql.*;
import java.util.*;
import kjwdao.DBHelper;

public class MyPageDAO {
	
	// 고객아이디를 받아와서 예약한 항공편의 정보 + 예약정보 
	// return : ArrayList<HashMap<String,Object>> 
	// parameter: String memberId 고객아이디 -세션에있음
	// myPage.jsp
	public static ArrayList<HashMap<String,Object>> CsReservationList (String customerId) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>() ;
		Connection conn =  DBHelper.getConnection();
		String sql = "SELECT member.nation,member.name,seat.seat_grade,seat.seat_no,"
				+ " flight.departure_time,flight.arrival_time,"
				+ " route.departure_city,route.arrival_city,route.basefare,"
				+ " plane.plane_name , plane.airline FROM seat" // select + from 끝.
				+ " RIGHT JOIN flight ON(flight.flight_id = seat.flight_id)"
				+ " RIGHT JOIN route ON(route.route_id = flight.route_id)"
				+ " RIGHT JOIN plane ON(plane.plane_id = flight.plane_id)"
				+ " RIGHT JOIN booking ON(seat.seat_id = booking.seat_id)"
				+ " RIGHT JOIN member ON(booking.member_id = member.member_id)" // join 끝
				+ " WHERE seat.seat_id in(SELECT seat_id FROM booking WHERE member_id = ?);"; // where절.
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> a = new HashMap<String,Object>();
			 a.put("nation", rs.getString("nation"));
			 a.put("name",rs.getString("member.name"));
			 a.put("seatGrade",rs.getString("seat_grade"));
			 a.put("seatNo",rs.getString("seat_no"));
			 a.put("departureCity", rs.getString("departure_city"));
			 a.put("arrivalCity", rs.getString("arrival_city"));
			 a.put("departureTime", rs.getString("departure_time"));
			 a.put("arrivalTime", rs.getString("arrival_time"));
			 a.put("planeName", rs.getString("plane_Name"));
			 a.put("airline", rs.getString("airline"));
			 list.add(a);
		}
		return list;
	}
}
