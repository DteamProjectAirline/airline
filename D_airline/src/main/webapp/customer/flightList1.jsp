<%@page import="sjwdao.FlightListDAO"%>
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

/* System.out.println(type+"왕복,편도");
System.out.println(departureLocation+"출발지");
System.out.println(arrivalLocation+"도착지");
System.out.println(departDate+"출발일");
System.out.println(comeBackDate+"복귀일 편도면 null임."); */ 

// 항공편 리스트 불러오는 메소드;
ArrayList<HashMap<String,Object>> list = FlightListDAO.flightList(departureLocation, arrivalLocation, departDate);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- </head> -->
<body>


<h1>리스트</h1>
		<table border=1>
		<%for(HashMap<String,Object> e : list) {
		
		%>
		<tr>
			
	<td><%=(String) (e.get("routeId"       ))%> </td>
	<td><%=(String) (e.get("departureCity" ))%> </td>
	<td><%=(String) (e.get("arrivalCity"   ))%> </td>
	<td><%=(String) (e.get("baseFare"      ))%> </td>
	<td><%=(String) (e.get("flightDuration"))%> </td>
	<td><%=(String) (e.get("flight_id"     ))%> </td>
	<td><%=(String) (e.get("planeId"       ))%> </td>
	<td><%=(String) (e.get("planeName"     ))%> </td>
	<td><%=(String) (e.get("airLine"       ))%> </td>
	<td><%=(String) (e.get("departureTime" ))%> </td>
	<td><%=(String) (e.get("arrivalTime"   ))%> </td>  
			
			
			
			
		</tr>
		<%} %>
		</table>
	<div>
		<div>
		<ul style="list-style:none;">
			<li style="display: flex; border: 0px; border-radius:15px; box-shadow: 0;">
				<div style=" width: 500px;padding: 0; border: solid #d9dbe1; border-top-left-radius: 15px; border-bottom-right-radius: 15px; min-height: 272px;">
					<div style=" padding: 3.2rem 2.4rem 3rem;background-color: #black ;border-radius: 1rem;">
						여기인가?
					</div>
				</div>
			
			</li>
		</ul>	
		</div>
	</div>



</body>
</html>