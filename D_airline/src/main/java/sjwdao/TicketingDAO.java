package sjwdao;

import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBHelper;

public class TicketingDAO {

	// 인서트 예약기능
	// parameter : int memberId , int seatId , String refundPeriod , String bookingState , String paymentAmount , String luggage , String ticketType
	// ticketingPage.jsp
	// return row = 1 or 0 인서트 성공 1 실패 0
	public static int Ticketing(int memberId , int seatId , String refundPeriod , String bookingState , String paymentAmount , String luggage , String ticketType  ) throws Exception{
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO(member_id,seat_id,refund_period,booking_date,booking_state,payment_amount,luggage,ticket_type)"
				+ " VALUES(?,?,?,now(),?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, 0);  // 멤버아이디 
		stmt.setInt(2, 0);  // 좌석번호
		stmt.setString(3, sql); // 환불기간 = 탑승일 전날까지 당일에는 환불불가.
		stmt.setString(4, sql); // 부킹날짜
		stmt.setString(5, sql); // 예약상태
		stmt.setInt(6, 0); // 요금
		stmt.setString(7, sql); // 수화물 여부
		stmt.setString(8, sql); //티켓타입
		int row = stmt.executeUpdate();
		stmt.close();
		conn.close();
		return row;
	}
	
	// 항공편 조회 
	// ticketingPage.jsp
	// parameter flightId <- 조회할 항공편 정보
	// return 리스트 정보 
	public static ArrayList<HashMap<String,Object>> selectFlighInf(String flightId1) throws Exception{
		Connection conn = DBHelper.getConnection();
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		String sql = "SELECT flight.departure_time ,flight.arrival_time,plane.plane_name , plane.airline FROM flight LEFT JOIN plane ON flight.plane_id = plane.plane_id "
				 +   " WHERE flight.flight_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, flightId1);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
		HashMap<String,Object> l = new HashMap<String,Object>();
			l.put("departureTime",rs.getString("departure_time"));
			l.put("arrivalTime",rs.getString("arrival_time"));
			l.put("planeName",rs.getString("plane_name"));
			l.put("airline", rs.getString("airline"));
			list.add(l);
		}
		stmt.close();
		conn.close();
		return list;
	}
		
	
	// 예매되면 좌석상태 예약으로 바뀜.
	// 호출 ticketingPageAction.jsp
	// parameter 좌석 아이디 seatId	
	// return row 업데이트 성공 1 실패 0
	public static int seatState(int seatId  ) throws Exception{
			Connection conn = DBHelper.getConnection();
			String sql = "UPDATE seat SET seat_state=0 WHERE seat_id=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			int row = stmt.executeUpdate();
			conn.close();
			stmt.close();
			return row;
	}	
	
	public static int baseFare(String flightId1) throws Exception{
			int baseFare = 0;
			Connection conn = DBHelper.getConnection();
			String sql = "SELECT route.basefare FROM flight INNER JOIN route ON flight.route_id = route.route_id WHERE flight.flight_id = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, flightId1);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				baseFare = rs.getInt("baseFare");
			}
		return baseFare;
	}
	
	public static double grade(String seatGrade1) throws Exception{
		Connection conn = DBHelper.getConnection();
		double grade = 0;
		String sql ="SELECT seat_price FROM seatprice WHERE seat_grade = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, seatGrade1);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			 grade = rs.getDouble("seat_price");
		}
		return grade;
		
	}
}
	




