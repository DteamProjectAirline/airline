package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SeatDAO {
	
	public static int insertSeat(int flightId , String seatGrade, int seatNo)
			throws Exception {

		int insertSeat = 0;
		Connection conn = null;
        PreparedStatement stmt = null;
		
		
		try {
		conn = DBHelper.getConnection();
		
		
		String sql = "INSERT INTO seat(flight_id, seat_grade, seat_no, update_date, create_date) VALUES( ? ,  ? , ?, NOW(), NOW())";
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
	
	
	
	
	
	
	
	
	

}
