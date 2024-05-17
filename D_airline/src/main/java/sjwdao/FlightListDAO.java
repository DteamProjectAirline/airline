package sjwdao;
import dao.*;
import java.util.*;

import org.apache.tomcat.util.security.KeyStoreUtil;

import java.sql.*;

public class FlightListDAO {

	// 사용자가 입력한 항공편 조회 
	// flightList1.jsp
	// reture : ArrayList<HashMap<String,Object>> list;
	// parameter (출발나라 , 도착나라 , 출발날짜)
	public static ArrayList<HashMap<String,Object>> flightList(String departureLocation , String arrivalLocation , String departDate) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT route.route_id, route.departure_city, route.arrival_city, route.basefare, " +
			    	 "route.flight_duration, flight.flight_id, plane.plane_id, plane.plane_name, plane.airline, " +
			    	 "flight.departure_time, flight.arrival_time " +
			    	 "FROM route " +
			    	 "LEFT JOIN flight ON route.route_id = flight.route_id " +
			    	 "LEFT JOIN plane ON flight.plane_id = plane.plane_id " +
			    	 "WHERE route.route_id IN ( " +
			    	 "SELECT route_id FROM route WHERE departure_city = ? AND arrival_city = ? " +
			    	 ") AND DATE(flight.departure_time) = ? " +
			    	 "AND NOW() <= flight.departure_time ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,departureLocation);
		stmt.setString(2,arrivalLocation);
		stmt.setString(3,departDate);
		//System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		                                                                                         
			while(rs.next()){                                                                                           
				HashMap<String,Object> a = new HashMap<String,Object>();                                                
					//System.out.println(rs.getString("route_id")+"routeid");                                             
					a.put("routeId"        , 		rs.getInt("route_id"));                                          
					a.put("departureCity"  , 	rs.getString("departure_city"));                                        
					a.put("arrivalCity"    , 	rs.getString("arrival_city"));                                          
					a.put("baseFare"       , 		rs.getInt("basefare"));                                          
					a.put("flightDuration" , rs.getString("flight_duration"));                                          
					a.put("flight_id"      , 		rs.getInt("flight_id"));                                         
					a.put("planeId"        , 		rs.getInt("plane_id"));                                          
					a.put("planeName"      , 		rs.getString("plane_name"));                                        
					a.put("airLine"        , 		rs.getString("airline"));                                           
					a.put("departureTime"  , 	rs.getString("departure_time"));                                        
					a.put("arrivalTime"    ,  	rs.getString("arrival_time"));                                          
					list.add(a);                                                                                        
			}
			return list;
		
	}
	
	public static ArrayList<HashMap<String,Object>> asdas(int flightId) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT COUNT(*) as cnt , seat.seat_grade , seatprice.seat_price FROM seat INNER JOIN seatprice ON seat.seat_grade = seatprice.seat_grade"
				+ " WHERE seat.flight_id = ? and seat.seat_state = 1 GROUP BY seat.seat_grade ORDER BY seatprice.seat_price";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, flightId);
		ResultSet rs = stmt.executeQuery();
		
			while(rs.next()) {
				HashMap<String,Object> a = new HashMap<String,Object>();
					a.put("cnt", rs.getInt("cnt"));
					a.put("seatGrade",rs.getString("seat_grade"));
					a.put("seatPrice",rs.getDouble("seat_price"));
					list.add(a);
			}
		return list;
	}
	
	
	
	
}
