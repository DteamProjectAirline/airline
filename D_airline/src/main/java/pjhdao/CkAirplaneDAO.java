package pjhdao;

import java.sql.*;
import java.util.*;

import kjwdao.DBHelper;

public class CkAirplaneDAO {
	//사용자가 입력한 출도착 조회
	public static ArrayList<HashMap<String, Object>> ckList(String departureLocation, String arrivalLocation, String departDate) throws Exception{
		ArrayList<HashMap<String, Object>> ckList = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
			String sql = "SELECT route.route_id, route.departure_city, route.arrival_city, route.basefare, " +
			    	 "route.flight_duration, flight.flight_id, plane.plane_id, plane.plane_name, plane.airline, " +
			    	 "flight.departure_time, flight.arrival_time, flight.status " +
			    	 "FROM route " +
			    	 "LEFT JOIN flight ON route.route_id = flight.route_id " +
			    	 "LEFT JOIN plane ON flight.plane_id = plane.plane_id " +
			    	 "WHERE route.route_id IN ( " +
			    	 "SELECT route_id FROM route WHERE departure_city = ? AND arrival_city = ? " +
			    	 ") AND DATE(flight.departure_time) = ? " +
			    	 "AND NOW() <= flight.departure_time ";

			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,departureLocation);
			stmt.setString(2,arrivalLocation);
			stmt.setString(3,departDate);
			
			System.out.println(stmt+"<--stmt");
			rs = stmt.executeQuery();
			
			while(rs.next()){                                                                                           
				HashMap<String,Object> m = new HashMap<String,Object>();                                                
					//System.out.println(rs.getString("route_id")+"routeid");                                             
					m.put("routeId"        , 		rs.getInt("route_id"));                                          
					m.put("departureCity"  , 	rs.getString("departure_city"));                                        
					m.put("arrivalCity"    , 	rs.getString("arrival_city"));                                          
					m.put("baseFare"       , 		rs.getInt("basefare"));                                          
					m.put("flightDuration" , rs.getString("flight_duration"));                                          
					m.put("flightId"      , 		rs.getInt("flight_id"));                                         
					m.put("planeId"        , 		rs.getInt("plane_id"));                                          
					m.put("planeName"      , 		rs.getString("plane_name"));                                        
					m.put("airline"        , 		rs.getString("airline"));                                           
					m.put("departureTime"  , 	rs.getString("departure_time"));                                        
					m.put("arrivalTime"    ,  	rs.getString("arrival_time"));       
					m.put("status"         ,  	rs.getString("status"));  
					
					ckList.add(m);                                                                                        
			}
		
			conn.close();
			return ckList;
	}
}
