<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String type = request.getParameter("type"); //왕복편도
String departureLocation = request.getParameter("departureLocation"); //출발지
String arrivalLocation = request.getParameter("arrivalLocation"); // 도착지 or 복귀공항
String departDate = request.getParameter("departDate");  //출발일
String comeBackDate = request.getParameter("comeBackDate"); // 돌아오는날

//System.out.println(type+"왕복,편도");
//System.out.println(departureLocation+"출발지");
//System.out.println(arrivalLocation+"도착지");
//System.out.println(departDate+"출발일");
//System.out.println(comeBackDate+"복귀일 편도면 null임.");
ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>(); 
Connection conn = DBHelper.getConnection();
String sql = "SELECT route.route_id, route.departure_city, route.arrival_city, route.basefare, " +
	    	 "route.flight_duration, flight.flight_id, plane.plane_id, plane.plane_name, plane.airline, " +
	    	 "flight.departure_time, flight.arrival_time " +
	    	 "FROM route " +
	    	 "LEFT JOIN flight ON route.route_id = flight.route_id " +
	    	 "LEFT JOIN plane ON flight.plane_id = plane.plane_id " +
	    	 "WHERE route.route_id IN ( " +
	    	 "SELECT route_id FROM route WHERE departure_city = '서울' AND arrival_city = '광주' " +
	    	 ") AND DATE(flight.departure_time) = '2024-05-14' " +
	    	 "AND NOW() <= flight.departure_time;";

PreparedStatement stmt = conn.prepareStatement(sql);
ResultSet rs = stmt.executeQuery();
while(rs.next()){
	HashMap<String,Object> l = new HashMap<String,Object>();
	l.put("routeId", rs.getString("route_id"));
	l.put("departureCity", rs.getString("departure_city"));
	l.put("arrivalCity", rs.getString("arrivalCity"));
	l.put("arrivalCity", rs.getString("arrivalCity"));
	
}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<div>
	</div>
	<div>
	</div>
</div>
</body>
</html>